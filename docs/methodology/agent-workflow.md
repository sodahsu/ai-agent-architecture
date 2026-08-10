# Agent 工作方法（Agent Workflow Methodology）

## 目的

把模糊工作轉成可控制、可驗證、可交接的流程，讓多個 AI Agent 協作時，不會失去 Ownership、Context 或 Review Responsibility。

## 工作流程

```text
Goal
 ↓
Clarify Constraints
 ↓
Plan Work
 ↓
Assign Agent / Skill
 ↓
Execute Smallest Safe Unit
 ↓
Validate Result
 ↓
Review Risk
 ↓
Human Approval when Required
 ↓
Handoff or Complete
```

## 方法

### 1. 從目標開始

在選工具之前，先明確定義：

- 預期成果
- 限制條件
- Non-goals
- Success Criteria

如果目標與完成條件不清楚，後面的 Agent Routing 只會放大模糊性。

### 2. 把規劃與執行分開

Planning 負責決定「應該改什麼」；Execution 負責在既定邊界內完成修改。

這種分離可以讓 Review、Rollback 與責任追蹤更容易。

### 3. 依能力與風險路由

選擇 Agent 的理由應是它具備任務需要的能力，而不是它擁有最多權限。

每個 Assignment 只提供完成該任務真正需要的：

- Context
- Tools
- Permission
- Write Scope

### 4. 使用小而可回復的工作單位

優先使用：

- Feature Branch
- Draft PR
- Proposed Change
- Preview
- Generated Artifact

避免直接進行不可逆修改。

### 5. 交接前先驗證

每個工作單位都應定義自己的 Verification，例如：

- Test
- Lint
- Typecheck
- Build
- Content Check
- Policy Check
- Structured Review

「Agent 說完成了」不是驗證證據。

### 6. 保留明確 Handoff State

交接 Artifact 至少應回答：

- 原本要求什麼？
- 實際改了什麼？
- 驗證了什麼？
- 還有哪些已知風險或未解問題？
- 下一個 Actor 被允許做什麼？

這讓下一個 Agent 或人類不需要重新猜測前一段工作的狀態。

### 7. 在風險邊界要求人工批准

以下高影響操作不應被推定為「使用者既然叫 AI 做事，就代表全部同意」：

- 公開發布
- Production Deployment
- Destructive Action
- Credential / Secret 操作
- Migration
- Billing / Cost
- Protected Branch 寫入
- 其他不可逆或高影響變更

## 核心原則

多代理協作的目的不是追求最大自主權，而是：

> **清楚派工、有限授權、可驗證交付，以及明確的回程。**

真正成熟的 Agent 系統，不只知道如何往前做，也知道什麼時候要停、怎麼驗證，以及如何把狀態完整交回下一個決策者。