# Skill: task-checkpoint

## Purpose

把做到一半的 Git 工作停在乾淨、可驗證、可接續的邊界，留下明確進度與下一步；Checkpoint 不代表任務已完成，也不自動 Push / Merge。

## Inputs

- Current Goal
- Allowed Scope
- Current Git State
- Relevant Validation Commands
- Whether a checkpoint commit is explicitly allowed

## Outputs

- Progress / Handoff Artifact
- Validation Status
- Changed Scope Summary
- Remaining Work
- Exact Next Action
- Optional Checkpoint Commit

## Preconditions

- 能辨識目前 Repository / Branch 與本次任務範圍。
- 不得把其他任務或無法判定歸屬的未提交變更混入 Checkpoint。

## Permissions

- Read: repository rules, git status / diff, task-related files
- Write: progress artifact
- Commit: only when explicitly allowed, task files only
- Push / Merge / Deploy / Reset / Clean: no

## Procedure

1. 凍結 Scope：不開始新的功能、不順便重構，只收斂目前最小工作單元。
2. 讀取 Git Status / Diff，區分本任務變更與其他未提交內容。
3. 執行與目前小節直接相關的最小 Lint / Typecheck / Test / Build。
4. 若驗證失敗，只修正原 Scope 內可明確判斷的問題；否則保留失敗 Evidence。
5. 建立或更新進度 Artifact，至少包含 Goal、Branch、Completed、Current State、Remaining、Changed Files、Validation、Risks、Next Action。
6. `Next Action` 必須精確到檔案／區塊／驗證動作，不可只寫「繼續完成」。
7. 若明確允許建立 checkpoint commit，只 Stage 本任務檔案與進度 Artifact；不用 `git add -A` 掩蓋混合工作目錄。
8. Commit Message 明確標示 checkpoint / WIP，不把失敗或未完成狀態包裝成完成。
9. 再次檢查 Git Status，回報剩餘未提交內容的歸屬；然後停止，不自行開始下一階段。

## Validation

Checkpoint 後，下一個 Actor 必須能只靠 Git State + Progress Artifact + Validation Evidence 知道目前做到哪裡以及第一個下一步。

## Failure Conditions

- 工作目錄包含無法安全判斷歸屬的變更
- 正在進行不可安全中斷的 Migration / Deploy / Destructive Operation
- Checkpoint 會包含 Secret、Build Artifact 或無關檔案
- 要建立 Commit 但使用者未授權或 Repository Policy 禁止

## Completion Criteria

目前工作已停在可理解的邊界；驗證狀態誠實記錄；沒有誤動其他工作；若有 Commit，它只包含本任務明確 Scope，且沒有 Push / Merge。
