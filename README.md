# AI Agent Architecture

一套以隱私安全為前提，用來設計多代理 AI 工作空間的參考架構、方法論，以及可公開重用的 Agent / Skill 契約。

這個 repository 關注的是**系統如何被設計、分層、治理與安全安裝**，而不是公開任何人的真實 AI 記憶、私人帳號、裝置、Private Repository、Credential 或 Production Context。

> **核心原則：公開方法，不公開私人 AI 大腦。**

目前 Public Core 包含 **7 個 Agent Contract + 18 個 Skill Contract**，支援 Claude Code 與 Codex Adapter。

## 快速安裝

安裝器仍在 Draft PR 分支中；合併到 `main` 後即可從公開預設分支安裝。

```bash
git clone https://github.com/sodahsu/ai-agent-architecture.git
cd ai-agent-architecture
```

Claude Code：

```bash
bash scripts/install.sh --adapter claude-code --target /path/to/project
```

Codex：

```bash
bash scripts/install.sh --adapter codex --target /path/to/project
```

安裝器會把公開核心放進目標專案的 `.ai-agent-architecture/`。若 `CLAUDE.md` / `AGENTS.md` 已存在、已被使用者修改，或本身是 symlink，都不會被覆蓋；改以 Integration Template 交給使用者人工整合。

完整規則見 [INSTALL.md](INSTALL.md)。

## 本機驗證

維護者完整檢查：

```bash
bash scripts/check.sh
```

它會執行：

- Shell syntax check
- Installer / Uninstaller regression tests
- Privacy leak pattern check
- 7 個 Agent / 18 個 Skill Contract 結構與數量檢查
- OpenSpec / 必要文件存在性檢查

單獨測試：

```bash
bash scripts/test-install.sh
bash scripts/privacy-check.sh
```

## 先理解架構層級

六倉、Agent、Skill、Governance、Workflow、Artifact **不是同一層級**。

```text
Level 0  System Boundary
         Public / Private

Level 1  Repository Architecture
         六倉＝系統級責任分區

Level 2  Operating Model
         Agent / Skill / Tool＝倉內如何判斷與執行

Level 3  Workflow
         Intent → Context → Routing → Execution → Validation → Approval → Handoff

Level 4  Artifact / Contract
         不同角色與 Repository 交換資訊的介面

Governance
         橫跨 Level 0～4 的控制面
```

最重要的區分：

```text
Repository  = 責任放在哪裡
Agent       = 誰負責判斷與協調
Skill       = 如何依穩定程序執行
Tool        = 實際操作能力
Workflow    = 工作如何流動
Artifact    = 角色之間交換什麼
Governance  = 以上行為哪些被允許
```

完整說明見 [架構層級模型](docs/architecture/layer-model.md)。

## 六倉責任模式

```text
1. Knowledge Repository      私人知識與 canonical context
2. Agent Control Repository  穩定規則、Agent、Skill、Routing、Governance
3. Evaluation Repository     外部 Skill / Tool / MCP 的隔離評估
4. Execution Repository      非同步任務與 Automation Runtime
5. Lab Repository            公開實驗、技術筆記與學習
6. Portfolio Repository      精選成果與 Case Study
```

六個 Repository 代表的是 **Level 1 架構角色**，不是六個固定產品名稱、六個 Workflow Step，也不是六個 Agent。較小系統可以合併角色，只要責任、Privacy Boundary 與 Lifecycle 邊界仍然清楚。

詳細說明見 [六倉架構模式](docs/architecture/six-repository-pattern.md)。

## 倉內運作模型

任務進入 Agent Control / Execution 後，才進入 Level 2：

```text
Agent
  ↓ 選擇 / 協調
Skill
  ↓ 使用
Tool
  ↓
Files / APIs / Git / Browser / Test Runner
```

Governance 不是最後一步，而是從旁限制整條鏈：

```text
                 Governance
        ┌────────────┼────────────┐
        ↓            ↓            ↓
      Agent        Skill         Tool
```

**Capability 不等於 Permission。** Agent 能做某件事，不代表它已被授權執行。

## 可公開使用的 Agents

[`agents/`](agents/README.md) 提供 **7 個平台中立 Agent Contract**，分成兩個維度。

### Lifecycle Agents

```text
Coordinator  → Goal、Scope、Routing、Assignment、Approval Gate
Implementer  → 在受限 Scope 內實作並產出 Validation Evidence
Reviewer     → Read-only 獨立驗證 Acceptance Criteria 與 Evidence
Evaluator    → 評估 Skill / Tool / MCP 的 adopt / adapt / reject / defer
```

### Domain Agents

```text
Design Coordinator   → Design Brief / Review / Spec / System 路由
Product Coordinator  → Product Goal / Roadmap / Decision / Requirement 路由
People Coordinator   → People 工作的最小 Context、Privacy 與 Human Decision Gate
```

Domain Agent 負責專業領域判斷，不因此自動取得 Implementer 寫入權。

## 可公開使用的 Skills

[`skills/`](skills/README.md) 目前提供 **18 個 Public Skills**：

