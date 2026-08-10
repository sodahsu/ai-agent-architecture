# Skill: meeting-to-decisions

## Purpose

把會議逐字稿、筆記或長對話壓縮成可追溯的 Decision Record：已拍板決策、Action Items、Risks、Open Questions 與一句話變化摘要。

## Inputs

- Meeting Transcript / Notes
- Meeting Name / Date（可選）
- Participant Labels（可選，公開範例應匿名化）
- Confidentiality Constraints

## Outputs

- Decisions
- Action Items
- Risks / Disagreements
- Open Questions
- Source Trace
- One-line Change Summary

## Preconditions

- 只整理來源中實際存在的內容；沒有出現的資訊標記 unknown / not discussed，不自行補完。
- 涉及敏感人事、商業或個人資料時，只保留任務需要的最小內容。

## Permissions

- Read: provided meeting source
- Write: decision artifact only
- External knowledge-base write: none by default

## Procedure

1. 完整讀取來源，標出有人做出選擇、承諾、否決或明確未決的片段。
2. 區分四類：Decision、Action、Risk / Disagreement、Open Question。
3. Decision 必須描述「選了什麼／不選什麼」或狀態正式改變；一般狀態更新不算 Decision。
4. Action 必須有 Owner；沒有 Owner 的待辦移到 Open Question，不自行指派給「大家」。
5. 對每一項保留可追溯 Source Trace（段落、時間戳或匿名發言標記）。
6. 將敏感人物／公司／客戶識別資訊依公開目的泛化或移除。
7. 用一句話總結「這場會議改變了什麼」，不寫流水帳。
8. 若要寫入 Notion、Obsidian、Issue Tracker 等外部系統，留作下一個明確授權步驟。

## Validation

每個 Decision / Action 必須能回到來源找到依據；Decision 與 Discussion、Action 與 Wish 必須能清楚區分。

## Failure Conditions

- Transcript 品質不足到無法辨識語意或責任歸屬
- 內容涉及高度敏感資訊且無法在最小 Context 下安全處理
- 被要求把未知 Owner / Deadline 自行補成確定值

## Completion Criteria

Decision Record 只保留來源可證實的決策與承諾，Action 有明確 Owner 或被列入待釐清，敏感 Context 未被不必要擴散，下一個 Actor 能直接依此追蹤後續工作。
