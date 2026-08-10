# 架構層級模型（Architecture Layer Model）

這份文件用來回答一個最容易混淆的問題：

> 六倉、Agent、Skill、Governance、Workflow、Artifact，到底是不是同一層？

答案是：**不是。**

它們分別屬於不同層級，而且有些是垂直層級，有些是橫跨整個系統的控制機制。

---

## 一張圖先看懂

```text
Level 0  系統邊界
         ├─ Private Operating Space
         └─ Public Evidence Space

Level 1  Repository Architecture（六倉）
         ├─ Knowledge Repository
         ├─ Agent Control Repository
         ├─ Evaluation Repository
         ├─ Execution Repository
         ├─ Lab Repository
         └─ Portfolio Repository

Level 2  Operating Model（倉內運作模型）
         ├─ Agent     → 判斷與協調
         ├─ Skill     → 可重複執行契約
         └─ Tools     → 實際操作能力

         Governance  → 橫跨 Level 1～4 的控制面

Level 3  Workflow（工作流程）
         Intent
           ↓
         Context
           ↓
         Routing
           ↓
         Assignment
           ↓
         Execution
           ↓
         Validation
           ↓
         Approval
           ↓
         Handoff

Level 4  Artifact / Contract（交換介面）
         ├─ Context Contract
         ├─ Capability Decision
         ├─ Assignment Brief
         ├─ Execution Evidence
         ├─ Public Insight
         └─ Portfolio Evidence
```

---

## Level 0｜系統邊界

這是最外層，先定義「什麼屬於私人運作，什麼可以成為公開證據」。

```text
Private Operating Space
        │
        │  必須經過去識別化與 Review
        ↓
Public Evidence Space
```

這一層回答的是：

- 哪些資料永遠不能公開？
- 哪些內容可以經過 distillation 後公開？
- Public Repository 是否可能反推出 Private Runtime？

**這一層不是 Repository 結構，而是整個系統的安全邊界。**

---

## Level 1｜Repository Architecture：六倉是最高層的責任分區

六倉是**系統級責任分離**，不是六個執行步驟，也不是六個 Agent。

```text
AI Agent System
├─ Knowledge Repository
├─ Agent Control Repository
├─ Evaluation Repository
├─ Execution Repository
├─ Lab Repository
└─ Portfolio Repository
```

每一倉回答的是「這類責任應該由哪個邊界承擔」。

| Repository Role | 主要責任 |
|---|---|
| Knowledge | 私人知識與 canonical context |
| Agent Control | 穩定規則、Routing、Skills、Governance Policy |
| Evaluation | 新能力測試與導入決策 |
| Execution | 非同步執行、排程與 Runtime Automation |
| Lab | 公開實驗與學習輸出 |
| Portfolio | 精選成果與 Case Study |

### 重要

**六倉是 Responsibility Boundary，不代表一定要有六個實體 Git Repository。**

小型系統可以合併角色；大型系統可以再拆分。真正不可消失的是責任邊界本身。

---

## Level 2｜Operating Model：Agent / Skill / Tool 是倉內執行模型

Agent、Skill 與 Tool 不是六倉的同層概念。

它們主要描述「一個任務進入 Agent Control / Execution 後，內部怎麼運作」。

```text
Agent Control Repository
        │
        ├─ Agent
        │    └─ 判斷、路由、協調、升級
        │
        ├─ Skill
        │    └─ 穩定、可重複的執行契約
        │
        └─ Tool
             └─ File / API / Git / Browser / Test Runner ...
```

### Agent

Agent 負責「決定該做什麼」。

### Skill

Skill 負責「按照已定義程序怎麼做」。

### Tool

Tool 負責「實際對外部世界產生讀寫操作」。

因此：

```text
Agent ≠ Skill
Skill ≠ Tool
Repository ≠ Agent
```

---

## Governance 不是一個普通層，而是 Cross-Cutting Control Plane

Governance 最容易被誤解。

它不是：

```text
Agent → Skill → Governance → Tool
```

比較正確的是：

