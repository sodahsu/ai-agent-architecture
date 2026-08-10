# Skill: code-review

## Purpose

對程式碼、Diff 或 Pull Request 做證據式審查，依 Correctness、Security、Maintainability 與 Regression Risk 排序問題，避免把純風格偏好當成 Blocking Finding。

## Inputs

- Review Target（diff / file / PR artifact）
- Original Goal / Acceptance Criteria
- Validation Evidence（可選）
- Focus Area（可選）
- Repository Rules（可選）

## Outputs

- Findings with Severity
- Acceptance Criteria Mapping
- Positive Observations
- Residual Risk
- Verdict：approve / request-changes / needs-discussion

## Preconditions

- Review Target 可讀取。
- 若是變更審查，至少知道變更原本要達成的目標。

## Permissions

- Read: target + relevant tests / rules
- Write: review artifact only
- Source modification: none by default
- Merge / Deploy: none

## Procedure

1. 先讀 Goal / Acceptance Criteria，再讀 Diff；不要先相信作者摘要。
2. 依序檢查 Correctness、Security / Privacy、Regression / Compatibility、Maintainability。
3. 檢查是否存在必要但缺失的 Test / Validation Evidence。
4. 對每個 Finding 提供具體位置、問題機制、可能影響與建議方向。
5. 將 Severity 分為 Blocking、Important、Suggestion；風格問題若已有 Formatter / Linter 管理通常不重複提出。
6. 檢查 Scope 是否出現與原目標無關的重構或行為改變。
7. 指出值得保留的良好實作，避免 Review 只有負面清單。
8. 依 Evidence 給出 Verdict，不因作者或工具聲稱「已測試」就直接採信。

## Validation

Blocking Finding 必須能由 Code Path、Test、Specification 或可重現情境支撐；每個 Acceptance Criterion 都應能對應到 Evidence 或明確標記 unknown。

## Failure Conditions

- Target 與作者聲稱的版本不同
- Acceptance Criteria 缺失到無法判斷變更是否正確
- 需要修改 Source 才能完成 Reviewer 工作

## Completion Criteria

Review 清楚區分真正阻擋合併的問題、重要改善與偏好；Verdict 能被第三方沿 Evidence 重新驗證。
