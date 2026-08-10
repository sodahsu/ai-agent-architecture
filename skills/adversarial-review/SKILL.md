# Skill: adversarial-review

## Purpose

對重大結論、架構判斷或高影響建議做獨立反方審查，降低單一 Agent 自我驗證造成的確認偏誤。

## Inputs

- Claim / Decision
- Supporting Evidence
- Impact Scope
- Risk Level
- 可用的獨立 Reviewer / Lens

## Outputs

- Lens-by-lens Verdict
- Confirmed / Revise / Block 判定
- Refutation Reasons
- Residual Risks
- Required Re-review（若需要）

## Preconditions

- 待審查主張已經整理成自足的 Claim Package。
- Evidence 與 Impact Scope 可被 Reviewer 取得。
- 適用於重大判斷，不用在純格式調整或低風險瑣碎工作。

## Permissions

- Read: claim package + evidence
- Write: review artifact only
- Target modification: none
- Merge / Deploy: none

## Procedure

1. 將每一個可獨立成立的 Claim 分開，不把多條發現打包成一個模糊總結。
2. 至少使用三個互相獨立的審查鏡頭：
   - Skeptic：證據真的足以支撐結論嗎？
   - Red Team：如果結論錯了，最可能從哪裡被攻破？
   - Simplifier：是否存在更簡單、較低風險的解釋或方案？
3. 各鏡頭先獨立判斷，再整合結果；不要先共享彼此結論。
4. 對每個鏡頭記錄 `survived / refuted / uncertain` 與 Evidence。
5. 若多數鏡頭無法支持 Claim，判定 `revise` 或 `block`，不可把反方理由吞掉。
6. 高風險 Claim 修正後必須重新送審；低風險 Claim 可在一輪後保留 Residual Risk 結束。

## Validation

每個 Verdict 都必須能追溯到具體 Evidence 或明確缺口；不能使用「感覺合理」作為支持理由。

## Failure Conditions

- Reviewer 不具獨立性
- Claim Package 缺少必要 Evidence
- 多個彼此不同的 Claim 被混在一起，無法分別裁決
- 需要修改 Target 才能完成審查

## Completion Criteria

每個 Claim 都有獨立 Verdict、反方理由與 Residual Risk；最終決策能清楚說明為何 confirmed、需要 revise，或必須 block。
