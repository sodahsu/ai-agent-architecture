# Skill: adversarial-review

## Purpose

對重大結論、架構判斷或高影響建議做反方審查，降低單一 Agent 自我驗證造成的確認偏誤。若平台能提供彼此隔離的 reviewer / context，可執行 independent review；否則只能標記為 structured multi-lens self-review。

## Inputs

- Claim / Decision
- Supporting Evidence
- Impact Scope
- Risk Level
- 可用的 Reviewer / Context / Lens

## Outputs

- Review Mode：independent / structured-self-review
- Lens-by-lens Verdict
- Confirmed / Revise / Block 判定
- Refutation Reasons
- Residual Risks
- Required Re-review（若需要）

## Preconditions

- 待審查主張已經整理成自足的 Claim Package。
- Evidence 與 Impact Scope 可被 Reviewer 取得。
- 適用於重大判斷，不用在純格式調整或低風險瑣碎工作。
- 若使用者或 Governance 明確要求 independent review，必須有與原實作推理隔離的 reviewer / context；同一 session 切換角色不算獨立。

## Permissions

- Read: claim package + evidence
- Write: review artifact only
- Target modification: none
- Merge / Deploy: none

## Procedure

1. 將每一個可獨立成立的 Claim 分開，不把多條發現打包成一個模糊總結。
2. 先判定 Review Mode：
   - `independent`：不同 reviewer / context 各自取得 Claim Package，且不先共享彼此結論或原實作者的推理過程。
   - `structured-self-review`：同一 session 只能用不同 lens 重新審視，不宣稱 reviewer independence。
3. 至少使用三個審查鏡頭：
   - Skeptic：證據真的足以支撐結論嗎？
   - Red Team：如果結論錯了，最可能從哪裡被攻破？
   - Simplifier：是否存在更簡單、較低風險的解釋或方案？
4. 在 `independent` 模式，各 reviewer 先獨立判斷再整合；在 `structured-self-review` 模式，三個 lens 仍需分別列出 Evidence 與反駁理由。
5. 對每個鏡頭記錄 `survived / refuted / uncertain` 與 Evidence。
6. 若多數鏡頭無法支持 Claim，判定 `revise` 或 `block`，不可把反方理由吞掉。
7. 高風險 Claim 修正後必須重新送審；低風險 Claim 可在一輪後保留 Residual Risk 結束。

## Validation

每個 Verdict 都必須能追溯到具體 Evidence 或明確缺口，且輸出必須標出 Review Mode；不能把同一 session 的角色切換包裝成真正的獨立驗證。

## Failure Conditions

- 明確要求 independent review，但無法取得隔離 reviewer / context
- Claim Package 缺少必要 Evidence
- 多個彼此不同的 Claim 被混在一起，無法分別裁決
- 需要修改 Target 才能完成審查

## Completion Criteria

每個 Claim 都有 Review Mode、逐 lens Verdict、反方理由與 Residual Risk；最終決策能清楚說明為何 confirmed、需要 revise，或必須 block，且沒有誇大審查的獨立性。
