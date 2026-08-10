# 公開 Agent 套件

這個目錄提供可公開、可移植的 Agent 角色定義。這些 Agent 不綁定特定模型或供應商，也不包含任何私人記憶、真實帳號、私有 Repository、Credential 或 Production 設定。

## 第一批 Agent

| Agent | 主要責任 | 預設寫入權限 |
|---|---|---|
| [Coordinator](coordinator.md) | 理解目標、拆解任務、路由與建立 Assignment | 無 |
| [Implementer](implementer.md) | 在明確 Scope 內執行變更並提供驗證證據 | Feature branch / sandbox only |
| [Reviewer](reviewer.md) | 獨立比對 Acceptance Criteria、風險與證據 | 無 |
| [Evaluator](evaluator.md) | 評估新 Skill、Tool、MCP 或外部能力是否可採用 | 無 |

## 共通契約

每個 Agent 都必須明確定義：

```text
Role
Inputs
Outputs
Allowed Actions
Forbidden Actions
Escalation Conditions
Completion Criteria
```

Agent 負責判斷與協調，不應把可重複的詳細步驟全部寫進角色本身；穩定程序應交由 `skills/` 管理。

## 使用原則

1. 最小上下文（Least Context）：只取得足以完成當前判斷的資訊。
2. 最小權限（Least Privilege）：Reviewer 不需要寫入權，Implementer 也不自動擁有 Merge / Deploy 權。
3. 可驗證回程：每次執行都要回傳 Evidence，而不是只宣告「完成」。
4. 高風險操作進入 Governance Gate，不由 Agent 自行推定授權。
5. 公開範例不得包含可回推真實身份或私人環境的資訊。
