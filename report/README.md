# 开题报告 Typst 工作区

本目录包含开题报告的撰写规范、spec 和初稿。

## 文件说明

- `docs/agent_writing_guidelines.md`：agent 撰写规范。
- `docs/report_spec.md`：报告主线、成果矩阵和未来工作 spec。
- `main.typ`：基于 `pkuthss-typst` / `modern-pku-thesis` 的 Typst 初稿。
- `refs.bib`：当前手工整理的参考文献占位，后续需要按正式论文信息核验。

## 编译

推荐使用项目根目录的 Pixi 环境和 Makefile：

```bash
cd ..
make install
make pdf
make watch
```

本地 `report/fonts/` 可以放置 `pkuthss-typst` 模板仓库提供的宋体、黑体、仿宋、Times New Roman 与 New Computer Modern Mono 字体。该目录不会提交到主仓库；Makefile 会在目录存在时通过 `--font-path fonts` 传给 Typst，避免不同系统字体差异影响版式。

`pkuthss-typst` 当前 Typst Universe 包名为 `modern-pku-thesis`，初稿使用版本 `0.2.3`：

```typst
#import "@preview/modern-pku-thesis:0.2.3": appendix, conf
```

## TOSS 协同写作

TOSS 是 Typst Open-Source Server，用于自托管协同编辑、浏览器侧预览、Git 访问和修订历史。若需要多人协作，可把本目录作为 TOSS 项目内容导入，或通过 TOSS 的 Git HTTP 项目仓库进行同步。

本地 TOSS 已放在项目根目录的 `tools/TOSS`。Docker daemon 启动后可在项目根目录运行：

```bash
make toss-up
make toss-logs
make toss-health
```

首次启动时 TOSS 会在日志中打印初始管理员账号和密码。
