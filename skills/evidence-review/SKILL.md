# Skill: evidence-review

## Purpose

依原始 Task Contract、Acceptance Criteria 與實際 Evidence 做獨立審查，避免「有改到東西」被誤判成「任務已完成」。

## Inputs

- Task Contract
- Acceptance Criteria
- Changed Scope Summary
- Diff / Artifact
- Validation Evidence
- Governance Policy

## Outputs

```yaml
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

## Permissions

- Read: review target + evidence
- Write: none by default
- Merge / Deploy: no

## Procedure

1. 先讀 Task Contract，不先相信實作者摘要。
2. 逐項比對 Acceptance Criteria。
3. 檢查 Evidence 是否真的支撐每個結論。
4. 檢查 Changed Scope 是否超出原 Assignment。
5. 依 Security / Privacy → Governance → Correctness → Maintainability 順序檢查。
6. 對每個 Finding 標示 Evidence 與 Severity。
7. 明確給出 pass / revise / block。

## Validation

審查結果必須能被第三方重新追蹤到 Artifact 或 Evidence；避免使用「看起來沒問題」這種不可驗證結論。

## Failure Conditions

- 缺少必要 Evidence
- Acceptance Criteria 不完整到無法判定
- Review Target 與實作者聲稱的版本不一致

## Completion Criteria

每個 Acceptance Criterion 都有明確 status，且 Verdict 有足夠 Evidence 支撐。