```text
                 Governance
        ┌────────────┼────────────┐
        ↓            ↓            ↓
     Routing       Skill        Tool
        ↓            ↓            ↓
     Agent       Execution     Mutation
```

Governance 橫跨整個系統，限制：

- 哪個 Agent 可以被派工
- 哪個 Skill 可以使用
- 哪些 Tool Permission 可以授予
- 哪些 Repository 可以 Read / Write
- 哪些操作需要 Validation
- 哪些變更需要 Human Approval
- 哪些資訊不能跨越 Public / Private Boundary

所以它應被理解成：

> **Control Plane，而不是 Workflow 中的一個 Step。**

---

## Level 3｜Workflow：描述工作如何流動

Workflow 描述的是**時間順序與狀態流轉**，不是 Repository 層級。

```text
Intent
  ↓
Context Retrieval
  ↓
Routing
  ↓
Assignment
  ↓
Execution
  ↓
Validation
  ↓
Risk Review
  ↓
Human Approval（必要時）
  ↓
Handoff / Complete
```

同一條 Workflow 可能跨越多個 Repository：

```text
Knowledge
   ↓ Context Contract
Agent Control
   ↓ Assignment Brief
Execution
   ↓ Execution Evidence
Agent Control
   ↓ Sanitized Insight
Lab
```

因此：

**Repository 定義「責任在哪裡」，Workflow 定義「工作怎麼走」。**

---

## Level 4｜Artifact / Contract：層與層之間的交換介面

不同 Repository、Agent 或 Workflow Step 之間，不應透過「直接讀對方整個內部狀態」協作。

應透過明確 Artifact Contract 交換資訊：

```text
Knowledge
   │
   └─ Context Contract
          ↓
Agent Control
   │
   └─ Assignment Brief
          ↓
Execution
   │
   └─ Execution Evidence
          ↓
Agent Control
```

Artifact 是系統的介面層。

它的作用類似軟體架構中的 API Contract：

- 限制資訊量
- 明確 Producer / Consumer
- 限制 Permission
- 保留 Traceability
- 避免跨倉強耦合

---

## 五個概念怎麼對齊

| 概念 | 回答的問題 | 層級 |
|---|---|---|
| Public / Private Boundary | 什麼可以公開？ | Level 0 |
| Six-Repository Pattern | 責任放在哪裡？ | Level 1 |
| Agent / Skill / Tool | 任務由誰判斷與執行？ | Level 2 |
| Governance | 哪些操作被允許？ | Cross-cutting |
| Workflow | 工作依什麼順序流動？ | Level 3 |
| Artifact Contract | 不同角色怎麼交換資訊？ | Level 4 |

---

## 一個完整例子

假設目標是：

```text
改善一個 Dashboard 的 Empty State。
```

層級會這樣運作：

```text
Level 0
確認沒有私人／客戶資訊會被帶入公開輸出

Level 1
Knowledge 提供產品限制
Agent Control 負責派工
Execution 執行修改
Lab 可以接收匿名化方法心得

Level 2
Coordinator Agent 拆任務
Implementation Skill 執行修改
Test Skill 執行驗證
Tool 實際讀寫檔案與跑測試

Governance
限制只能寫 Feature Branch
Reviewer 維持 Read-only
Merge 需要 Human Approval

Level 3
Intent → Context → Route → Execute → Validate → Approval → Handoff

Level 4
Context Contract → Assignment Brief → Execution Evidence
```

這樣每一個概念都有自己的位置，不會互相混在一起。

---

## 最重要的判斷方式

如果不知道某個概念應放在哪一層，可以問：

```text
這是在決定「責任放哪裡」？
→ Repository Architecture

這是在決定「誰做判斷／怎麼執行」？
→ Agent / Skill / Tool

這是在決定「允不允許」？
→ Governance

這是在描述「先做什麼、後做什麼」？
→ Workflow

這是在定義「角色之間交換什麼」？
→ Artifact Contract
```

## 核心原則

> **Repository 是責任邊界，Agent 是判斷角色，Skill 是執行契約，Workflow 是狀態流，Artifact 是交換介面，Governance 則限制所有層級。**