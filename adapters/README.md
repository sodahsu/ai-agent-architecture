# Adapter Layer

`adapters/` 負責把本 repository 的平台中立 Agent / Skill Contract 映射到不同 AI 工具的入口格式。

## 核心原則

**核心方法只維護一份，Adapter 不複製核心規則。**

```text
agents/                  ← Agent Contract 真相源
skills/                  ← Skill Contract 真相源
        │
        ├── adapters/claude-code/
        │      └─ Claude Code 的載入與 orchestration 規則
        │
        └── adapters/codex/
               └─ Codex 的載入與直接 Skill Routing 規則
```

Adapter 只回答三件事：

1. 平台從哪個入口檔開始讀。
2. 平台如何取得 Agent / Skill Contract。
3. 平台有哪些特有能力或限制需要額外映射。

以下內容不應寫進 Adapter：

- 個人 Memory、偏好或履歷
- 真實私人 repository 或本機路徑
- API Key、Token、Secret
- 特定帳號或裝置設定
- Employer / Client / Production Context
- 會造成核心規則雙份維護的完整 Skill 複本

## 平台對照

| 項目 | Claude Code Adapter | Codex Adapter |
|---|---|---|
| 入口 | `CLAUDE.md` | `AGENTS.md` |
| Agent Role | 可映射成 orchestration / specialist roles | 以工作角色契約理解，不依賴 Claude-specific agent 機制 |
| Skill | 讀取共用 `skills/<name>/SKILL.md` | 直接讀取共用 `skills/<name>/SKILL.md` |
| Governance | 共用根目錄文件 | 共用根目錄文件 |
| 真相源 | `agents/` + `skills/` | `agents/` + `skills/` |

## 避免 Drift

Adapter 不應重新描述完整 Skill Procedure。若平台需要特殊行為，只能補充「如何載入、如何呼叫、平台特有限制」。

當核心 Contract 改變時，優先修改 `agents/` 或 `skills/`；只有入口方式改變時才修改 `adapters/`。
