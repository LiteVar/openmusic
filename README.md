# OpenMusic v1

[GitHub](https://github.com/LiteVar/openmusic) · [MIT License](LICENSE) · [Simplified Chinese](README-zh_CN.md)

OpenMusic defines an HTTP API for music generation across models. Clients can discover model capabilities, submit generation tasks, check their status, and download audio tracks. The SDKs connect to any compatible service through a configurable base URL.

[openapi.yaml](openapi.yaml) is the OpenAPI 3.1 contract. Clients submit JSON requests and authenticate with a bearer token. Downloads return raw audio bytes.

## API

| Method | Path | Purpose |
| --- | --- | --- |
| GET | `/v1/music/models` | List models and their capabilities |
| GET | `/v1/music/models/{model_id}` | Get a model's capabilities |
| POST | `/v1/music` | Submit a generation request and receive a task ID |
| GET | `/v1/music/{id}` | Get task status and generated tracks |
| GET | `/v1/music/{id}/content` | Download audio. Tasks with multiple tracks require `track_id` |
| GET | `/v1/music` | List past tasks with pagination |
| POST | `/v1/music/{id}/cancel` | Cancel a task |
| DELETE | `/v1/music/{id}` | Delete a finished task and its audio |

Pass model IDs such as `example/studio-v1` directly to the SDK. The SDK encodes the entire ID as one URL path segment. Before submitting a request, check the model's support levels, value ranges, and conditional requirements. For models with webhook support, the service can send a signed event to `webhook_url` when a task reaches a terminal state.

## SDKs

| Language | Local package | Service configuration | Download return type |
| --- | --- | --- | --- |
| TypeScript | [openmusic-sdk](sdk/typescript) | `basePath` and `accessToken` on `Configuration` | `Blob` |
| Python | [openmusic_sdk](sdk/python) | `host` and `access_token` on `Configuration` | `bytes` |
| Dart | [openmusic_sdk](sdk/dart) | `OpenmusicSdk(basePathOverride: …)` and `setBearerAuth('BearerAuth', token)` | `Response<Uint8List>` |
| Rust | [openmusic_sdk](sdk/rust) | `base_path` and `bearer_access_token` on `Configuration` | `reqwest::Response` with `bytes()` to read the body |

To package the TypeScript SDK, run `npm install` and `npm pack` in `sdk/typescript`. Install the Python SDK with `python -m pip install ./sdk/python`. For Dart and Rust, declare a local path dependency in your package manifest.

The [client examples](tests/sdk) use a local test service to demonstrate configuration, model discovery, task submission, polling, and downloading in all four languages.

## Regenerate and verify

You need Python 3.11+, uv, Java, Dart, Node.js with npm, and Rust with Cargo. SDK generation uses OpenAPI Generator 7.27.0 and Dart's serialization generator. The serialization generator requires Dart 3.12 or newer.

```sh
uv venv .build/venv
uv pip install --python .build/venv/bin/python -r scripts/requirements.txt
.build/venv/bin/python scripts/generate_sdks.py
.build/venv/bin/python tests/verify_sdks.py
```

Regeneration replaces the generated packages under `sdk/`. The OpenAPI 3.1 contract describes raw audio by media type. The generation script adds binary return hints to a temporary copy of the contract so that the SDK generators recognize the download response.

The verification script validates the contract and JSON examples, builds all four SDKs, and exercises all eight HTTP operations against a loopback mock service. Audio tests verify the exact bytes of a fixed WAV sample.

## Package the SDKs locally

After generating the SDKs, build and verify the release archives with the same Python environment.

```sh
.build/venv/bin/python scripts/package_sdks.py
```

The script saves the verified archives to `dist/0.1.0/`. Install the TypeScript tarball with `npm install <archive.tgz>` and either Python archive with `python -m pip install <archive>`. For Dart and Rust, extract the archive and point your project's path dependency at the directory containing `pubspec.yaml` or `Cargo.toml`.

Package verification creates fresh consumer projects and exercises the actual installed SDKs against the loopback mock service.
