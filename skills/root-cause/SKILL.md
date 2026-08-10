# Skill: root-cause

## Purpose

從可觀察症狀往回追到原始觸發點，建立可驗證的因果鏈，避免用猜測式修補或只治療表面症狀。

## Inputs

- Symptom
- Expected Behavior
- Trigger Context / Timeline（可選）
- Recent Changes（可選）
- Tried Fixes（可選）
- Logs / Tests / Evidence（可選）

## Outputs

- Reproduction Boundary
- Causal Trace
- Root Cause Hypothesis
- Supporting / Refuting Evidence
- Fix Options with Trade-offs
- Validation Plan

## Preconditions

- 症狀可以被具體描述。
- 不把第一個合理 Hypothesis 當成 Root Cause。

## Permissions

- Read: relevant code / logs / history / tests
- Write: analysis artifact only by default
- Fix implementation: separate assignment

## Procedure

1. 固定症狀：描述 Actual 與 Expected 的差距。
2. 建立最小時間軸：最早何時出現、之前最後一個已知正常狀態、近期有哪些相關改變。
3. 劃定重現邊界：找出最小 Reproduction Case，確認哪些條件移除後症狀消失。
4. 建立 2–3 個可被推翻的 Hypotheses，不只選第一個直覺答案。
5. 逐項找 Supporting / Refuting Evidence，縮小因果鏈。
6. 繼續往上追，直到原因落在外部輸入、設計決策、依賴變化或系統不變式被破壞等可行動來源。
7. 將 Root Cause 與 Fix 分開；列出最小修法與替代方案的 Trade-off。
8. 定義能證明修復有效且不造成回歸的 Validation。

## Validation

Root Cause 必須能解釋：為什麼症狀發生、為什麼只在這些條件下發生，以及哪個 Evidence 能區分它與其他 Hypothesis。

## Failure Conditions

- 無法取得必要 Evidence 或穩定重現
- 只有相關性，沒有足以支持因果的證據
- 分析被要求直接修改系統，導致 Investigation 與 Fix 混在一起

## Completion Criteria

產出一條可追溯的因果鏈、至少一個有 Evidence 支持的 Root Cause 判定、修法選項與明確 Validation Plan；若仍無法確定，誠實標記 partial / blocked。
