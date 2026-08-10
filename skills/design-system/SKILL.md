# Skill: design-system

## Purpose

建立或審查 Design System 的 Component、Token 與 Governance 規則，確保新增模式有明確語意、使用邊界、狀態與無障礙要求，而不是把單次例外累積成系統債務。

## Inputs

- Task Type：component / token / governance / audit
- Target / Details
- Existing Design System Context（可選）
- Product / Accessibility Constraints（可選）

## Outputs

- Component Contract / Token Proposal / Governance Rule / Audit Report
- Compatibility Notes
- Migration / Adoption Notes（若適用）
- Open Tensions

## Preconditions

- 已知道要處理的是系統層問題，而不是單一畫面微調。
- 若 Existing System 不可取得，輸出必須明示這是新提案，不得假裝與既有系統相容。

## Permissions

- Read: design-system-relevant artifacts
- Write: proposal / documentation only by default
- Shared token / component source modification: requires explicit assignment

## Procedure

1. 判斷工作類型：Component、Token、Governance 或 Audit。
2. Component：定義 Purpose、Do / Don't、Variants、Props、States、Accessibility 與 Usage Rules。
3. Token：優先使用語意命名，說明使用意圖與影響範圍，不只列原始值。
4. Governance：定義何時可新增 Variant、何時應重用、誰負責 Review，以及例外如何記錄。
5. Audit：找出重複模式、語意衝突、未覆蓋狀態與不一致使用方式。
6. 檢查新規則是否影響多個畫面／元件；若會，列出 Migration / Compatibility Notes。
7. 不刪掉有價值的歷史決策；若需要替代舊模式，標示 Deprecated / Replacement。
8. 對仍未解的系統張力建立 Open Tensions，而不是偷偷選一邊。

## Validation

每個新 Component / Token / Governance Rule 必須能回答：為什麼存在、什麼時候用、什麼時候不要用、有哪些狀態、如何驗證一致性與無障礙。

## Failure Conditions

- 只為單一頁面例外建立全域 Token / Component
- Existing System 衝突尚未處理卻直接宣告新規則為標準
- 需要大量 Migration 但沒有影響範圍與回復方案

## Completion Criteria

產出可被其他設計師與 Implementer 一致理解的系統規則；新模式有清楚的使用與禁止邊界，且任何重大相容性風險已被揭露。
