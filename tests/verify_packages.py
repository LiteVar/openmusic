import json
import os
import shutil
import sys
import tarfile
import tomllib
from pathlib import Path
from tempfile import TemporaryDirectory

import yaml

from contract import SPEC
from verify_sdks import BUILD, DART, ROOT, SMOKE, build_environment, run, smoke


REPOSITORY = SPEC["externalDocs"]["url"]
LICENSE_ID = SPEC["info"]["license"]["identifier"]
LICENSE_PATH = ROOT / "LICENSE"

PYTHON_METADATA_CHECK = """\
from importlib.metadata import distribution
from pathlib import Path
import sys

expected_version, expected_license, repository, license_file = sys.argv[1:]
package = distribution("openmusic-sdk")
assert package.version == expected_version
assert package.metadata["License-Expression"] == expected_license
assert f"Repository, {repository}" in (package.metadata.get_all("Project-URL") or [])
installed_license = next(path for path in package.files if path.as_posix().endswith("/licenses/LICENSE"))
assert installed_license.locate().read_bytes() == Path(license_file).read_bytes()
"""


def verify_license(directory):
    assert (directory / "LICENSE").read_bytes() == LICENSE_PATH.read_bytes()


def verify_typescript(archive, version, consumer, env):
    consumer.mkdir()
    (consumer / "package.json").write_text('{"name":"openmusic-sdk-smoke","private":true}\n', encoding="utf-8")
    run(
        [
            "npm", "install", "--no-package-lock", "--ignore-scripts", "--no-audit", "--no-fund",
            str(archive), "typescript@5.9.3",
        ],
        env, consumer,
    )
    modules = consumer / "node_modules"
    package = modules / "openmusic-sdk"
    installed = json.loads((package / "package.json").read_text(encoding="utf-8"))
    assert installed["version"] == version
    assert installed["license"] == LICENSE_ID
    assert installed["repository"]["url"] == f"git+{REPOSITORY}.git"
    assert installed["repository"]["directory"] == "sdk/typescript"
    verify_license(package)
    typecheck = consumer / "types.ts"
    typecheck.write_text(
        'import { Configuration, MusicApi, type MusicRequest } from "openmusic-sdk";\n'
        'const api = new MusicApi(new Configuration({ basePath: "http://localhost:8080" }));\n'
        'const request: MusicRequest = { model: "example/studio-v1" };\n'
        'export const submit = () => api.createMusicTask({ musicRequest: request });\n',
        encoding="utf-8",
    )
    run(
        [
            "node", str(modules / "typescript" / "bin" / "tsc"), "--noEmit", "--strict",
            "--module", "node16", str(typecheck),
        ],
        env, consumer,
    )
    script = consumer / "smoke.mjs"
    shutil.copyfile(SMOKE / "typescript.mjs", script)
    smoke(["node", str(script)], dict(env, OPENMUSIC_TYPESCRIPT_PACKAGE="openmusic-sdk"), cwd=consumer)


def verify_python(archive, version, consumer, env):
    consumer.mkdir()
    venv = consumer / "venv"
    interpreter = venv / ("Scripts/python.exe" if os.name == "nt" else "bin/python")
    run(["uv", "venv", "--python", sys.executable, str(venv)], env, consumer)
    run(["uv", "pip", "install", "--python", str(interpreter), str(archive)], env, consumer)
    run(
        [
            str(interpreter), "-I", "-c", PYTHON_METADATA_CHECK,
            version, LICENSE_ID, REPOSITORY, str(LICENSE_PATH),
        ],
        env, consumer,
    )
    script = consumer / "smoke.py"
    shutil.copyfile(SMOKE / "python_smoke.py", script)
    smoke([str(interpreter), "-I", str(script)], env, cwd=consumer)


def unpack(archive, destination):
    destination.mkdir()
    with tarfile.open(archive, "r:gz") as package:
        package.extractall(destination, filter="data")


def verify_dart(archive, version, consumer, env):
    package = consumer.parent / "dart-package"
    unpack(archive, package)
    manifest = yaml.safe_load((package / "pubspec.yaml").read_text(encoding="utf-8"))
    assert manifest["version"] == version
    assert manifest["repository"] == REPOSITORY
    verify_license(package)
    consumer.mkdir()
    pubspec = {
        "name": "openmusic_sdk_smoke",
        "environment": manifest["environment"],
        "dependencies": {
            "openmusic_sdk": {"path": "../dart-package"},
            "dio": manifest["dependencies"]["dio"],
        },
    }
    (consumer / "pubspec.yaml").write_text(yaml.safe_dump(pubspec), encoding="utf-8")
    pub_get = [DART, "pub", "get"]
    if env.get("OPENMUSIC_PUB_OFFLINE") == "1":
        pub_get.append("--offline")
    run(pub_get, env, consumer)
    script = consumer / "smoke.dart"
    shutil.copyfile(SMOKE / "dart.dart", script)
    packages = consumer / ".dart_tool" / "package_config.json"
    smoke([DART, "--enable-asserts", f"--packages={packages}", str(script)], env, cwd=consumer)


def verify_rust(archive, version, consumer, env):
    archives = consumer.parent / "rust-package"
    unpack(archive, archives)
    package = archives / f"openmusic_sdk-{version}"
    manifest = tomllib.loads((package / "Cargo.toml").read_text(encoding="utf-8"))
    assert manifest["package"]["version"] == version
    assert manifest["package"]["repository"] == REPOSITORY
    assert manifest["package"]["license"] == LICENSE_ID
    verify_license(package)
    consumer.mkdir()
    shutil.copytree(SMOKE / "rust" / "src", consumer / "src")
    consumer_manifest = (SMOKE / "rust" / "Cargo.toml").read_text(encoding="utf-8")
    source = 'path = "../../../sdk/rust"'
    assert consumer_manifest.count(source) == 1
    (consumer / "Cargo.toml").write_text(
        consumer_manifest.replace(source, f'path = "../rust-package/{package.name}", version = "={version}"'),
        encoding="utf-8",
    )
    rust_env = dict(env, CARGO_TARGET_DIR=str(consumer / "target"))
    run(["cargo", "build", "--quiet"], rust_env, consumer)
    smoke(["cargo", "run", "--quiet", "--locked"], rust_env, cwd=consumer)


def main(directory, version):
    env = build_environment()
    for key in ("NODE_PATH", "PYTHONHOME", "PYTHONPATH", "VIRTUAL_ENV"):
        env.pop(key, None)
    run([sys.executable, str(ROOT / "tests" / "contract.py")], env)

    with TemporaryDirectory(dir=BUILD, prefix="sdk-consumers-") as scratch:
        work = Path(scratch)
        checks = (
            ("TypeScript", f"openmusic-sdk-{version}.tgz", verify_typescript),
            ("Python wheel", f"openmusic_sdk-{version}-py3-none-any.whl", verify_python),
            ("Python sdist", f"openmusic_sdk-{version}.tar.gz", verify_python),
            ("Dart", f"openmusic_sdk-{version}-dart.tar.gz", verify_dart),
            ("Rust", f"openmusic_sdk-{version}.crate", verify_rust),
        )
        for language, filename, verify in checks:
            consumer = work / language.lower().replace(" ", "-")
            print(f"Installing and verifying {language} {version} in a clean consumer", flush=True)
            verify(directory / filename, version, consumer, env)
            print(f"{language} passed the installed SDK HTTP test.", flush=True)


if __name__ == "__main__":
    main(Path(sys.argv[1]).resolve(), sys.argv[2])
