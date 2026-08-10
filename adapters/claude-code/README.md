# Claude Code Adapter

這個 Adapter 示範如何把平台中立的 Agent / Skill Contract 接到 Claude Code。

## 角色

Claude Code Adapter 只負責：

- 讀取 `CLAUDE.md` 作為專案入口規則
- 依任務選擇 `agents/` 中的角色契約
- 依角色與任務讀取 `skills/<name>/SKILL.md`
- 套用 Governance、Permission、Validation 與 Human Approval Gate

核心 Agent 與 Skill 仍以 repository 根目錄為唯一真相源。

## 建議讀取順序

安裝後：

```text
CLAUDE.md
  ↓
.ai-agent-architecture/docs/architecture/layer-model.md
  ↓
.ai-agent-architecture/agents/<role>.md
  ↓
.ai-agent-architecture/skills/<name>/SKILL.md
  ↓
Governance / Privacy Rules
```

## 角色映射

| 公開角色 | Claude Code 中的用途 |
|---|---|
| Coordinator | orchestration、拆解、Routing、Assignment |
| Implementer | bounded implementation |
| Reviewer | read-only independent review |
| Evaluator | 外部 Skill / MCP / Tool 評估 |

Claude Code 可以使用 native agent / subagent 能力實作這些角色，但平台能力不是核心架構的一部分。即使沒有 subagent 功能，也可以在單一 session 依角色契約序列執行。

## Skill Routing

非簡單任務應先確認是否有對應 Skill：

```text
理解任務
  ↓
選擇最小匹配 Skill
  ↓
完整讀取 SKILL.md
  ↓
檢查 Preconditions / Permissions
  ↓
執行 Procedure
  ↓
產出 Validation Evidence
```

不要因為 Claude Code 能執行 Shell、Git 或其他工具，就跳過 Skill Contract 的 Permission Boundary。

## 安裝方式

```bash
bash scripts/install.sh --adapter claude-code --target /path/to/project
```

安裝器會：

1. 把公開核心放進 `.ai-agent-architecture/`
2. 若專案沒有 `CLAUDE.md`，建立受管理入口
3. 若已有 `CLAUDE.md`，保留原檔並產生 `.ai-agent-architecture/CLAUDE.integration.md`

不會自動 Commit、Push 或修改 Git remote。

## 隱私

不要把私人 Memory、帳號資訊、本機絕對路徑或 Secret 寫進公開 `CLAUDE.md`。專案專屬敏感資訊應留在私有設定層，並只透過必要的 Context Contract 提供給任務。
