# Codex Adapter

這個 Adapter 示範如何把平台中立的 Agent / Skill Contract 接到 Codex。

## 角色

Codex Adapter 只負責：

- 讀取 `AGENTS.md` 作為專案入口規則
- 把 `agents/` 視為工作責任契約，而不是依賴 Claude-specific subagent 機制
- 直接讀取並執行 `skills/<name>/SKILL.md`
- 套用 Governance、Permission、Validation 與 Human Approval Gate

核心 Agent 與 Skill 仍以 repository 根目錄為唯一真相源。

## 建議讀取順序

```text
AGENTS.md
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

Codex 不需要把四個角色實作成四個特定平台物件。角色代表當下工作責任：

| 公開角色 | Codex 中的用途 |
|---|---|
| Coordinator | 先做 Task Contract、Scope、Routing 與 Gate 判斷 |
| Implementer | 在授權 Scope 內執行變更 |
| Reviewer | 切換成 Read-only 審查視角並驗證 Evidence |
| Evaluator | 評估外部能力是否值得 Adopt / Adapt / Reject |

同一個 Codex session 可以依工作流切換責任，但每次切換都必須遵守對應角色的 Permission Boundary。

## Skill Routing

Codex 直接使用共用 Skill Contract：

```text
理解任務
  ↓
選擇最小匹配 Skill
  ↓
讀取完整 SKILL.md
  ↓
確認 Preconditions / Permissions
  ↓
執行 Procedure
  ↓
回傳 Validation Evidence / Handoff
```

Skill 是真正的程序真相源；`AGENTS.md` 不應重寫完整 Skill Procedure。

## 安裝方式

最簡單的方式是把 `AGENTS.md` 範本放到目標專案根目錄，並讓專案可以讀取本架構的 `agents/`、`skills/` 與 Governance 文件。

可以使用 copy、submodule、subtree 或其他版本固定方式。若需要專案專屬規則，應新增一層 local/private override，而不是修改公開核心來塞入私人資訊。

## 隱私

不要把私人 Memory、帳號、本機絕對路徑、Secret、私人 Repository 或 Production Context 放進公開 `AGENTS.md`。需要上下文時只傳最小 Context Contract。