```text
Core / Governance
├─ clarify
├─ task-contract
├─ bounded-implementation
├─ evidence-review
├─ adversarial-review
├─ privacy-sanitizer
├─ handoff
└─ capability-evaluation

Product / Knowledge
├─ roadmap-planning
└─ meeting-to-decisions

Design
├─ design-brief
├─ design-review
├─ design-spec
└─ design-system

Engineering / Operations
├─ code-review
├─ root-cause
├─ task-checkpoint
└─ skill-audit
```

每個 Skill 都定義：

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

Skill Contract 是程序真相源，不綁定特定模型供應商。

哪些能力適合 Public Core、哪些必須先 Adapt、哪些應保持 Private，見 [Public Capability Catalog](docs/governance/public-capability-catalog.md)。

## Adapter Layer

核心方法只維護一份：

```text
agents/ + skills/ + governance
              │
       ┌──────┴──────┐
       ↓             ↓
Claude Code        Codex
CLAUDE.md          AGENTS.md
```

Adapter 只處理平台入口與載入方式，不重寫完整 Agent / Skill Procedure，避免規則 drift。

目前：

- [`adapters/claude-code/`](adapters/claude-code/README.md)
- [`adapters/codex/`](adapters/codex/README.md)

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

這是 **Level 3 Workflow**；其中 `Context Contract`、`Assignment Brief`、`Execution Evidence` 等屬於 **Level 4 Artifact Contract**。

詳細資料流見 [跨倉資料流](docs/architecture/data-flow.md)。

## 公開／私有邊界

禁止把下列內容帶進這個公開 repository：

- 個人記憶、私人對話或私人 prompt
- 非必要的真實 Email、電話、地址或私人 Account Identifier
- Private Repository / Issue / PR / Internal URL
- Employer / Client / Confidential Project Context
- API Key、Token、Cookie、Password、Credential、Webhook Secret
- 本機絕對路徑、Hostname、IP、SSH 或 Device Identifier
- Production Configuration

本專案本身刻意公開的 repository 名稱與 Clone URL 可用於安裝文件；不應藉此加入其他私人識別資訊。

詳細規則見 [PRIVACY.md](PRIVACY.md)、[Public / Private Boundary](docs/governance/public-private-boundary.md) 與 [Public Capability Catalog](docs/governance/public-capability-catalog.md)。

## Repository 結構

```text
AGENTS.md
CONTRIBUTING.md
LICENSE
README.md
INSTALL.md
PRIVACY.md

agents/
skills/
adapters/

docs/
├── architecture/
├── methodology/
└── governance/

examples/
templates/

scripts/
├── install.sh
├── uninstall.sh
├── test-install.sh
├── privacy-check.sh
└── check.sh

openspec/
├── project.md
└── changes/
    └── public-architecture-foundation/
```

## 開發規範

維護本專案時先讀 [AGENTS.md](AGENTS.md) 與 [CONTRIBUTING.md](CONTRIBUTING.md)。非簡單架構、Governance、Installer 或 Agent / Skill Contract 變更，應同步更新 [`openspec/`](openspec/project.md)。

基本原則：

- 不直接修改 `main`
- KISS，不做無關重構
- Public-safe synthetic examples only
- 相關測試與 Privacy Check 通過後才進人工 merge review
- 不自動 Merge / Deploy / Secret / Billing / destructive action
- 第三方能力先做 License / Attribution Review，不直接 Copy

## 建議閱讀順序

1. [架構層級模型](docs/architecture/layer-model.md)
2. [架構視覺圖](docs/architecture/visual-map.md)
3. [六倉架構模式](docs/architecture/six-repository-pattern.md)
4. [跨倉資料流](docs/architecture/data-flow.md)
5. [Agent / Skill / Governance 模型](docs/architecture/agent-skill-governance.md)
6. [公開 Agent 套件](agents/README.md)
7. [公開 Skill 套件](skills/README.md)
8. [Public Capability Catalog](docs/governance/public-capability-catalog.md)
9. [Adapter Layer](adapters/README.md)
10. [安裝指南](INSTALL.md)
11. [Agent 工作方法](docs/methodology/agent-workflow.md)
12. [匿名功能交付範例](examples/feature-delivery.md)
13. [公開／私有邊界](docs/governance/public-private-boundary.md)
14. [隱私規範](PRIVACY.md)

## 目前狀態

第一版已包含：

- 架構層級模型與六倉責任模式
- Public / Private Boundary 與 Public Capability Catalog
- Cross-Repository Data Flow
- Agent / Skill / Tool / Governance 模型
- 4 個 Lifecycle Agent + 3 個 Domain Agent
- 18 個 Public Skill Contract
- Claude Code / Codex Adapter
- 安裝、更新、解除安裝與回歸測試
- Privacy Check 與統一 Validation Entry
- OpenSpec project / change baseline
- Synthetic end-to-end example

目前不包含真實 Production Runtime、私人系統設定、Credential、Personal Memory 或 Private People Data。

## License

本專案採用 [MIT License](LICENSE)。其他人可以依授權條款使用、修改與散布；第三方貢獻仍需自行確認其來源 License / Attribution Requirement。
