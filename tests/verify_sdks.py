import os
import subprocess
import sys
import tomllib
from threading import Thread

from contract import ROOT
from mock_service import MockService


BUILD = ROOT / ".build"
SDK = ROOT / "sdk"
SMOKE = ROOT / "tests" / "sdk"
DART = os.environ.get("OPENMUSIC_DART", "dart")


def run(command, env, cwd=ROOT):
    subprocess.run(command, cwd=cwd, env=env, check=True)


def build_typescript(env):
    package = SDK / "typescript"
    run(["npm", "install", "--no-package-lock", "--ignore-scripts", "--no-audit", "--no-fund"], env, package)
    run(["npm", "run", "build"], env, package)
    return ["node", str(SMOKE / "typescript.mjs")]


def build_python(env):
    output = BUILD / "packages"
    run(["uv", "build", "--wheel", "--out-dir", str(output), str(SDK / "python")], env)
    project = tomllib.loads((SDK / "python" / "pyproject.toml").read_text(encoding="utf-8"))["project"]
    wheel = output / f"openmusic_sdk-{project['version']}-py3-none-any.whl"
    run(["uv", "pip", "install", "--reinstall-package", "openmusic-sdk", "--python", sys.executable, str(wheel)], env)
    return [sys.executable, str(SMOKE / "python_smoke.py")]


def build_dart(env):
    package = SDK / "dart"
    pub_get = [DART, "pub", "get"]
    if env.get("OPENMUSIC_PUB_OFFLINE") == "1":
        pub_get.append("--offline")
    run(pub_get, env, package)
    run([DART, "analyze", "lib"], env, package)
    packages = package / ".dart_tool" / "package_config.json"
    return [DART, "--enable-asserts", f"--packages={packages}", str(SMOKE / "dart.dart")]


def build_rust(env):
    manifest = str(SMOKE / "rust" / "Cargo.toml")
    run(["cargo", "build", "--quiet", "--manifest-path", manifest], env)
    return ["cargo", "run", "--quiet", "--manifest-path", manifest]


def smoke(command, env, cwd=ROOT):
    with MockService() as server:
        worker = Thread(target=server.serve_forever, daemon=True)
        worker.start()
        try:
            local_env = dict(env, OPENMUSIC_TEST_URL=f"http://127.0.0.1:{server.server_port}")
            for key in ("NO_PROXY", "no_proxy"):
                local_env[key] = ",".join(filter(None, [env.get(key), "localhost", "127.0.0.1"]))
            subprocess.run(command, cwd=cwd, env=local_env, check=True, timeout=45)

            # Each SDK must preserve typed fields and arbitrary JSON inside provider options.
            request = server.requests["music_test_1"]
            assert request["duration"] == 60.5 and request["instrumental"] is False
            assert request["provider"]["options"]["example"] == {
                "guidance_scale": 4.5,
                "composition": {"sections": ["verse"], "offset": None},
            }
        finally:
            server.shutdown()
            worker.join()


def build_environment():
    env = dict(os.environ, DART_SUPPRESS_ANALYTICS="true")
    env.setdefault("npm_config_cache", str(BUILD / "npm-cache"))
    env.setdefault("UV_CACHE_DIR", str(BUILD / "uv-cache"))
    env.setdefault("PUB_CACHE", str(BUILD / "pub-cache"))
    env.setdefault("CARGO_HOME", str(BUILD / "cargo"))
    env.setdefault("CARGO_TARGET_DIR", str(BUILD / "rust-target"))
    return env


def main():
    env = build_environment()
    run([sys.executable, str(ROOT / "tests" / "contract.py")], env)
    failures = []
    for language, build in (
        ("TypeScript", build_typescript), ("Python", build_python),
        ("Dart", build_dart), ("Rust", build_rust),
    ):
        print(f"Building and verifying {language}", flush=True)
        try:
            smoke(build(env), env)
        except (AssertionError, OSError, subprocess.SubprocessError) as error:
            print(f"{language} failed: {error}", file=sys.stderr, flush=True)
            failures.append(language)
        else:
            print(f"{language} SDK passed the HTTP smoke test.", flush=True)
    if failures:
        raise SystemExit(f"SDK verification failed for {', '.join(failures)}")


if __name__ == "__main__":
    main()
