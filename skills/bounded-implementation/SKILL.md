# Skill: bounded-implementation

## Purpose

在明確 Scope、Write Boundary 與 Acceptance Criteria 內完成最小、安全、可逆的變更。

## Inputs

- Task Contract
- Assignment Brief
- Relevant Files / Artifacts
- Allowed Tools

## Outputs

- Changed Scope Summary
- Implementation Result
- Validation Evidence
- Known Risks
- Rollback / Revert Note

## Preconditions

- Scope 已明確。
- Write Scope 已明確。
- 高風險操作已被排除或取得明確批准。

## Permissions

預設：

```text
read        task scope only
write       feature branch / sandbox only
merge       no
deploy      no
secrets     no
```

## Procedure

1. 讀取與任務直接相關的規範與檔案。
2. 確認目前狀態與 Task Contract 一致。
3. 找出能滿足 Acceptance Criteria 的最小變更。
4. 避免無關重構、新抽象層或額外 Dependency。
5. 實作變更。
6. 執行 Contract 指定的 Validation。
7. 若驗證失敗且能在原 Scope 修正，修正後重跑。
8. 若修正需要擴權或擴 Scope，停止並回報。
9. 產出 Evidence 與 Handoff。

## Validation

至少要有與變更相符的 Test / Lint / Build / Content Check / Structured Review 之一；不能只用 Agent 自我宣告取代驗證。

## Failure Conditions

- 必須直接修改 Protected Branch 才能繼續
- 需要未批准 Credential / Production Access
- 需要超出 Task Contract 的重大重構
- Validation 無法在現有邊界內完成

## Completion Criteria

變更符合 Acceptance Criteria、Validation 通過、Scope 未外溢，且下一個角色可以只依 Evidence 與 Artifact 進行審查，不必依賴實作者的口頭摘要。
