# Skill: roadmap-planning

## Purpose

把高層產品或專案目標拆成可交付 Milestones、Task Dependencies、優先順序與近期可開始行動；預設只產出規劃，不直接寫入外部系統。

## Inputs

- Goal
- Target Users / System（可選）
- Time Horizon（可選）
- Constraints
- Known Dependencies（可選）

## Outputs

- Roadmap
- Milestones
- Task Breakdown
- Priority / Dependency Map
- Near-term Actions
- Open Assumptions

## Preconditions

- Goal 不為空。
- 若缺少日期，不得自行捏造正式 Deadline；可以使用相對階段或標記 TBD。

## Permissions

- Read: planning context only
- Write: planning artifact only
- External issue / milestone creation: none by default

## Procedure

1. 用 Outcome 句型重述 Goal：完成後誰的什麼狀態會改變。
2. 將 Goal 拆成 2–5 個可獨立驗收的 Milestones。
3. 每個 Milestone 拆成最小必要 Tasks，標出 Dependency。
4. 對 Tasks 以 Impact / Effort / Risk 做相對排序；沒有足夠資料時使用相對尺度，不偽造精準估時。
5. 標記 Critical Path、Blocked Items 與尚未驗證的 Assumptions。
6. 列出近期可開始的 1–3 個行動，避免 Roadmap 只有長期願景。
7. 若需要把 Milestones 寫入 GitHub、Jira 或其他工具，將其留在下一個明確授權的 Handoff，不在本 Skill 自動寫入。

## Validation

每個 Milestone 都必須代表可觀察的成果，而不是單純活動；每個高優先 Task 必須能說明其 Dependency 與為何優先。

## Failure Conditions

- Goal 本身彼此矛盾
- 需要未知商業承諾才能排出看似精準的日期
- Roadmap 被要求直接寫入外部系統但尚未取得授權

## Completion Criteria

Roadmap 能讓另一個 Actor 清楚知道：階段性成果、先後依賴、優先工作、未知假設與下一步，而且沒有把不確定資訊包裝成既定承諾。
