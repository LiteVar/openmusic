# OpenMusic v1

[GitHub](https://github.com/LiteVar/openmusic) · [MIT License](LICENSE) · [Simplified Chinese](README-zh_CN.md)

OpenMusic defines an HTTP API for music generation across models. Clients can discover model capabilities, submit generation tasks, check their status, and download audio tracks. The SDKs connect to any compatible service through a configurable base URL.

[openapi.yaml](openapi.yaml) is the OpenAPI 3.1 contract. Clients submit JSON requests and authenticate with a bearer token. Downloads return raw audio bytes.

## Quickstart

Use the base URL and bearer token for a service that implements OpenMusic v1. For a service that exposes `https://music.example.com/v1/music`, set the base URL to `https://music.example.com`.

```sh
export OPENMUSIC_BASE_URL='https://music.example.com'
export OPENMUSIC_TOKEN='your-service-token'
```

Leave `OPENMUSIC_MODEL` unset to list model IDs. Then set it to the ID of a model that accepts a prompt on its own. Both examples submit a music task, print its ID, poll up to 150 times at two-second intervals, and save the first generated track to a local file.

### Dart

In a Dart 3.9 or later project, copy [generate.dart](examples/dart/generate.dart) to `bin/generate.dart` and run the following commands. [openmusic_sdk 0.1.0 on pub.dev](https://pub.dev/packages/openmusic_sdk/versions/0.1.0)

```sh
dart pub add openmusic_sdk
dart run bin/generate.dart
OPENMUSIC_MODEL='provider/model-id' dart run bin/generate.dart
```

The example configures `OpenmusicSdk` with `basePathOverride` and `setBearerAuth`. The download response's `data` field holds the audio bytes.

### TypeScript

In a Node.js project, copy [generate.ts](examples/typescript/generate.ts) to `generate.ts` and run the following commands. [openmusic-sdk 0.1.0 on npm](https://www.npmjs.com/package/openmusic-sdk/v/0.1.0)

```sh
npm install openmusic-sdk@0.1.0
npm install --save-dev typescript @types/node
npx tsc --strict --target ES2022 --module Node16 --types node generate.ts
node generate.js
OPENMUSIC_MODEL='provider/model-id' node generate.js
```

The example passes `basePath` and `accessToken` to `Configuration` and uses the downloaded `Blob` to write the file.

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

## Python and Rust

The [Python](sdk/python) and [Rust](sdk/rust) SDKs are available from this repository as source packages. Registry releases will follow. The [SDK integration tests](tests/sdk) show how to configure and call both clients.

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
