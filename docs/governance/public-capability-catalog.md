# Public Capability Catalog

這份文件定義「哪些 Agent / Skill 可以進入公開核心，以及哪些能力必須留在 Private Runtime」。目的不是公開所有能力，而是建立可重用方法與私人運作之間的穩定邊界。

## 判定原則

一個能力可以進 Public Core，必須同時滿足：

1. **可脫離個人身份使用**：不需要真實姓名、Email、個人履歷或私人偏好才能成立。
2. **可脫離私人資料使用**：不需要 Personal Memory、私人筆記、私人 Conversation History。
3. **可脫離特定 Repository 使用**：不依賴非公開 Repo、內部 URL 或固定工作目錄。
4. **可脫離 Credential 使用**：核心方法不要求 Token、Secret、Production Account 才能理解或執行。
5. **可泛化 Permission Boundary**：權限可以用 Read / Write Scope / Approval Gate 表達，而不是寫死某台機器或帳號。
6. **有獨立的公共價值**：其他人可以在自己的專案採用，不只是原作者 Runtime 的內部 Glue。

## Public Core — Agents

### Lifecycle Agents

- Coordinator
- Implementer
- Reviewer
- Evaluator

### Domain Agents

- Design Coordinator
- Product Coordinator
- People Coordinator

Domain Agent 只包含問題分類、專業判斷與 Skill Routing；真實 Project Memory、Employee Data、帳號與私有 Tool Binding 不進公開版本。

## Public Core — Skills

### Core / Governance

- clarify
- task-contract
- bounded-implementation
- evidence-review
- adversarial-review
- privacy-sanitizer
- handoff
- capability-evaluation

### Product / Knowledge

- roadmap-planning
- meeting-to-decisions

### Design

- design-brief
- design-review
- design-spec
- design-system

### Engineering / Operations

- code-review
- root-cause
- task-checkpoint
- skill-audit

## 可以公開，但需要先 Adapt

下列能力的「方法」通常可以公開，但若私人版本含特定 Runtime、Provider、Repository 或 Integration，必須先改寫成平台中立 Contract：

- Multi-agent task dispatch / collaboration
- Pipeline composition
- OpenSpec lifecycle helpers
- Security audit workflow
- Research workflow
- General-purpose article writing workflow
- Generic prompt optimization
- Generic presentation workflow

公開前必須重新做 Privacy、License、Dependency 與 Permission Review；不得直接 Copy 私人 Runtime 版本。

## 保持 Private

下列類別原則上不進 Public Core：

### Personal Memory / Knowledge Bridge

- Personal Assistant state
- Recall / Personal Memory retrieval
- Personal note / vault write bridge
- Pitfall / personal-memory promotion
- Private memory sync / health / routing

原因：方法可以另寫成泛化架構，但實際能力與個人 Knowledge Store、Memory Location 或 Personal Context 強耦合。

### Private Publishing / Brand Runtime

- 個人網站專用發布流程
- 私人內容來源到公開網站的同步與回寫
- 個人品牌特定 Style / Visual Generator

原因：會暴露實際 Repository、內容來源、品牌規則或發布路徑。

### Infrastructure / Provider Runtime

- 真實 Provider Cost Ladder / Account Routing
- Credential-based Agent Gateway
- Production Deployment / Cloud Worker Runtime
- 真實 Usage / Billing / Quota Aggregation
- Machine-specific sync / local environment bootstrap

原因：這些屬於實際運作基礎設施，而不是公開方法論本身。

### Private People Data

People Coordinator 可以公開，但以下內容不得跟著公開：

- 真實員工／候選人記錄
- 1-on-1 歷史快照
- Performance / Compensation Context
- 永久人格 Profile
- 敏感屬性推論

## Promotion Flow

```text
Private Runtime Capability
        ↓
Extract reusable method
        ↓
Remove personal / repo / credential coupling
        ↓
License + Dependency Review
        ↓
Privacy Sanitizer
        ↓
Synthetic Example
        ↓
Public Agent / Skill Contract
        ↓
Independent Review
        ↓
Public Core
```

「私人版本功能更多」不是問題。Public Core 的目標是**更清楚、更安全、更容易被別人採用**，不是與私人 Runtime 一比一鏡像。
