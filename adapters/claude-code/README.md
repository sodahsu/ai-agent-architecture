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

```text
CLAUDE.md
  ↓
README.md / docs/architecture/layer-model.md
  ↓
agents/<role>.md
  ↓
skills/<name>/SKILL.md
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

最簡單的使用方式是把 `CLAUDE.md` 範本放到目標專案根目錄，並讓專案可以讀取本架構的 `agents/`、`skills/` 與 `docs/governance/`。

可以使用 copy、submodule、subtree 或其他版本固定方式；重點是不要在多個地方手動維護同一份 Skill Procedure。

## 隱私

不要把私人 Memory、帳號資訊、本機絕對路徑或 Secret 寫進公開 `CLAUDE.md`。專案專屬敏感資訊應留在私有設定層，並只透過必要的 Context Contract 提供給任務。
