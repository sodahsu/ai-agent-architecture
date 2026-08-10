# 公開 Agent 套件

這個目錄提供可公開、可移植的 Agent 角色定義。這些 Agent 不綁定特定模型或供應商，也不包含私人記憶、真實帳號、私有 Repository、Credential 或 Production 設定。

Agent 分成兩個不同維度，**不要把它們混成同一層**：

- **Lifecycle Agents**：描述工作生命週期中「現在由誰負責」。
- **Domain Agents**：描述某個專業領域中「如何理解問題與路由 Skill」。

例如 `Design Coordinator` 可以先做領域判斷，真正實作時仍交給 Lifecycle `Implementer`，最後由 `Reviewer` 獨立驗證。

## Lifecycle Agents

| Agent | 主要責任 | 預設寫入權限 |
|---|---|---|
| [Coordinator](coordinator.md) | 理解目標、拆解任務、路由與建立 Assignment | 無 |
| [Implementer](implementer.md) | 在明確 Scope 內執行變更並提供驗證證據 | Feature branch / sandbox only |
| [Reviewer](reviewer.md) | 獨立比對 Acceptance Criteria、風險與證據 | 無 |
| [Evaluator](evaluator.md) | 評估新 Skill、Tool、MCP 或外部能力是否可採用 | 無 |

## Domain Agents

| Agent | 主要責任 | 預設寫入權限 |
|---|---|---|
| [Design Coordinator](design-coordinator.md) | Design Brief / Review / Spec / System 的領域判斷與路由 | 無 |
| [Product Coordinator](product-coordinator.md) | Product Goal、Roadmap、Decision、Requirement 的領域判斷與路由 | 無 |
| [People Coordinator](people-coordinator.md) | 1-on-1、Feedback、Hiring、Team Context 的隱私安全路由 | 無 |

People Coordinator 是刻意加入的治理範例：People 工作可以公開「方法」，但真實員工／候選人資料、永久人格 Profile、敏感屬性推論與最終人事決策都不屬於公開 Agent 的權限。

## 共通契約

每個 Agent 至少必須明確定義：

```text
Role
Inputs
Outputs
Allowed Actions
Forbidden Actions
Completion Criteria
```

需要跨權限或高風險判斷的角色，應另外定義 `Escalation Conditions`。

Agent 負責判斷與協調，不應把可重複的詳細步驟全部寫進角色本身；穩定程序交由 `skills/` 管理。

## 組合方式

```text
Domain Agent
   ↓ 判斷領域與 Skill
Lifecycle Coordinator
   ↓ 建立 Assignment / Gate
Lifecycle Implementer
   ↓ 執行 Skill
Lifecycle Reviewer
   ↓ Evidence Review
Human Approval
```

這是責任組合，不要求平台一定要真的 Spawn 五個不同 Subagent；若 Runtime 不支援，可在同一 Session 依序切換契約，但每一階段的 Permission Boundary 仍然有效。

## 使用原則

1. 最小上下文（Least Context）：只取得足以完成當前判斷的資訊。
2. 最小權限（Least Privilege）：Reviewer 不需要寫入權，Implementer 也不自動擁有 Merge / Deploy 權。
3. 可驗證回程：每次執行都要回傳 Evidence，而不是只宣告「完成」。
4. 高風險操作進入 Governance Gate，不由 Agent 自行推定授權。
5. 公開範例不得包含可回推真實身份或私人環境的資訊。
