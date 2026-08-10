# Skill: handoff

## Purpose

把一段工作的狀態整理成下一個 Agent 或人類可以直接接手的 Handoff Artifact，避免上下文只存在於對話記憶。

## Inputs

- Original Task Contract
- Work Performed
- Changed Scope
- Validation Evidence
- Known Risks / Open Questions
- Next Allowed Actions

## Outputs

```yaml
handoff:
  objective: ""
  completed: []
  changed_scope: []
  validation: []
  unresolved: []
  risks: []
  next_actions: []
  approval_required: []
```

## Preconditions

- 已有可描述的工作結果或明確失敗狀態。

## Permissions

- Read: task state + evidence
- Write: handoff artifact only

## Procedure

1. 重述 Objective，不複製整段歷史對話。
2. 列出已完成與未完成項目。
3. 列出實際 Changed Scope。
4. 附上 Validation Evidence 與失敗結果。
5. 明確列出 Risks / Open Questions。
6. 指定下一個 Actor 可以做什麼、不可以做什麼。
7. 將需要 Human Approval 的事項獨立列出。
8. 移除與後續工作無關的私人上下文。

## Validation

下一個 Actor 應能只靠 Handoff + 必要 Artifact 理解目前狀態，而不需要重新閱讀完整聊天紀錄。

## Failure Conditions

- 無法確認實際變更內容
- Validation 狀態未知卻被寫成已通過
- Handoff 需要洩漏不必要私人資訊才能成立

## Completion Criteria

Handoff 能回答：做了什麼、驗證了什麼、還缺什麼、風險是什麼、下一步誰能做什麼。
