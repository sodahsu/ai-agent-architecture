# 匿名範例：功能交付（Feature Delivery）

這是一個完全虛構的範例，用來示範架構如何運作。內容不對應任何真實人物、雇主、客戶、repository、帳號或 production system。

## 情境

一個虛構產品團隊想改善 Dashboard 的 Empty State，讓第一次使用產品的人更清楚下一步該做什麼。

限制條件：

- 不修改 Authentication
- 不進行 Production Deployment
- 既有 Component API 必須維持相容
- 變更在 merge 前必須可被 review
- Reviewer 不應取得 Write Permission

## Step 1 — Intent｜定義意圖

操作者先提供目標，而不是直接寫一大段實作 Prompt：

```text
改善範例 Dashboard 的 Empty State，讓第一次使用的人知道下一步該做什麼。
```

Control Layer 把這個目標轉成明確 Assignment Contract：

```yaml
objective: "改善 Dashboard Empty State"
scope:
  include:
    - "empty-state component"
    - "related tests"
  exclude:
    - "authentication"
    - "billing"
    - "deployment"
acceptance_criteria:
  - "主要下一步行動清楚可見"
  - "Keyboard Interaction 維持正常"
  - "既有 Public Component API 不變"
mutation_policy:
  - "feature branch only"
  - "no direct main write"
```

## Step 2 — Context Retrieval｜取得必要上下文

Knowledge Role 只回傳被允許、且與任務直接相關的資訊：

```yaml
context_contract:
  product_rule: "新使用者應只看到一個主要下一步行動"
  design_rule: "新增 Variant 前先使用既有 Design System Component"
  technical_rule: "Public Component API 必須保持穩定"
```

它**不會**輸出無關筆記、個人歷史、Credential 或完整 Memory。

## Step 3 — Routing｜拆分與路由

Coordinator 建立三個 Assignment：

```text
A. 檢查目前實作              read-only
B. 執行有限範圍修改          branch write
C. 驗證 acceptance criteria  read-only
```

三個角色取得不同 Permission，而不是所有 Agent 都拿到同一組權限。

## Step 4 — Execution｜執行

Implementation Agent 優先使用已穩定的 Skill，而不是每次重新發明流程：

```text
inspect-component
      ↓
plan-minimal-change
      ↓
implement-feature
      ↓
run-tests
      ↓
prepare-handoff
```

如果中途需要一個尚未驗證的外部能力，應先送進 Evaluation Role。未審查的外部工具不應直接安裝進 Stable Environment。

## Step 5 — Validation｜驗證

Executor 回傳結果與 Evidence：

```yaml
result:
  status: "implemented"
  changed_scope:
    - "empty-state component"
    - "component tests"
  validation:
    unit_tests: "pass"
    accessibility_check: "pass"
    api_compatibility: "unchanged"
  mutation:
    branch: "feature/example-empty-state"
    main_modified: false
```

Reviewer 取得原始 Acceptance Criteria 與 Evidence，不直接相信 Executor 自己宣告的完成狀態。

如果 Reviewer 使用與實作推理隔離的 reviewer / context，可標記為 `independent review`；如果只在同一 session 切換成 Reviewer 視角，則標記為 `structured-self-review`。兩者都可以提供價值，但驗證強度不能混為一談。

## Step 6 — Approval Gate｜人工批准

Merge 的影響高於在 Feature Branch 上修改，因此流程停在可 Review 的 Artifact：

```text
implementation
    ↓
validation
    ↓
draft change / review artifact
    ↓
HUMAN APPROVAL
    ↓
merge decision
```

Executor 有能力做出正確修改，不代表它自動有權 Merge 或 Deploy。

## Step 7 — Public Distillation｜公開萃取

私人實作內容不直接複製進公開架構 repository。

真正可以公開的是萃取後的方法，例如：

> 把 Inspect、Implement、Review 拆成不同 Assignment，讓每個 Agent 只取得自己角色需要的上下文與權限。

這個 Lesson 可以再轉成：

- Documentation
- Template
- Pattern
- Synthetic Example

## 這個範例證明什麼

- Intent 會被轉成明確 Scope 與 Acceptance Criteria
- 私人上下文被壓縮成最小 Context Contract
- 不同 Agent 取得不同 Permission
- Stable Skill 負責可重複程序
- 即使 Execution 成功，Governance 仍限制 Mutation
- Validation Evidence 必須跟著結果一起回傳
- Reviewer independence 取決於實際 Context Isolation，不由角色名稱保證
- 公開文件保存的是方法，而不是原始私人工作內容
