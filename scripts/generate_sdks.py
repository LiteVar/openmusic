import json
import os
import re
import shutil
import subprocess
import sys
from importlib.metadata import version
from pathlib import Path
from tempfile import TemporaryDirectory

import yaml
from openapi_spec_validator import validate


ROOT = Path(__file__).resolve().parents[1]
BUILD = ROOT / ".build"
GENERATOR_VERSION = "7.27.0"
SDK_VERSION = "0.1.0"
CLI = [sys.executable, "-c", "from openapi_generator_cli import cli; raise SystemExit(cli())"]


def replace_once(path, old, new):
    content = path.read_text(encoding="utf-8")
    if content.count(old) != 1:
        raise RuntimeError(f"Generator output changed for {path}")
    path.write_text(content.replace(old, new, 1), encoding="utf-8")


def generate(package, generator, config, source):
    options = ",".join(f"{key}={value}" for key, value in config.items())
    package.mkdir()
    ignore = package / ".openapi-generator-ignore"
    shutil.copyfile(ROOT / "scripts" / "generator.ignore", ignore)
    names = ["--name-mappings", "boolean=boolean"] if generator == "typescript-fetch" else []
    log = BUILD / f"generate-{package.name}.log"
    with log.open("w", encoding="utf-8") as output:
        result = subprocess.run(
            [
                *CLI, "generate", "-i", str(source), "-g", generator, "-o", str(package),
                "--global-property", "apiDocs=false,modelDocs=false,apiTests=false,modelTests=false",
                "--additional-properties", options, *names,
            ],
            stdout=output,
            stderr=subprocess.STDOUT,
            check=False,
        )
    if result.returncode:
        raise RuntimeError(log.read_text(encoding="utf-8"))
    ignore.unlink()


def prepare_package(language, package, repository):
    readme = (
        f"# OpenMusic {language} SDK\n\n"
        "Generated from the OpenMusic v1 OpenAPI specification. Configure your service URL "
        "and bearer token before calling the API.\n\n"
        f"[Source repository]({repository}) · [MIT License](LICENSE)\n"
    )
    (package / "README.md").write_text(readme, encoding="utf-8")
    shutil.copyfile(ROOT / "LICENSE", package / "LICENSE")


def prepare_typescript(package, repository):
    manifest = package / "package.json"
    metadata = json.loads(manifest.read_text(encoding="utf-8"))
    metadata.pop("author", None)
    metadata["description"] = "OpenMusic v1 TypeScript client"
    metadata["files"] = ["dist"]
    metadata["license"] = "MIT"
    metadata["repository"] = {
        "type": "git",
        "url": f"git+{repository}.git",
        "directory": "sdk/typescript",
    }
    manifest.write_text(json.dumps(metadata, indent=2) + "\n", encoding="utf-8")


def prepare_python(package, repository):
    manifest = package / "pyproject.toml"
    replace_once(
        manifest,
        'Repository = "https://github.com/GIT_USER_ID/GIT_REPO_ID"',
        f'Repository = "{repository}"',
    )
    replace_once(
        manifest,
        'authors = [\n  {name = "OpenAPI Generator Community",email = "team@openapitools.org"},\n]\n',
        "",
    )
    replace_once(
        manifest,
        'license = { text = "MIT" }\n',
        'license = "MIT"\nlicense-files = ["LICENSE"]\n',
    )
    replace_once(manifest, 'requires = ["setuptools"]', 'requires = ["setuptools>=77.0.3"]')
    # Include successful audio media types in the default Accept header.
    replace_once(
        package / "openmusic_sdk" / "api_client.py",
        "        for accept in accepts:\n            if re.search('json', accept, re.IGNORECASE):",
        '        if any(accept.startswith("audio/") for accept in accepts):\n'
        '            return ", ".join(accepts)\n\n'
        "        for accept in accepts:\n            if re.search('json', accept, re.IGNORECASE):",
    )


def prepare_dart(package, repository):
    shutil.copyfile(ROOT / "CHANGELOG.md", package / "CHANGELOG.md")
    manifest = package / "pubspec.yaml"
    replace_once(manifest, "homepage: homepage\n", f"repository: {repository}\n")
    replace_once(manifest, "sdk: '>=3.5.0 <4.0.0'", "sdk: '>=3.9.0 <4.0.0'")
    replace_once(manifest, "json_annotation: '^4.9.0'", "json_annotation: '^4.12.0'")
    replace_once(manifest, "json_serializable: '^6.9.3'", "json_serializable: '6.15.2'")
    replace_once(manifest, "build_runner: any", "build_runner: '2.17.1'")
    api = package / "lib" / "src" / "api" / "music_api.dart"
    replace_once(api, "import 'package:openmusic_sdk/src/model/error_response.dart';\n", "")
    replace_once(
        api,
        ".replaceAll('{' r'model_id' '}', modelId.toString())",
        ".replaceAll('{' r'model_id' '}', Uri.encodeComponent(modelId))",
    )
    replace_once(
        package / "lib" / "src" / "model" / "provider_extensions.dart",
        "Map<String, Map<String, Object>>?",
        "Map<String, Map<String, Object?>>?",
    )
    dart = os.environ.get("OPENMUSIC_DART", "dart")
    env = dict(os.environ, DART_SUPPRESS_ANALYTICS="true")
    env.setdefault("PUB_CACHE", str(BUILD / "pub-cache"))
    pub_get = [dart, "pub", "get"]
    if env.get("OPENMUSIC_PUB_OFFLINE") == "1":
        pub_get.append("--offline")
    subprocess.run(pub_get, cwd=package, env=env, check=True)
    subprocess.run([dart, "run", "build_runner", "build"], cwd=package, env=env, check=True)
    shutil.rmtree(package / ".dart_tool", ignore_errors=True)
    (package / "pubspec.lock").unlink(missing_ok=True)


