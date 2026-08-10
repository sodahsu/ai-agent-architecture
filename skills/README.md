# 公開 Skill 套件

這個目錄提供平台中立、可公開重用的 Skill Contract。Skill 描述的是「穩定可重複的執行程序」，不綁定特定 AI 模型，也不包含私人環境設定。

目前共有 **18 個 Public Skills**。

## Core / Governance

| Skill | 用途 |
|---|---|
| [clarify](clarify/SKILL.md) | 在執行前檢查 Intent / Scope / Scale，避免過度詢問或錯誤擴張 |
| [task-contract](task-contract/SKILL.md) | 把目標轉成 Scope、Constraints、Acceptance Criteria 與 Risk Gate |
| [bounded-implementation](bounded-implementation/SKILL.md) | 在明確寫入範圍內做最小可逆變更 |
| [evidence-review](evidence-review/SKILL.md) | 依 Acceptance Criteria 與 Evidence 做獨立審查 |
| [adversarial-review](adversarial-review/SKILL.md) | 用獨立反方鏡頭檢查重大結論與架構判斷 |
| [privacy-sanitizer](privacy-sanitizer/SKILL.md) | 將私人經驗萃取成不可回推身份的公開內容 |
| [handoff](handoff/SKILL.md) | 產出可交接、可追溯的工作狀態 |
| [capability-evaluation](capability-evaluation/SKILL.md) | 評估新 Skill / Tool / MCP 是否應 Adopt、Adapt 或 Reject |

## Product / Knowledge

| Skill | 用途 |
|---|---|
| [roadmap-planning](roadmap-planning/SKILL.md) | Goal → Milestones → Tasks → Dependencies → Near-term Actions |
| [meeting-to-decisions](meeting-to-decisions/SKILL.md) | Transcript / Notes → Decisions / Actions / Risks / Open Questions |

## Design

| Skill | 用途 |
|---|---|
| [design-brief](design-brief/SKILL.md) | Problem / User / Scope / Success Criteria 的設計啟動契約 |
| [design-review](design-review/SKILL.md) | 問題對焦、流程、系統一致性、Accessibility 的結構化評審 |
| [design-spec](design-spec/SKILL.md) | 將已決定設計轉成行為、狀態與 Edge Case 規格 |
| [design-system](design-system/SKILL.md) | Component / Token / Governance / Audit 的系統級規則 |

## Engineering / Operations

| Skill | 用途 |
|---|---|
| [code-review](code-review/SKILL.md) | Correctness / Security / Regression / Maintainability 的證據式審查 |
| [root-cause](root-cause/SKILL.md) | 症狀 → 重現邊界 → Hypothesis → 因果鏈 → Validation |
| [task-checkpoint](task-checkpoint/SKILL.md) | 把做到一半的 Git 工作停在安全、可接續的 Checkpoint |
| [skill-audit](skill-audit/SKILL.md) | 檢查 Skill Contract、Catalog Drift、Privacy 與 Maintainability |

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
- 公開 Skill 不得依賴私人 Memory、私人 Repository 名稱、個人帳號、本機固定路徑或 Production Credential 才能成立。
- Provider-specific 行為放 Adapter；核心 Skill 保持 Runtime-neutral。

哪些能力刻意不公開，見 [`docs/governance/public-capability-catalog.md`](../docs/governance/public-capability-catalog.md)。
