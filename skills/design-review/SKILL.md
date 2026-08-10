# Skill: design-review

## Purpose

對畫面、流程或設計方案做結構化評審，優先檢查問題對焦、流程合理性、系統一致性、無障礙與邊界情況，並提供具優先級的可行動建議。

## Inputs

- Review Target
- Original Goal / Brief
- Focus Area（可選）
- Existing Design System / Constraints（可選）
- Evidence（畫面、流程、Prototype、Spec 等）

## Outputs

- Overall Assessment
- Findings with Priority
- Actionable Recommendations
- Strengths
- Open Questions
- Review Verdict

## Preconditions

- Review Target 可取得。
- 至少知道設計原本要解決什麼問題；若完全未知，先使用 `design-brief` 或 `clarify`。

## Permissions

- Read: review target + relevant context
- Write: review artifact only
- Target modification: none by default

## Procedure

1. 先核對設計是否解決正確問題，而不是先評美感。
2. 檢查使用流程、資訊層級、認知負擔與錯誤／空／Loading 等邊界狀態。
3. 檢查元件、Token、Spacing、Typography 與既有 Design System 是否一致。
4. 檢查 Accessibility、Keyboard / Focus、Contrast、Error Recovery 等必要條件。
5. 對每個 Finding 說明 Observation、Impact、Recommendation 與 Priority。
6. 區分 Blocking Issue、Recommended Improvement 與 Preference；不要把偏好包裝成必修。
7. 同時指出做得好的地方，保留值得延續的設計決策。
8. 產出 pass / revise / needs-discussion 的 Review Verdict。

## Validation

每個高優先 Finding 必須能指向具體 Artifact、狀態或可重現情境，並提供可以採取的下一步。

## Failure Conditions

- 沒有原始 Goal，導致只能做純主觀美感評論
- Evidence 不足以確認高風險 Finding
- Reviewer 被要求直接修改被審 Target，破壞獨立審查角色

## Completion Criteria

Review 能清楚區分優點、問題、優先級與下一步；Blocking Finding 有 Evidence，非 Blocking 建議不被誇大成硬性規則。
