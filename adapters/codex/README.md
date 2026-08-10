# Codex Adapter

這個 Adapter 把平台中立的 Agent / Skill Contract 接到 Codex；它只做平台入口與載入，不維護第二份 capability inventory。

## 讀取順序

安裝後：

```text
AGENTS.md
  ↓
.ai-agent-architecture/agents/README.md
.ai-agent-architecture/skills/README.md
  ↓
選定 Agent / Skill Contract
  ↓
Governance / Privacy Rules
```

完整 Agent 索引以 `agents/README.md` 為準，完整 Skill 索引以 `skills/README.md` 為準。不要在 Adapter 裡重複列出所有角色或 Skill，避免 Public Core 擴充後發生 drift。

## Review 語意

Codex 可以在同一 Session 依 Workflow 切換角色，但這只代表責任切換，不等於 reviewer independence。

- 不同 reviewer / context，且未先暴露原實作推理 → 可標記 `independent`。
- 同一 Session 切換 Reviewer 視角 → 必須標記 `structured-self-review`。

## Skill Routing

```text
理解任務
  ↓
讀 skills/README.md
  ↓
選擇最小匹配 Skill
  ↓
完整讀取 SKILL.md
  ↓
確認 Preconditions / Permissions
  ↓
執行 Procedure
  ↓
回傳 Validation Evidence / Handoff
```

Skill 是程序真相源；`AGENTS.md` 不應重寫完整 Skill Procedure。

## 安裝

```bash
bash scripts/install.sh --adapter codex --target /path/to/project
```

安裝器會把 Public Core、Privacy Policy 與 MIT License 放進 `.ai-agent-architecture/`。若目標已有 `AGENTS.md`，保留原檔並建立 Integration Template；不自動 Commit、Push 或修改 Git remote。

## 隱私

私人 Memory、帳號、本機絕對路徑、Credential、Private Repository 或 Production Context 不進 Public Core。需要上下文時只傳當前任務所需的最小 Context Contract。
