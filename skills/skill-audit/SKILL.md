# Skill: skill-audit

## Purpose

審查 `skills/**/SKILL.md` 的契約完整性、索引漂移、重複規則、硬編碼環境依賴與安全邊界，避免 Skill 數量增加後逐漸失去可預測性與可維護性。

## Inputs

- Skill Scope：single / domain / all
- Skill Catalog / Index（若存在）
- Repository Skill Contract Rules
- Mode：quick / full

## Outputs

- Audit Report
- Findings by Severity
- Missing / Drifted Contracts
- Maintainability Risks
- Recommended Fix Order

## Preconditions

- Repository 中存在 `skills/`。
- Audit 預設 Read-only；任何行為修改需另外授權。

## Permissions

- Read: skills + index + relevant governance
- Search: repository structure / content
- Write: audit report only by default
- Skill behavior modification: none

## Procedure

1. 列出實際存在的 `SKILL.md`，並與 Catalog / README / Index 比對。
2. 檢查每個 Skill 是否具有 Purpose、Inputs、Outputs、Preconditions、Permissions、Procedure、Validation、Failure Conditions、Completion Criteria。
3. 檢查 Skill 是否含硬編碼本機路徑、私人 Repository、Credential、Machine Identifier 或 Production Context。
4. 檢查 Write-capable Skill 是否有 Write Scope、Stop Condition 或 Approval Boundary。
5. 檢查重複 Procedure 是否應回到單一真相源，而不是在多個 Adapter / Skill 複製。
6. 檢查已不存在的路徑、過期 Skill 名稱、Catalog Drift 與不可達能力。
7. 對過長或同時處理多領域的 Skill 標記 Maintainability Risk；不要在 Audit 過程順便重寫行為。
8. 依 P1 / P2 / P3 或 Blocking / Important / Suggestion 排序 Findings。

## Validation

Audit Report 中每個 Finding 都要能指向具體檔案、缺失欄位或可搜尋的 Drift Evidence；不能只寫抽象「架構可能變亂」。

## Failure Conditions

- `skills/` 不存在
- 部分 Skill 無法讀取且缺口未被報告
- Audit 被要求直接重寫所有 Skill，導致 Review 與 Implementation 混在一起

## Completion Criteria

所有 Scope 內 Skill 已被盤點；Contract、Privacy、Permission、Catalog 與 Maintainability Drift 有明確 Finding 與修正優先順序，且 Audit 本身沒有改變 Skill 行為。
