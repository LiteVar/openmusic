# OpenMusic v1

[GitHub](https://github.com/LiteVar/openmusic) · [MIT 许可证](LICENSE) · [English](README.md)

OpenMusic 定义面向不同音乐生成模型的 HTTP API。客户端可以发现模型能力、提交生成任务、查询状态并下载音轨。客户端 SDK 通过可配置的服务地址调用兼容实现。

[openapi.yaml](openapi.yaml) 是 OpenAPI 3.1 协议文件。请求使用 JSON 和 Bearer 认证。下载接口返回原始音频。

## 快速上手

使用支持 OpenMusic v1 的服务地址和该服务签发的 Bearer Token。如果接口地址是 `https://music.example.com/v1/music`，基础地址应设为 `https://music.example.com`。

```sh
export OPENMUSIC_BASE_URL='https://music.example.com'
export OPENMUSIC_TOKEN='your-service-token'
```

首次运行时留空 `OPENMUSIC_MODEL`，示例会列出模型 ID。选一个只需 `prompt` 就能生成音乐的模型，再设置它的 ID。两份示例都会提交任务、打印任务 ID、每两秒轮询一次（最多 150 次），并将第一条音轨保存到本地。

### Dart

在 Dart 3.9 或更新版本的项目中，将 [generate.dart](examples/dart/generate.dart) 复制为 `bin/generate.dart`，然后运行以下命令。[pub.dev 上的 openmusic_sdk 0.1.0](https://pub.dev/packages/openmusic_sdk/versions/0.1.0)

```sh
dart pub add openmusic_sdk
dart run bin/generate.dart
OPENMUSIC_MODEL='provider/model-id' dart run bin/generate.dart
```

示例通过 `basePathOverride` 和 `setBearerAuth` 配置 `OpenmusicSdk`。下载响应的 `data` 字段包含音频字节。

### TypeScript

在 Node.js 项目中，将 [generate.ts](examples/typescript/generate.ts) 复制为 `generate.ts`，然后运行以下命令。[npm 上的 openmusic-sdk 0.1.0](https://www.npmjs.com/package/openmusic-sdk/v/0.1.0)

```sh
npm install openmusic-sdk@0.1.0
npm install --save-dev typescript @types/node
npx tsc --strict --target ES2022 --module Node16 --types node generate.ts
node generate.js
OPENMUSIC_MODEL='provider/model-id' node generate.js
```

示例将 `basePath` 和 `accessToken` 传给 `Configuration`，并将下载返回的 `Blob` 写入文件。

## API

| 方法 | 路径 | 用途 |
| --- | --- | --- |
| GET | `/v1/music/models` | 列出模型和能力 |
| GET | `/v1/music/models/{model_id}` | 查询指定模型的能力 |
| POST | `/v1/music` | 提交请求并取得任务 ID |
| GET | `/v1/music/{id}` | 查询状态和生成结果 |
| GET | `/v1/music/{id}/content` | 下载音轨。多音轨任务需传入 `track_id` |
| GET | `/v1/music` | 分页查询历史任务 |
| POST | `/v1/music/{id}/cancel` | 取消任务 |
| DELETE | `/v1/music/{id}` | 删除已结束的任务及其音频 |

把 `example/studio-v1` 这样的模型 ID 原样传给 SDK。SDK 将整个 ID 编码成一个路径段。提交前可从模型能力读取支持级别、取值范围和条件规则。启用 Webhook 的模型也可以在任务结束时向 `webhook_url` 投递签名事件。

## Python 和 Rust

[Python](sdk/python) 和 [Rust](sdk/rust) SDK 当前可从仓库获取源码，包仓库发布安排在后续。[SDK 集成测试](tests/sdk) 展示了两种客户端的配置和调用方式。

## 重新生成与验证

需要 Python 3.11+、uv、Java、Dart、Node.js/npm 和 Rust/Cargo。SDK 生成使用 OpenAPI Generator 7.27.0 和 Dart 的序列化生成器。当前 Dart 序列化生成工具需要 Dart 3.12 或更新版本。

```sh
uv venv .build/venv
uv pip install --python .build/venv/bin/python -r scripts/requirements.txt
.build/venv/bin/python scripts/generate_sdks.py
.build/venv/bin/python tests/verify_sdks.py
```

生成脚本会替换 `sdk/` 下的生成产物。公开规范用 OpenAPI 3.1 的媒体类型声明原始音频，生成脚本给临时副本添加旧版生成器识别二进制返回值所需的提示。

验证脚本会校验规范和 JSON 示例，构建四套 SDK，并用环回地址上的模拟服务跑通八个 HTTP 操作。音频测试使用字节固定的 WAV 样本。

## 在本地打包 SDK

生成 SDK 后，用同一个 Python 环境打包并验证。

```sh
.build/venv/bin/python scripts/package_sdks.py
```

通过验证的产物保存在 `dist/0.1.0/`。TypeScript 可用 `npm install <archive.tgz>` 安装，Python 的两种包都可以用 `python -m pip install <archive>` 安装。Dart 和 Rust 解包后，将项目的路径依赖指向包含 `pubspec.yaml` 或 `Cargo.toml` 的目录。

验证会新建消费者项目，使用实际安装的 SDK 调用本地模拟服务。
