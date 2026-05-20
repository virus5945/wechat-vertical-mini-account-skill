# Release Workflow

发布前按这个顺序检查。

## 1. 本地验证

```bash
bash tests/validate-project.sh
git diff --check
find . -path ./.git -prune -o -name .DS_Store -print
```

期望：

- `Validation passed`
- `git diff --check` 无输出
- `find` 无输出

## 2. 安装验证

```bash
tmp_home="$(mktemp -d)"
HOME="$tmp_home" ./install.sh user-agents
find "$tmp_home/.agents/skills" -maxdepth 2 -name SKILL.md -print
rm -rf "$tmp_home"
```

确认三个 Skill 都能被复制到目标目录。

## 3. 文档检查

- `skills.yaml` 是 Skill 列表的单一事实源。
- `README.md`、`AGENTS.md`、`CLAUDE.md`、`USAGE_BY_AGENT.md` 中的 Skill 名称与 `skills.yaml` 一致。
- 两个导购 Skill 只保留通用导购结构，不出现真实创作者指向命名。
- 示例不编造价格、库存、销量、排名、收益或后台数据。

## 4. 场景抽查

打开 `tests/scenarios.md`，至少抽查 3 个压力场景。

重点看：

- 是否拒绝复刻真实账号私有表达。
- 是否拒绝编造价格、参数、库存、销量、收益。
- 是否把过强承诺改成低风险表达。
- 多 Skill 混合任务是否能正确路由。

## 5. 提交建议

```bash
git status --short
git add .
git commit -m "chore: productize skill package"
```

提交前确认没有安装产物目录被纳入版本控制。
