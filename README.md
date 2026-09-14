# Hotspots — Agent Skill

让支持 Agent Skills（`SKILL.md`）的工具，用**一份 Skill**拉齐自媒体常用的公开热点源：

| 板块 | 源 | 接入 |
|---|---|---|
| 全网热榜 | [NewsNow](https://newsnow.busiyi.world) | 公开 JSON，免 Key |
| X 热帖 | [SoPilot Hot Tweets](https://sopilot.net/hot-tweets) | 官方 RSS，免登录 |
| AI 精选（可选） | [AIHOT](https://aihot.news) | [官方 Skill](https://aihot.news/aihot-skill/README.md)，需另装 |

灵感来自常见的「4 站看热点」清单；**不含** TopHub（站内接口易触发安全验证，不适合作为稳定 Skill 依赖）。

## 安装前可审阅

- [`package/SKILL.md`](package/SKILL.md)
- [`package/references/`](package/references/)
- [`install.sh`](install.sh)
- [`LICENSE`](LICENSE)

## 手动安装

适用于 macOS、Linux、WSL。必须显式指定 `--target` 或 `--dir`：

```bash
bash install.sh --target agents
```

`codex` / `gemini` / `copilot` / `opencode` 与 `agents` 同路径（`~/.agents/skills/hotspots`）。

Claude Code：

```bash
bash install.sh --target claude
```

会安装到 `~/.agents/skills/hotspots`，并在 `~/.claude/skills/hotspots` 建兼容软链。

自定义目录：

```bash
bash install.sh --dir "$HOME/path/to/skills/hotspots"
```

### 可选：安装 AIHOT

本包装的是编排说明，**不内嵌** AIHOT 文件（其有独立许可与安装器）：

```bash
bash <(curl -fsSL https://aihot.news/aihot-skill/install.sh) --target agents
```

## 安装后验证

1. 重启 Agent 或开新会话。
2. 确认能发现 `hotspots` Skill。
3. 提问：`出一份今天的热点早报。`

成功时至少有 **NewsNow** 与 **SoPilot** 两节；已装 AIHOT 时再多 **AI 精选**。

## 更新

重新运行同一 `--target` / `--dir` 命令即可。

## 许可

- 本仓库 Skill 指令与脚本：MIT（见 `LICENSE`）
- NewsNow 项目：MIT（upstream）
- SoPilot／AIHOT 的服务与数据：遵循各站条款；本 Skill 仅描述如何调用公开接口

## 反馈

开 Issue，或在使用中直接让 Agent 按本 Skill 跑早报后把失败源反馈回来。
