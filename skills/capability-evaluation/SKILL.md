# Skill: capability-evaluation

## Purpose

在新 Skill、Tool、MCP、Hook、Harness、Agent Framework 或外部能力進入穩定環境前，做一致、可追溯的採用評估。

## Inputs

- Candidate Source
- Intended Use Case
- Official Documentation
- Required Permissions
- License / Dependency Information
- Existing Capability Inventory

## Outputs

```yaml
candidate: ""
use_case: ""
benefits: []
risks:
  security: []
  privacy: []
  license: []
  maintenance: []
required_permissions: []
duplication: "none | partial | high"
decision: "adopt | adapt | reject | defer"
promotion_conditions: []
rollback: ""
```

## Preconditions

- Candidate 來源可確認。
- Intended Use Case 已明確。

## Permissions

- Read: public source / docs / isolated test target
- Install: isolated environment only when explicitly allowed
- Stable runtime write: no
- Secrets: no

## Procedure

1. 確認官方來源、維護狀態與 License。
2. 定義實際要解決的問題，避免為工具找問題。
3. 檢查現有能力是否已可解決。
4. 列出 Candidate 所需 Tool / File / Network / Write Permission。
5. 評估 Security、Privacy、Supply-chain、Maintenance 與 Lock-in Risk。
6. 在 Synthetic / Isolated Environment 做最小測試。
7. 比較直接 Adopt 與只 Adapt 方法的成本。
8. 給出 adopt / adapt / reject / defer。
9. 若 Adopt，定義 Promotion Gate、Validation 與 Rollback。

## Decision Guidance

- `adopt`：能力明確有價值，風險與維護成本可接受，且需要實際安裝。
- `adapt`：方法有價值，但不需要引入完整依賴或過高權限。
- `reject`：收益不足、重複度高、風險不可接受或來源不可信。
- `defer`：目前證據不足，等待更成熟版本或更明確需求。

## Validation

結論必須能追溯到來源、Use Case、Permission、Risk 與 Test Evidence，而不是只依熱門程度或主觀印象。

## Failure Conditions

- Candidate 來源無法確認
- License 不清楚且預計公開再散布
- 測試必須使用真實 Secret 或 Production 才能進行
- Required Permission 明顯超出 Use Case 合理範圍

## Completion Criteria

產出一份能讓第三方理解「為什麼採用／不採用，以及如何安全 Promotion」的決策紀錄。
