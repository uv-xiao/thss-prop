# Typst 与 TOSS 本地环境说明

## 结论

本项目采用 Pixi 管理 Typst CLI，并用 Makefile 暴露常用命令。TOSS 使用其上游仓库自带的 Docker Compose 部署方式，避免在本机额外安装 Rust、PostgreSQL、MinIO 和 Node 构建依赖。

目录布局：

- `report/`：开题报告 Typst 源码、字体和文档。
- `resources/`：现有论文仓库、事迹材料和其他撰写资料。
- `tools/TOSS/`：本地 TOSS 服务源码与 Docker Compose。

## Typst

Typst 官方提供 Homebrew、预编译二进制、源码编译和容器等安装方式。对本项目而言，Pixi 更合适，原因是：

1. `conda-forge` 已提供 `typst 0.14.2`，支持 `osx-arm64`。
2. Pixi 会生成 `pixi.lock`，便于后续复现。
3. 不污染系统全局环境，也不要求所有协作者使用相同的 Homebrew 状态。

当前项目根目录提供：

```bash
make install
make typst-version
make pdf
make watch
make clean
```

`report/fonts/` 中包含 `pkuthss-typst` 模板仓库提供的字体。编译命令使用：

```bash
typst compile main.typ main.pdf --font-path fonts
```

这样可以避免 macOS、Linux、Windows 的中文字体名称差异影响版式。

## TOSS

TOSS 是 Typst Open-Source Server，提供实时协作、多文件项目、浏览器端 Typst 编译预览、Git HTTP 访问和版本历史。上游当前推荐的本地自部署方式是：

1. `web/` 中运行 `npm install && npm run build`。
2. `backend/` 中配置 PostgreSQL、运行 Rust 后端。

本项目改用上游自带 Docker Compose，因为它把 PostgreSQL、MinIO、前端构建和 Rust 后端构建放进容器里，主机只需要 Docker。

当前项目根目录提供：

```bash
make toss-env
make toss-config
make toss-up
make toss-logs
make toss-health
make toss-down
```

访问地址：

```text
http://127.0.0.1:8080
```

首次启动时，TOSS 会在 `core-api` 日志中输出一次初始管理员账号和密码。启动后运行：

```bash
make toss-logs
```

然后查找：

```text
INITIAL ADMIN ACCOUNT
```

## 当前机器状态

已完成：

1. Pixi 环境安装成功。
2. Typst 版本为 `0.14.2`。
3. `make pdf` 可生成 `report/main.pdf`。
4. `make toss-config` 可解析 TOSS compose 配置。
5. `make toss-up` 已可启动 TOSS，健康检查返回 `{"status":"ok","service":"core-api"}`。

本地 TOSS patch：

1. 上游 `backend/Dockerfile` 使用 `rust:1.88`，但当前解析到的 AWS Rust 依赖要求 `rustc 1.91.1`，因此本地改为 `rust:1.91`。
2. 上游 `backend/Dockerfile` 未复制 `backend/resources`，但 `latex_cache.rs` 通过 `include_bytes!` 需要 `resources/latex_compat/*`，因此本地增加 `COPY backend/resources ./resources`。
3. `rust:1.91` 产物需要较新的 GLIBC，原 `debian:bookworm-slim` 运行镜像缺少 `GLIBC_2.38/2.39`，因此本地改为 `debian:trixie-slim`。

当前服务：

```text
TOSS: http://127.0.0.1:8080
MinIO console: http://127.0.0.1:9001
```

首次管理员账号已在日志中输出。登录后应立即修改密码。

## 参考来源

- Typst 官方 Open Source 页面：说明 CLI 安装方式、`typst watch`、Typst Universe 包下载与本地编译模型。
- `conda-forge::typst`：确认 `typst 0.14.2` 与 `osx-arm64` 可用。
- TOSS README：确认 TOSS 的功能、架构、本地部署命令、Docker Compose、首次管理员账号输出和健康检查端点。
