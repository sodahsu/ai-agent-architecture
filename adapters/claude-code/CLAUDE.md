<!-- ai-agent-architecture-managed -->
# Claude Code Adapter Entrypoint

本檔是公開、安全、平台轉接用途的範本。Adapter 只負責載入與路由，不維護第二份 Agent / Skill 清單。

## Architecture

先讀：

1. `.ai-agent-architecture/docs/architecture/layer-model.md`
2. `.ai-agent-architecture/docs/architecture/agent-skill-governance.md`
3. `.ai-agent-architecture/docs/governance/public-private-boundary.md`

## Agent Routing

先讀 `.ai-agent-architecture/agents/README.md`，再依任務選擇最小必要角色契約。

Agent 分成兩個維度：

- Lifecycle Agent：負責 Coordinator / Implementer / Reviewer / Evaluator 等工作生命週期責任。
- Domain Agent：負責 Design / Product / People 等領域判斷與 Skill Routing。

Domain Agent 不會因專業判斷而自動取得 Implementer 的寫入權；需要寫入時仍必須遵守 Lifecycle Assignment 與 Permission Boundary。

角色契約是責任與權限定義，不代表一定要 spawn 子代理人。平台支援獨立 subagent / context 時可用於真正的 independent review；若同一 session 只是切換 Reviewer 視角，必須標記為 structured self-review，不宣稱獨立審查。

## Skill Routing

非簡單任務先讀 `.ai-agent-architecture/skills/README.md`，選擇最小匹配 Skill，完整讀取對應 `SKILL.md` 後再執行。

不要在 Adapter 內手寫完整 Skill inventory；`skills/README.md` 與實際 `skills/*/SKILL.md` 是公開能力的索引與程序真相源。

Skill Contract 的 Preconditions、Permissions、Procedure、Validation、Failure Conditions 與 Completion Criteria 為執行邊界。

## Governance

能力不等於授權。

預設規則：

- 最小必要 Context
- 最小必要 Permission
- 優先使用可逆變更
- Reviewer 預設 Read-only
- Merge / Deploy / Secret / Destructive Action 等高影響操作需要明確 Human Approval
- 公開內容必須先通過 `privacy-sanitizer`

不得因平台工具權限較大而繞過上述限制。

## Privacy

禁止將以下資訊加入本公開入口：

- 個人 Memory 或 Conversation History
- 真實私人 Repository / Issue / PR 資訊
- Account Identifier、Email、Device、Hostname、本機絕對路徑
- Credential、Token、Cookie、Password、Webhook Secret
- Employer / Client / Confidential Project Context
- Production Configuration

需要私有 Context 時，只注入會實際改變當前任務判斷的最小 Context Contract。
