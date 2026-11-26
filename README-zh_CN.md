# OpenMusic v1

[GitHub](https://github.com/LiteVar/openmusic) · [MIT 许可证](LICENSE) · [English](README.md)

OpenMusic 定义面向不同音乐生成模型的 HTTP API。客户端可以发现模型能力、提交生成任务、查询状态并下载音轨。客户端 SDK 通过可配置的服务地址调用兼容实现。

[openapi.yaml](openapi.yaml) 是 OpenAPI 3.1 协议文件。请求使用 JSON 和 Bearer 认证。下载接口返回原始音频。

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

## SDK

| 语言 | 本地包 | 服务配置 | 下载返回值 |
| --- | --- | --- | --- |
| TypeScript | [openmusic-sdk](sdk/typescript) | `Configuration` 的 `basePath` 和 `accessToken` | `Blob` |
| Python | [openmusic_sdk](sdk/python) | `Configuration` 的 `host` 和 `access_token` | `bytes` |
| Dart | [openmusic_sdk](sdk/dart) | `OpenmusicSdk(basePathOverride: …)` 和 `setBearerAuth('BearerAuth', token)` | `Response<Uint8List>` |
| Rust | [openmusic_sdk](sdk/rust) | `Configuration` 的 `base_path` 和 `bearer_access_token` | `reqwest::Response`，用 `bytes()` 读取 |

TypeScript 包可在 `sdk/typescript` 目录内用 `npm install` 和 `npm pack` 打包。Python 包可用 `python -m pip install ./sdk/python` 安装。Dart 和 Rust 可在各自的包清单中声明本地路径依赖。

[客户端示例](tests/sdk) 使用本地测试服务，演示四种语言的配置、模型查询、提交、轮询和下载。

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
