# Skill: clarify

## Purpose

在執行前檢查 Intent、Scope 與 Scale，將模糊請求轉成足以安全開始工作的指令，同時避免對已經清楚的小任務過度提問。

## Inputs

- Raw Instruction
- Available Context（可選）
- Governance / Write Boundary

## Outputs

- Clarified Instruction
- Assumptions
- Plan Required：yes / no
- Blocking Question（只有真的無法安全前進時）

## Preconditions

- 已取得使用者目前的請求。
- 不需要載入完整私人歷史才能判斷當前任務。

## Permissions

- Read: current request + task-relevant context
- Write: none
- External actions: none

## Procedure

1. 判斷 Intent：要讓什麼狀態發生什麼改變。
2. 判斷 Scope：做到哪裡停止、哪些內容明確不做。
3. 判斷 Scale：小型可逆修改，或需要規劃的多步驟／高影響工作。
4. 若 Intent 與 Scope 已清楚，直接產出 Clarified Instruction，不為了形式提問。
5. 若能用低風險假設安全前進，先列出 Assumption，再開始只讀或可逆工作。
6. 只有缺少的資訊會實際改變執行方向、權限或完成條件時，才提出一個最關鍵問題。
7. Scale 大或影響面廣時標記 `plan_required: yes`。

## Validation

輸出必須能回答：要做什麼、做到哪裡、哪些是假設、是否需要規劃，以及是否存在真正阻擋執行的未知資訊。

## Failure Conditions

- Intent 彼此衝突且無法安全推定
- Scope 不清楚且任何合理假設都可能造成不必要寫入
- 必要權限未定義

## Completion Criteria

另一個 Agent 可以只讀 Clarified Instruction 與 Assumptions 就安全開始下一步，不需要重新詢問已經明確的資訊。
