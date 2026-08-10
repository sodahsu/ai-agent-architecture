# Spec: Public Agent and Skill Capabilities

## Requirement: Public capability independence

Public Agent / Skill MUST be usable without Personal Memory、私人 Repository、Credential、Machine-specific Path 或 Production Context。

### Scenario: Public Skill installation

- WHEN 使用者安裝公開核心到自己的 Repository
- THEN 每個 Public Skill MUST 能只依 Task Context 與明確 Permission Contract 被理解
- AND MUST NOT require 原作者的私人環境才能成立

## Requirement: Agent dimensions remain explicit

Public Agent MUST 區分 Lifecycle Responsibility 與 Domain Routing，避免把「專業領域」誤當成「工作生命週期角色」。

### Scenario: Domain Agent routes an implementation task

- GIVEN Design / Product / People Domain Agent 已完成領域判斷
- WHEN 任務需要實際寫入
- THEN Domain Agent MUST NOT 因此自動取得 Implementer 權限
- AND 寫入仍 MUST 經 Lifecycle Assignment / Permission Boundary

## Requirement: Public Skill contract

每個 Public Skill MUST 包含：

- Purpose
- Inputs
- Outputs
- Preconditions
- Permissions
- Procedure
- Validation
- Failure Conditions
- Completion Criteria

### Scenario: Contract audit

- WHEN 維護者執行 `bash scripts/check.sh`
- THEN 所有 `skills/*/SKILL.md` MUST 通過 Contract heading 檢查
- AND 所有 `agents/*.md`（README 除外）MUST 通過 Agent Contract heading 檢查

## Requirement: Private-runtime capabilities stay excluded

與 Personal Memory、私人發布路徑、Private People Data、Provider Account Routing、Billing / Quota、Production Deployment 或 Machine Sync 強耦合的能力 MUST NOT 被直接複製到 Public Core。

### Scenario: Private capability promotion

- GIVEN 一個 Private Runtime Capability 被選為公開候選
- WHEN 準備加入 Public Core
- THEN MUST 先萃取 reusable method
- AND 移除 personal / repository / credential coupling
- AND 完成 License / Dependency / Privacy Review
- AND 使用 Synthetic Example 或 Generic Contract

## Requirement: Public catalog is explicit

Repository MUST 提供目前 Public Core 與 Keep-private 類別清單，讓後續維護者不需要重新猜測公開邊界。

### Scenario: Maintainer evaluates a new capability

- WHEN 維護者考慮新增 Agent / Skill
- THEN SHOULD 先閱讀 `docs/governance/public-capability-catalog.md`
- AND 若能力不符合 Public Core 判定原則，MUST 保持 Private 或先 Adapt

## Requirement: Installation includes the complete public package

Installer MUST 複製目前公開 `agents/` 與 `skills/` 真相源，而不是維護第二份手寫白名單。

### Scenario: New public capability is added

- GIVEN 新 Agent / Skill 已加入根目錄 Public Core 並通過檢查
- WHEN 使用者重新安裝相同 Adapter
- THEN 新能力 MUST 隨 `agents/` / `skills/` 一起被安裝
- AND Adapter MUST NOT 需要複製該能力的完整 Procedure
