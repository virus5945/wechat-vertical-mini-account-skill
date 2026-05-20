# WeChat Vertical Mini Account Skill

一个用于中文公众号垂直小号的 Agent Skill 合集。

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
- 多产品导购爆款文
- 单品降价捡漏文

这些 Skill 本体是 instruction-only，不会读取隐私文件，也不会主动执行命令。仓库里的 `install.sh` 只负责把 Skill 文件夹复制到指定目录，方便不同 Agent 加载。

## Skill 列表

| Skill | 定位 | 适合写什么 |
|---|---|---|
| `wechat-vertical-mini-account` | 通用公众号垂直小号运营 | 起号、选题、标题、写稿、改稿、SEO、复盘、变现、审核 |
| `multi-product-buying-guide-writing` | 多产品导购爆款写作 | 手机/数码横评、预算推荐、消费决策文 |
| `single-product-price-drop-writing` | 单品降价捡漏写作 | 手机降价、清仓捡漏、价格跳水文 |

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
├── multi-product-buying-guide-writing/
│   ├── SKILL.md
│   └── examples/
│       └── sample-outputs.md
├── single-product-price-drop-writing/
│   ├── SKILL.md
│   ├── examples/
│   │   └── sample-outputs.md
│   └── agents/
│       └── openai.yaml
├── .github/
│   └── copilot-instructions.md
├── AGENTS.md
├── CLAUDE.md
├── USAGE_BY_AGENT.md
├── skills.yaml
├── RELEASE.md
├── install.sh
├── tests/
│   ├── scenarios.md
│   └── validate-project.sh
└── LICENSE
```

## 快速安装

`install.sh` 支持一键安装全部 Skill 或指定 Skill。

```bash
# 安装全部 Skill（默认目标：~/.agents/skills/）
./install.sh

# 安装全部 Skill 到指定目标
./install.sh openclaw
./install.sh claude
./install.sh project-agents

# 只安装指定 Skill
./install.sh user-agents wechat-vertical-mini-account
./install.sh claude multi-product-buying-guide-writing
./install.sh project-agents single-product-price-drop-writing
```

安装脚本会复制嵌套文件，并清理安装结果里的 `.DS_Store` 等 macOS 元数据。

安装目标：

| 目标 | 路径 |
|---|---|
| `openclaw` | `~/.openclaw/skills/` |
| `claude` | `~/.claude/skills/` |
| `user-agents`（默认） | `~/.agents/skills/` |
| `project-agents` | `.agents/skills/` |
| `project-claude` | `.claude/skills/` |
| `workspace-skills` | `skills/` |

### 手动安装

#### OpenClaw

```bash
mkdir -p ~/.openclaw/skills
cp -R wechat-vertical-mini-account ~/.openclaw/skills/
cp -R multi-product-buying-guide-writing ~/.openclaw/skills/
cp -R single-product-price-drop-writing ~/.openclaw/skills/
openclaw gateway restart
openclaw skills list
```

#### Claude Code

个人级：

```bash
mkdir -p ~/.claude/skills
cp -R wechat-vertical-mini-account ~/.claude/skills/
cp -R multi-product-buying-guide-writing ~/.claude/skills/
cp -R single-product-price-drop-writing ~/.claude/skills/
```

项目级：

```bash
mkdir -p .claude/skills
cp -R wechat-vertical-mini-account .claude/skills/
cp -R multi-product-buying-guide-writing .claude/skills/
cp -R single-product-price-drop-writing .claude/skills/
```

使用：

```text
/wechat-vertical-mini-account 帮我把这个选题写成公众号爆款文章
/multi-product-buying-guide-writing 写一篇 3000 元档手机推荐
/single-product-price-drop-writing 写一篇华为手机降价捡漏文
```

#### OpenAI Codex

```bash
mkdir -p .agents/skills
cp -R wechat-vertical-mini-account .agents/skills/
cp -R multi-product-buying-guide-writing .agents/skills/
cp -R single-product-price-drop-writing .agents/skills/
```

Codex 也会读取仓库里的 `AGENTS.md`。如果你只想把它作为项目指令使用，可以把 `AGENTS.md` 放在项目根目录。

#### Cursor / GitHub Copilot / Windsurf / 其他 AI 编辑器

把下面文件作为上下文引用：

```text
wechat-vertical-mini-account/SKILL.md
multi-product-buying-guide-writing/SKILL.md
single-product-price-drop-writing/SKILL.md
```

需要更完整效果时，再引用：

```text
wechat-vertical-mini-account/references/prompt-pack.md
wechat-vertical-mini-account/references/topic-and-title-engine.md
```

#### Harness 类项目技能引用

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
使用 multi-product-buying-guide-writing。
写一篇 2000 元档 5 款手机推荐文，目标读者是学生党。
[粘贴手机信息]
```

```text
使用 single-product-price-drop-writing。
这款华为手机从 3799 降到 1996，帮我写一篇降价捡漏导购文。
[粘贴产品信息]
```

```text
使用 wechat-vertical-mini-account。
根据这些后台数据做一次周复盘，告诉我下周该继续写什么。
[粘贴数据]
```

## 项目验证

发布或改动 Skill 后，建议运行：

```bash
bash tests/validate-project.sh
```

这个脚本会检查：

- 三个 Skill 都存在 `SKILL.md`
- `skills.yaml` 和实际 Skill 目录一致
- Skill `description` 以 `Use when` 开头，方便 Agent 正确发现
- 仓库不出现旧创作者指向命名
- 仓库不出现未经支撑的绝对承诺词
- 仓库内没有 `.DS_Store`
- 安装脚本能复制嵌套文件，并排除 `.DS_Store`

## 合规原则

这些 Skill 明确拒绝：

- 刷粉、刷阅读、刷赞
- 诱导点击广告
- 洗稿搬运
- 伪造收益截图或虚假案例
- 夸大医疗、金融、教育等敏感效果
- 帮助绕过平台检测的欺骗性做法

它会把这类需求改成更安全的方案：原创改写、事实核对、真人化表达、低风险标题、合规变现。

两个导购类 Skill 只提供可复用的文章结构和消费决策表达，不用于复刻具体创作者的人设、口头禅、经历或私有表达。

## License

MIT
