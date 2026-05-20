# Usage by Agent

本仓库包含三个 Skill，以下是各平台的安装和调用方式。

## OpenClaw

复制 skill 文件夹：

```bash
# 安装全部（推荐）
./install.sh openclaw

# 或手动
mkdir -p ~/.openclaw/skills
cp -R wechat-vertical-mini-account ~/.openclaw/skills/
cp -R multi-product-buying-guide-writing ~/.openclaw/skills/
cp -R single-product-price-drop-writing ~/.openclaw/skills/
openclaw gateway restart
openclaw skills list
```

也可放在工作区：

```bash
./install.sh workspace-skills
```

触发示例：

```text
用公众号垂直小号 Skill，帮我做一个 AI 工具公众号的起号方案。
```

```text
用多产品导购 Skill，写一篇 3000 元档手机横评推荐。
```

## Claude Code

个人级：

```bash
./install.sh claude
```

项目级：

```bash
./install.sh project-claude
```

直接调用：

```text
/wechat-vertical-mini-account 帮我生成 20 个公众号选题
/multi-product-buying-guide-writing 写一篇 2000 元档 5 款手机推荐文
/single-product-price-drop-writing 写一篇华为手机降价捡漏文
```

## OpenAI Codex

项目级：

```bash
./install.sh project-agents
```

同时保留根目录 `AGENTS.md`，方便 Codex 在项目开始时知道这个仓库的使用方式。

调用示例：

```text
Use the wechat-vertical-mini-account skill. Create a WeChat article strategy for this topic: 普通人如何用 AI 写公众号。
```

```text
Use the multi-product-buying-guide-writing skill. Write a buying guide for 5 phones under 3000 yuan for college students.
```

```text
Use the single-product-price-drop-writing skill. Write a price-drop analysis for this Huawei phone that dropped from 3799 to 1996 yuan.
```

## GitHub Copilot / Cursor / Windsurf

把 SKILL.md 作为上下文文件引用：

```text
wechat-vertical-mini-account/SKILL.md
multi-product-buying-guide-writing/SKILL.md
single-product-price-drop-writing/SKILL.md
```

更完整任务可同时引用：

```text
wechat-vertical-mini-account/references/topic-and-title-engine.md
wechat-vertical-mini-account/references/article-workflow.md
wechat-vertical-mini-account/references/prompt-pack.md
```

## Harness-like workflow repositories

如果你的工作区使用 `CLAUDE.md`、`AGENTS.md` 或 `skills/` 目录作为 AI 工作流上下文，可以：

1. 保留本仓库根目录 `AGENTS.md` 和 `CLAUDE.md`。
2. 用 `./install.sh workspace-skills` 把全部 Skill 复制到 `skills/`。
3. 在提示词中引用对应的 `SKILL.md`。

注意：本 Skill 不调用 Harness API，不生成 Harness Pipeline，不需要 MCP Server。

## Validation

改动或发布前可运行：

```bash
bash tests/validate-project.sh
```

它会检查 Skill 元数据、`skills.yaml` 同步、敏感命名清理、`.DS_Store` 清理和安装脚本的基本复制行为。
