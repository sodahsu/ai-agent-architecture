# Skill: evidence-review

## Purpose

依原始 Task Contract、Acceptance Criteria 與實際 Evidence 做可追溯審查，避免「有改到東西」被誤判成「任務已完成」。是否屬於 independent review，取決於 Reviewer 是否使用與原實作推理隔離的 reviewer / context。

## Inputs

- Task Contract
- Acceptance Criteria
- Changed Scope Summary
- Diff / Artifact
- Validation Evidence
- Governance Policy
- Review Mode：`independent | structured-self-review`

## Outputs

```yaml
review_mode: "independent | structured-self-review"
verdict: "pass | revise | block"
criteria:
  - item: ""
    status: "pass | fail | unknown"
    evidence: ""
findings: []
residual_risk: []
next_action: ""
```

## Preconditions

- Reviewer 能讀取被審查 Artifact。
- 原始 Acceptance Criteria 可取得。
- 若要標記 `independent`，Reviewer / context 必須與原實作推理隔離；同一 session 切換視角只能標記 `structured-self-review`。

## Permissions

- Read: review target + evidence
- Write: none by default
- Merge / Deploy: no

## Procedure

1. 先標記 Review Mode，再開始審查。
2. 先讀 Task Contract，不先相信實作者摘要。
3. 逐項比對 Acceptance Criteria。
4. 檢查 Evidence 是否真的支撐每個結論。
5. 檢查 Changed Scope 是否超出原 Assignment。
6. 依 Security / Privacy → Governance → Correctness → Maintainability 順序檢查。
7. 對每個 Finding 標示 Evidence 與 Severity。
8. 明確給出 pass / revise / block。

## Validation

審查結果必須能被第三方重新追蹤到 Artifact 或 Evidence；避免使用「看起來沒問題」這種不可驗證結論，也不得把 structured self-review 誇大成 independent review。

## Failure Conditions

- 缺少必要 Evidence
- Acceptance Criteria 不完整到無法判定
- Review Target 與實作者聲稱的版本不一致
- 要求 independent review，但沒有隔離 reviewer / context

## Completion Criteria

每個 Acceptance Criterion 都有明確 status，Verdict 有足夠 Evidence 支撐，且 Review Mode 與實際審查條件一致。
