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

安裝後：

```text
AGENTS.md
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

```bash
bash scripts/install.sh --adapter codex --target /path/to/project
```

安裝器會：

1. 把公開核心放進 `.ai-agent-architecture/`
2. 若專案沒有 `AGENTS.md`，建立受管理入口
3. 若已有 `AGENTS.md`，保留原檔並產生 `.ai-agent-architecture/AGENTS.integration.md`

不會自動 Commit、Push 或修改 Git remote。

若需要專案專屬規則，應放在使用者自己的私有設定或既有入口中，而不是修改公開核心來塞入私人資訊。

## 隱私

不要把私人 Memory、帳號、本機絕對路徑、Secret、私人 Repository 或 Production Context 放進公開 `AGENTS.md`。需要上下文時只傳最小 Context Contract。
