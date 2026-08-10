# 公開 Skill 套件

這個目錄提供平台中立、可公開重用的 Skill Contract。Skill 描述的是「穩定可重複的執行程序」，不綁定特定 AI 模型，也不包含私人環境設定。

## 第一批 Skills

| Skill | 用途 |
|---|---|
| [task-contract](task-contract/SKILL.md) | 把模糊目標轉成 Scope、Constraints、Acceptance Criteria 與 Risk Gate |
| [bounded-implementation](bounded-implementation/SKILL.md) | 在明確寫入範圍內做最小可逆變更 |
| [evidence-review](evidence-review/SKILL.md) | 依 Acceptance Criteria 與 Evidence 做獨立審查 |
| [privacy-sanitizer](privacy-sanitizer/SKILL.md) | 將私人經驗萃取成不可回推身份的公開內容 |
| [handoff](handoff/SKILL.md) | 產出可交接、可追溯的工作狀態 |
| [capability-evaluation](capability-evaluation/SKILL.md) | 評估新 Skill / Tool / MCP 是否應 Adopt、Adapt 或 Reject |

## Skill Contract 最小格式

每個 Skill 至少應包含：

```text
Purpose
Inputs
Outputs
Preconditions
Permissions
Procedure
Validation
Failure Conditions
Completion Criteria
```

## 設計原則

- Skill 擁有程序，Agent 擁有判斷。
- Permission 必須是 Contract 的一部分，而不是執行時臨時擴張。
- Validation 必須能產生 Evidence。
- 失敗不代表可自動擴大 Scope。
- 高風險行為必須交給 Governance / Human Approval Gate。
