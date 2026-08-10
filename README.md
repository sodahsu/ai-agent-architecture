# AI Agent Architecture

一套以隱私安全為前提，用來設計多代理 AI 工作空間的參考架構與方法論。

這個 repository 關注的是**系統如何被設計與治理**，而不是公開任何人的真實 AI 記憶、帳號、裝置、私人 repository、憑證或實際運作脈絡。

> **核心原則：公開方法，不公開私人 AI 大腦。**

## 先理解架構層級

這個專案包含六倉、Agent、Skill、Governance、Workflow、Artifact 等概念，但它們**不是同一層級**。

```text
Level 0  系統邊界
         Private / Public

Level 1  Repository Architecture
         六倉＝系統級責任分區

Level 2  Operating Model
         Agent / Skill / Tool＝倉內如何判斷與執行

         Governance＝橫跨所有層級的控制面

Level 3  Workflow
         Intent → Context → Routing → Execution → Validation → Approval → Handoff

Level 4  Artifact / Contract
         不同角色與 Repository 之間交換資訊的介面
```

最重要的區分是：

```text
Repository  = 責任放在哪裡
Agent       = 誰負責判斷與協調
Skill       = 怎麼按照穩定程序執行
Tool        = 實際對外部系統產生操作
Workflow    = 工作按照什麼順序流動
Artifact    = 不同角色之間交換什麼
Governance  = 以上所有行為哪些被允許
```

完整說明見 [架構層級模型](docs/architecture/layer-model.md)。

## 從這裡開始

建議閱讀順序：

1. [架構層級模型](docs/architecture/layer-model.md) — 先理解六倉、Agent、Skill、Governance、Workflow、Artifact 彼此的上下層關係。
2. [架構視覺圖](docs/architecture/visual-map.md) — 看整體系統、公開／私有邊界與控制迴路。
3. [六倉架構模式](docs/architecture/six-repository-pattern.md) — 將知識、代理控制、評估、執行、實驗與作品集責任拆開。
4. [跨倉資料流](docs/architecture/data-flow.md) — 定義哪些 artifact 可以跨倉交換，以及哪些資訊必須保持私有。
5. [Agent / Skill / Governance 模型](docs/architecture/agent-skill-governance.md) — 分離判斷、可重複程序、工具權限與批准機制。
6. [Agent 工作方法](docs/methodology/agent-workflow.md) — 目標 → 路由 → 執行 → 驗證 → 批准 → 交接。
7. [匿名功能交付範例](examples/feature-delivery.md) — 使用完全虛構的情境走完一次完整流程。
8. [公開／私有邊界](docs/governance/public-private-boundary.md) — 如何把私人實作經驗萃取成可公開的方法。
9. [隱私規範](PRIVACY.md) — 明確列出不可提交到公開 repository 的內容。

## 這個 repository 要說明什麼

- 如何把私人記憶與公開架構分離
- 六倉的責任層級與彼此邊界
- Agent、Skill、Tool、Workflow 與 Governance 如何分工
- 如何在多個 AI Agent 之間派工，而不是把所有權限交給每一個 Agent
- 如何透過明確 Artifact Contract 交換上下文，而不是直接傾倒完整記憶
- 如何建立 Handoff、Review Gate 與 Human Approval 邊界
- 如何在新 Skill 或外部工具進入穩定工作流之前先做評估
- 如何分離同步互動、非同步執行、知識、實驗、發布與作品集層
- 如何把私人運作經驗轉成不含個資的公開模式與範例

## 參考架構

```mermaid
flowchart TB
    subgraph PRIVATE[私有運作層]
        K[Knowledge\n私人知識真相源]
        C[Agent Control\n規則、路由、穩定 Skills]
        X[Execution\n非同步任務與自動化]
    end

    subgraph CONTROL[受控晉升邊界]
        E[Evaluation\n評估外部能力]
        G{{Governance\n隱私 · 權限 · 驗證}}
    end

    subgraph PUBLIC[公開證據層]
        L[Lab\n實驗與文章]
        P[Portfolio\n精選成果]
    end

    K -->|最小必要上下文| C
    E -->|採用 / 改造| G
    G -->|核准能力| C
    C -->|有邊界的任務| X
    X -->|結果 + 證據| C
    C -->|去識別化洞察| L
    L -->|精選證據| P
```

六個 repository 代表的是**Level 1 的架構角色**，不是六個 Workflow Step，也不是六個 Agent。真正重要的是責任、資訊流與權限邊界。

## 倉內運作模型

當任務進入 Agent Control / Execution 之後，才進入 Level 2：

```text
Agent
  ↓ 選擇 / 協調
Skill
  ↓ 使用
Tool
  ↓
Files / APIs / Git / Browser / Test Runner
```

Governance 不在這條線的最後，而是從旁限制整條鏈：

```text
                 Governance
        ┌────────────┼────────────┐
        ↓            ↓            ↓
      Agent        Skill         Tool
```

因此，一個能力很強的 Agent，不代表它自動擁有所有操作權。

## Repository 結構

```text
docs/
├── architecture/
│   ├── layer-model.md
│   ├── visual-map.md
│   ├── six-repository-pattern.md
│   ├── system-overview.md
│   ├── data-flow.md
│   └── agent-skill-governance.md
├── methodology/
│   └── agent-workflow.md
└── governance/
    └── public-private-boundary.md

examples/
├── README.md
└── feature-delivery.md

templates/
└── workspace.example.yaml

PRIVACY.md
README.md
```

## 方法濃縮成一條流程

```text
Intent
  ↓
Context Contract
  ↓
Routing + Bounded Assignment
  ↓
Skill-based Execution
  ↓
Validation Evidence
  ↓
Risk / Human Approval Gate
  ↓
Reviewable Output
  ↓
Sanitized Learning
```

這條流程描述的是 **Level 3 Workflow**；其中的 `Context Contract`、`Assignment Brief`、`Execution Evidence` 等則屬於 **Level 4 Artifact Contract**。

## 隱私規則

禁止提交：

- 個人記憶或對話紀錄
- 真實 Email、電話、姓名或帳號識別資訊
- API Key、Token、Cookie、密碼或其他 Secret
- 私有 repository 名稱或內部 URL
- 雇主、客戶或機密專案資訊
- 本機絕對路徑、hostname、IP 或裝置識別資訊
- Production integration 的真實設定

公開範例必須使用虛構名稱、泛化路徑、placeholder identifier 與不可回推真實身份的情境。

新增內容前請先閱讀 [PRIVACY.md](PRIVACY.md)。

## 目前狀態

目前已定義第一版公開參考架構，包括：

- 架構層級模型
- 六倉責任模式
- 公開／私有邊界
- 跨倉資料流
- Agent / Skill / Tool / Governance 模型
- Workflow 與 Artifact Contract
- 第一個匿名端到端範例

可執行工具應等這些契約穩定後再加入，避免方法論還未定型就綁死實作。