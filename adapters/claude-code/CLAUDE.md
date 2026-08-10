# Claude Code Adapter Entrypoint

本檔是公開、安全、平台轉接用途的範本。

## Architecture

先讀：

1. `docs/architecture/layer-model.md`
2. `docs/architecture/agent-skill-governance.md`
3. `docs/governance/public-private-boundary.md`

## Agent Routing

依任務責任選擇角色：

- 規劃、拆解、Routing、Approval Gate → `agents/coordinator.md`
- 有明確 Scope 的實作 → `agents/implementer.md`
- Acceptance Criteria / Evidence 獨立審查 → `agents/reviewer.md`
- 外部 Skill / Tool / MCP 導入判斷 → `agents/evaluator.md`

角色契約是責任與權限定義，不代表一定要 spawn 子代理人。平台支援時可以使用 subagent；不支援時可在同一 session 依角色順序執行。

## Skill Routing

非簡單任務先從 `skills/README.md` 找最小匹配 Skill，完整讀取對應 `SKILL.md` 後再執行。

目前公開 Skills：

- `skills/task-contract/SKILL.md`
- `skills/bounded-implementation/SKILL.md`
- `skills/evidence-review/SKILL.md`
- `skills/privacy-sanitizer/SKILL.md`
- `skills/handoff/SKILL.md`
- `skills/capability-evaluation/SKILL.md`

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
