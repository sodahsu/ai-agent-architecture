# 公開 Agent 套件

這個目錄是 Public Agent 的索引與角色入口。Agent 不綁定特定模型或供應商，也不包含私人記憶、真實帳號、私有 Repository、Credential 或 Production 設定。

Agent 分成兩個不同維度：

- **Lifecycle Agents**：描述工作生命週期中「現在由誰負責」。
- **Domain Agents**：描述某個專業領域中「如何理解問題與路由 Skill」。

Domain Agent 先做領域判斷；需要實際寫入時仍交給 Lifecycle `Implementer`，最後由 `Reviewer` 做 Evidence Review。

## Lifecycle Agents

| Agent | 主要責任 | 預設寫入權限 |
|---|---|---|
| [Coordinator](coordinator.md) | 理解目標、拆解任務、路由與建立 Assignment | 無 |
| [Implementer](implementer.md) | 在明確 Scope 內執行變更並提供驗證證據 | Feature branch / sandbox only |
| [Reviewer](reviewer.md) | Read-only Evidence Review；有隔離 reviewer / context 時可做 independent review | 無 |
| [Evaluator](evaluator.md) | 評估新 Skill、Tool、MCP 或外部能力是否可採用 | 無 |

## Domain Agents

| Agent | 主要責任 | 預設寫入權限 |
|---|---|---|
| [Design Coordinator](design-coordinator.md) | Design Brief / Review / Spec / System 的領域判斷與路由 | 無 |
| [Product Coordinator](product-coordinator.md) | Product Goal、Roadmap、Decision、Requirement 的領域判斷與路由 | 無 |
| [People Coordinator](people-coordinator.md) | 1-on-1、Feedback、Hiring、Team Context 的隱私安全路由 | 無 |

People Coordinator 只公開方法與治理邊界：不包含真實員工／候選人資料，不建立永久人格或敏感屬性 Profile，不替人類做最終人事決策，也不用 AI 分數／排名自動選擇員工或候選人。

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

Agent 負責判斷與協調；穩定、可重複的程序交由 `skills/` 管理。

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

這是責任組合，不要求平台一定 Spawn 多個 Subagent。若 Runtime 不支援，可在同一 Session 依序切換契約，但同一 Session 的 Reviewer 必須標記為 `structured-self-review`；不能宣稱具備獨立 reviewer 的驗證強度。

## 使用原則

1. 最小上下文（Least Context）。
2. 最小權限（Least Privilege）。
3. 每次執行回傳可追溯 Evidence。
4. 高風險操作進 Governance / Human Approval Gate。
5. 公開範例只使用 synthetic / anonymized context。
