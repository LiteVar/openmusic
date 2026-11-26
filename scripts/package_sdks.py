import json
import os
import shutil
import subprocess
import sys
import tarfile
import tomllib
from pathlib import Path
from tempfile import TemporaryDirectory

import yaml

from generate_sdks import BUILD, ROOT, SDK_VERSION


SDK = ROOT / "sdk"


def check_versions():
    manifests = {
        "TypeScript": json.loads((SDK / "typescript" / "package.json").read_text(encoding="utf-8")),
        "Python": tomllib.loads((SDK / "python" / "pyproject.toml").read_text(encoding="utf-8"))["project"],
        "Dart": yaml.safe_load((SDK / "dart" / "pubspec.yaml").read_text(encoding="utf-8")),
        "Rust": tomllib.loads((SDK / "rust" / "Cargo.toml").read_text(encoding="utf-8"))["package"],
    }
    for language, manifest in manifests.items():
        if manifest["version"] != SDK_VERSION:
            raise ValueError(f"{language} is {manifest['version']}. Regenerate the SDKs for {SDK_VERSION}.")


def stage_package(language, work, files):
    source = SDK / language
    package = work / language
    package.mkdir()
    for name in files:
        if (source / name).is_dir():
            shutil.copytree(
                source / name, package / name, ignore=shutil.ignore_patterns("__pycache__", "*.pyc")
            )
        else:
            shutil.copy2(source / name, package / name)
    return package


def pack_typescript(work, output, env):
    package = stage_package(
        "typescript", work, ("package.json", "README.md", "LICENSE", "tsconfig.json", "tsconfig.esm.json", "src")
    )
    subprocess.run(
        ["npm", "install", "--no-package-lock", "--ignore-scripts", "--no-audit", "--no-fund"],
        cwd=package, env=env, check=True,
    )
    subprocess.run(["npm", "run", "build"], cwd=package, env=env, check=True)
    subprocess.run(
        ["npm", "pack", "--ignore-scripts", "--pack-destination", str(output)],
        cwd=package, env=env, check=True,
    )


def pack_python(work, output, env):
    package = stage_package("python", work, ("pyproject.toml", "README.md", "LICENSE", "openmusic_sdk"))
    subprocess.run(
        ["uv", "build", "--quiet", "--sdist", "--wheel", "--out-dir", str(output)],
        cwd=package, env=env, check=True,
    )
    (output / ".gitignore").unlink(missing_ok=True)


def pack_dart(output):
    archive = output / f"openmusic_sdk-{SDK_VERSION}-dart.tar.gz"
    with tarfile.open(archive, "w:gz") as package:
        for name in ("pubspec.yaml", "README.md", "LICENSE", "analysis_options.yaml", "build.yaml", "lib"):
            package.add(SDK / "dart" / name, arcname=name)


def pack_rust(work, output, env):
    package = stage_package("rust", work, ("Cargo.toml", "README.md", "LICENSE", "src"))
    target = work / "cargo-package"
    # The verifier below builds a fresh consumer against the exact archive.
    subprocess.run(
        [
            "cargo", "package", "--allow-dirty", "--no-verify", "--exclude-lockfile",
            "--target-dir", str(target),
        ],
        cwd=package, env=env, check=True,
    )
    archive = f"openmusic_sdk-{SDK_VERSION}.crate"
    shutil.move(target / "package" / archive, output / archive)


def main():
    check_versions()
    BUILD.mkdir(exist_ok=True)
    env = dict(os.environ)
    env.setdefault("npm_config_cache", str(BUILD / "npm-cache"))
    env.setdefault("UV_CACHE_DIR", str(BUILD / "uv-cache"))
    env.setdefault("CARGO_HOME", str(BUILD / "cargo"))

    with TemporaryDirectory(dir=BUILD, prefix="package-sdks-") as scratch:
        work = Path(scratch)
        output = work / "artifacts"
        output.mkdir()
        pack_typescript(work, output, env)
        pack_python(work, output, env)
        pack_dart(output)
        pack_rust(work, output, env)
        subprocess.run(
            [sys.executable, str(ROOT / "tests" / "verify_packages.py"), str(output), SDK_VERSION],
            cwd=ROOT, env=env, check=True,
        )
        destination = ROOT / "dist" / SDK_VERSION
        destination.mkdir(parents=True, exist_ok=True)
        for artifact in sorted(output.iterdir()):
            artifact.replace(destination / artifact.name)
        print(f"Verified SDK packages saved to {destination}", flush=True)


if __name__ == "__main__":
    main()
