# Claude Code Adapter

這個 Adapter 把平台中立的 Agent / Skill Contract 接到 Claude Code；它只做平台入口與載入，不維護第二份 capability inventory。

## 讀取順序

安裝後：

```text
CLAUDE.md
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

Claude Code 若能提供彼此隔離的 subagent / context，可以把 Reviewer 用於真正的 independent review。

若只在同一 session 切換 Reviewer 視角，仍可依 Reviewer Contract 做 Evidence Review，但必須標記為 `structured-self-review`，不能宣稱具備獨立驗證的強度。

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
檢查 Preconditions / Permissions
  ↓
執行 Procedure
  ↓
產出 Validation Evidence
```

不要因為 Claude Code 能執行 Shell、Git 或其他工具，就跳過 Skill Contract 的 Permission Boundary。

## 安裝

```bash
bash scripts/install.sh --adapter claude-code --target /path/to/project
```

安裝器會把 Public Core、Privacy Policy 與 MIT License 放進 `.ai-agent-architecture/`。若目標已有 `CLAUDE.md`，保留原檔並建立 Integration Template；不自動 Commit、Push 或修改 Git remote。

## 隱私

私人 Memory、帳號資訊、本機絕對路徑、Credential 或 Production Context 不進 Public Core。專案專屬 Context 只透過當前任務所需的最小 Context Contract 提供。
