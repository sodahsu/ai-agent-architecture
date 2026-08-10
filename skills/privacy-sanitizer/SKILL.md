# Skill: privacy-sanitizer

## Purpose

把私人實作經驗、架構決策或工作方法萃取成可公開內容，同時移除可識別個人、公司、客戶、帳號、機器、私有 Repository 與 Production 環境的資訊。

## Inputs

- Private Source Material（僅最小必要片段）
- Intended Public Lesson
- Privacy Policy
- Confidentiality Constraints

## Outputs

- Sanitized Public Draft
- Redaction / Generalization Summary
- Privacy Risk Findings
- Publish Readiness：ready / revise / keep-private

## Preconditions

- 已先定義「要公開的可重用方法」而不是直接要求公開原始資料。
- 不需要把完整 Private Memory 載入公開工作區。

## Permissions

- Read: minimum private source required
- Write: sanitized draft only
- Public publish: no（需另經 approval gate）

## Procedure

1. 先萃取方法、決策規則、架構模式或可重用 Lesson。
2. 移除真實姓名、Email、帳號、公司、客戶、私有專案與 Repository 名稱。
3. 移除 Token、Secret、Cookie、Credential、Webhook 與 Production Endpoint。
4. 將本機路徑、Hostname、IP、裝置資訊改為 Placeholder。
5. 將真實數據與情境改為 Synthetic Example，除非資料已明確公開且允許引用。
6. 檢查內容是否可透過組合線索回推真實身份或私人環境。
7. 確認匿名化後方法仍能獨立理解。
8. 輸出 ready / revise / keep-private 判定。

## High-risk Signals

- `@` address / account identifier
- `/Users/`、`/home/`、Windows drive path
- token / key / secret / password / cookie 搭配具體值
- 私有 URL、IP、Hostname、Webhook
- Employer / Client / Internal Project 名稱
- Raw Log、Screenshot、Config Dump

## Validation

公開草稿必須符合 `PRIVACY.md`，且在拿掉私人來源後仍可完整理解。

## Failure Conditions

- 方法無法與私人身份或機密資料分離
- 匿名化後仍可合理回推真實運作環境
- 內容本質上屬於 Confidential Work

## Completion Criteria

只留下可重用的方法、契約、模式或 Synthetic Example；公開內容本身不依賴任何私人識別資訊。
