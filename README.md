# WeChat Vertical Mini Account Skill

一个用于中文公众号垂直小号的 Agent Skill。

它可以帮助 AI Agent 稳定完成这些任务：

- 公众号垂直赛道定位
- 账号名称、简介、人设、自动回复
- 对标账号拆解
- 选题评分和标题生成
- 公众号文章初稿与改稿
- 微信搜一搜 SEO
- 起号排期和数据复盘
- 流量主、商单、私域、知识付费变现设计
- 合规审稿和低风险改写

这个 Skill 是 instruction-only，不包含自动执行脚本，不会读取隐私文件，不会执行命令。

## 目录结构

```text
wechat-vertical-mini-account-skill/
├── wechat-vertical-mini-account/
│   ├── SKILL.md
│   ├── references/
│   │   ├── positioning-and-niche.md
│   │   ├── topic-and-title-engine.md
│   │   ├── article-workflow.md
│   │   ├── growth-review-monetization.md
│   │   └── prompt-pack.md
│   └── examples/
│       └── sample-outputs.md
├── AGENTS.md
├── CLAUDE.md
├── USAGE_BY_AGENT.md
├── .github/copilot-instructions.md
└── LICENSE
```

## 快速安装

### 1. OpenClaw

全局安装：

```bash
mkdir -p ~/.openclaw/skills
cp -R wechat-vertical-mini-account ~/.openclaw/skills/
openclaw gateway restart
openclaw skills list
```

项目级安装：

```bash
mkdir -p ./skills
cp -R wechat-vertical-mini-account ./skills/
```

也可以安装到：

```bash
~/.agents/skills/
<workspace>/.agents/skills/
<workspace>/skills/
```

### 2. Claude Code

个人级安装：

```bash
mkdir -p ~/.claude/skills
cp -R wechat-vertical-mini-account ~/.claude/skills/
```

项目级安装：

```bash
mkdir -p .claude/skills
cp -R wechat-vertical-mini-account .claude/skills/
```

使用：

```text
/wechat-vertical-mini-account 帮我把这个选题写成公众号爆款文章
```

### 3. OpenAI Codex

项目级安装：

```bash
mkdir -p .agents/skills
cp -R wechat-vertical-mini-account .agents/skills/
```

Codex 也会读取仓库里的 `AGENTS.md`。如果你只想把它作为项目指令使用，可以把 `AGENTS.md` 放在项目根目录。

### 4. Cursor / GitHub Copilot / Windsurf / 其他 AI 编辑器

把下面文件作为上下文引用：

```text
wechat-vertical-mini-account/SKILL.md
```

需要更完整效果时，再引用：

```text
wechat-vertical-mini-account/references/prompt-pack.md
wechat-vertical-mini-account/references/topic-and-title-engine.md
```

### 5. Harness 类项目技能引用

如果你的 AI 工作区支持 `CLAUDE.md`、`AGENTS.md` 或 Markdown 技能文件，可以使用本仓库根目录的：

```text
AGENTS.md
CLAUDE.md
USAGE_BY_AGENT.md
```

本 Skill 不依赖 Harness API 或 MCP Server。它是内容生产与公众号运营工作流 Skill，不是 Harness 平台自动化 Skill。

## 推荐调用方式

```text
使用 wechat-vertical-mini-account 这个 Skill。
我现在想做一个公众号垂直小号，方向是【普通人 AI 工具 + 数码消费避坑】，目标用户是【打工人和小老板】。
请帮我输出：定位、账号名、简介、前 14 天选题、标题包、第一篇文章大纲。
```

```text
使用 wechat-vertical-mini-account。
下面是我的原文，请改成公众号爆款风格，要求低风险、不标题党、1500 字左右，并给 12 个标题。
[粘贴原文]
```

```text
使用 wechat-vertical-mini-account。
根据这些后台数据做一次周复盘，告诉我下周该继续写什么。
[粘贴数据]
```

## 合规原则

这个 Skill 明确拒绝：

- 刷粉、刷阅读、刷赞
- 诱导点击广告
- 洗稿搬运
- 伪造收益截图或虚假案例
- 夸大医疗、金融、教育等敏感效果
- 帮助绕过平台检测的欺骗性做法

它会把这类需求改成更安全的方案：原创改写、事实核对、真人化表达、低风险标题、合规变现。

## License

MIT