def prepare_rust(package, repository):
    manifest = package / "Cargo.toml"
    replace_once(
        manifest,
        'authors = ["OpenAPI Generator team and contributors"]\n',
        f'repository = "{repository}"\n',
    )
    api = package / "src" / "apis" / "music_api.rs"
    content = api.read_text(encoding="utf-8")
    # These variants share the same JSON schema, so dispatch by HTTP status.
    for error_type, variants in re.findall(r"pub enum (\w+Error) \{\n([^}]+)\}", content):
        statuses = re.findall(r"Status(\d{3})\(models::ErrorResponse\),", variants)
        cases = [
            f"            {status} => serde_json::from_str(&content).map({error_type}::Status{status}),"
            for status in statuses
        ]
        cases.append(f"            _ => serde_json::from_str(&content).map({error_type}::DefaultResponse),")
        replace_once(
            api,
            f"let entity: Option<{error_type}> = serde_json::from_str(&content).ok();",
            "let entity = match status.as_u16() {\n"
            + "\n".join(cases)
            + f"\n        }}.or_else(|_| serde_json::from_str(&content).map({error_type}::UnknownValue)).ok();",
        )


def replace_generated_sdks(staged, work):
    destination = ROOT / "sdk"
    backup = work / "previous-sdk"
    names = {"typescript", "python", "dart", "rust"}
    if destination.exists():
        if destination.is_symlink() or {entry.name for entry in destination.iterdir()} != names:
            raise RuntimeError(f"Expected {destination} to contain just the generated SDKs")
        for name in names:
            if not (destination / name / ".openapi-generator" / "VERSION").is_file():
                raise RuntimeError(f"Expected a previously generated SDK at {destination / name}")
    try:
        if destination.exists():
            destination.rename(backup)
        staged.rename(destination)
    except BaseException:
        if backup.exists():
            backup.rename(destination)
        raise


def main():
    if version("openapi-generator-cli") != GENERATOR_VERSION:
        raise RuntimeError(f"Install OpenAPI Generator {GENERATOR_VERSION} from scripts/requirements.txt")
    document = yaml.safe_load((ROOT / "openapi.yaml").read_text(encoding="utf-8"))
    validate(document)
    repository = document["externalDocs"]["url"]
    # The pinned generators still use the 3.0 binary hint for SDK return types.
    download = document["paths"]["/v1/music/{id}/content"]["get"]["responses"]["200"]
    for media in download["content"].values():
        media["schema"] = {"type": "string", "format": "binary"}

    targets = {
        "TypeScript": (
            "typescript-fetch",
            {"npmName": "openmusic-sdk", "npmVersion": SDK_VERSION, "supportsES6": "true"},
            prepare_typescript,
        ),
        "Python": (
            "python",
            {"projectName": "openmusic-sdk", "packageName": "openmusic_sdk", "packageVersion": SDK_VERSION},
            prepare_python,
        ),
        "Dart": (
            "dart-dio",
            {
                "pubName": "openmusic_sdk", "pubVersion": SDK_VERSION,
                "pubDescription": "OpenMusic v1 Dart client", "serializationLibrary": "json_serializable",
                "skipCopyWith": "true",
            },
            prepare_dart,
        ),
        "Rust": (
            "rust",
            {"packageName": "openmusic_sdk", "packageVersion": SDK_VERSION, "avoidBoxedModels": "true"},
            prepare_rust,
        ),
    }
    BUILD.mkdir(exist_ok=True)
    with TemporaryDirectory(dir=BUILD, prefix="generate-") as temp:
        work = Path(temp)
        source = work / "openapi.codegen.json"
        source.write_text(json.dumps(document), encoding="utf-8")
        staged = work / "sdk"
        staged.mkdir()
        for language, (generator, config, prepare) in targets.items():
            package = staged / language.lower()
            print(f"Generating {language} SDK", flush=True)
            generate(package, generator, config, source)
            prepare_package(language, package, repository)
            prepare(package, repository)
        replace_generated_sdks(staged, work)


if __name__ == "__main__":
    main()
