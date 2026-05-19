# Usage by Agent

## OpenClaw

复制 skill 文件夹：

```bash
mkdir -p ~/.openclaw/skills
cp -R wechat-vertical-mini-account ~/.openclaw/skills/
openclaw gateway restart
openclaw skills list
```

也可放在工作区：

```bash
mkdir -p ./skills
cp -R wechat-vertical-mini-account ./skills/
```

触发示例：

```text
用公众号垂直小号 Skill，帮我做一个 AI 工具公众号的起号方案。
```

## Claude Code

个人级：

```bash
mkdir -p ~/.claude/skills
cp -R wechat-vertical-mini-account ~/.claude/skills/
```

项目级：

```bash
mkdir -p .claude/skills
cp -R wechat-vertical-mini-account .claude/skills/
```

直接调用：

```text
/wechat-vertical-mini-account 帮我生成 20 个公众号选题
```

## OpenAI Codex

项目级：

```bash
mkdir -p .agents/skills
cp -R wechat-vertical-mini-account .agents/skills/
```

同时保留根目录 `AGENTS.md`，方便 Codex 在项目开始时知道这个仓库的使用方式。

调用示例：

```text
Use the wechat-vertical-mini-account skill. Create a WeChat article strategy for this topic: 普通人如何用 AI 写公众号。
```

## GitHub Copilot / Cursor / Windsurf

把 `wechat-vertical-mini-account/SKILL.md` 作为上下文文件引用。

更完整任务可同时引用：

```text
wechat-vertical-mini-account/references/topic-and-title-engine.md
wechat-vertical-mini-account/references/article-workflow.md
wechat-vertical-mini-account/references/prompt-pack.md
```

## Harness-like workflow repositories

如果你的工作区使用 `CLAUDE.md`、`AGENTS.md` 或 `skills/` 目录作为 AI 工作流上下文，可以：

1. 保留本仓库根目录 `AGENTS.md` 和 `CLAUDE.md`。
2. 把 `wechat-vertical-mini-account/` 复制到项目的 `skills/` 或 `.agents/skills/`。
3. 在提示词中引用 `SKILL.md`。

注意：本 Skill 不调用 Harness API，不生成 Harness Pipeline，不需要 MCP Server。
