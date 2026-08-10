# Skill: task-contract

## Purpose

把自然語言目標轉成可執行、可驗證、具明確邊界的 Task Contract。

## Inputs

- Goal
- Constraints
- Non-goals（可選）
- Known Context（最小必要）
- Governance Policy

## Outputs

```yaml
objective: ""
scope:
  include: []
  exclude: []
constraints: []
acceptance_criteria: []
validation: []
write_scope: "none | sandbox | feature-branch | explicit-target"
approval_gates: []
```

## Preconditions

- 已知使用者真正要達成的結果。
- 不需要先取得完整私人記憶才能開始。

## Permissions

- Read: task-relevant context only
- Write: none

## Procedure

1. 用一句話重述 Objective。
2. 明確列出 Include / Exclude Scope。
3. 把限制寫成可檢查的 Constraints。
4. 將「做好」轉成具體 Acceptance Criteria。
5. 為每個 Criteria 指定 Validation Evidence。
6. 設定最小 Write Scope。
7. 標記 Human Approval / Governance Gate。
8. 若資訊不足但可用合理假設前進，明確列出 Assumption；不要偷偷擴大需求。

## Validation

Task Contract 必須能回答：做什麼、不做什麼、怎樣算完成、怎樣驗證、可以寫哪裡、什麼需要批准。

## Failure Conditions

- Objective 彼此衝突且無法安全推定
- Scope 無法界定
- 必要權限超出現有 Governance

## Completion Criteria

產出的 Contract 足以讓另一個 Agent 在不讀原始長對話的情況下開始工作。
