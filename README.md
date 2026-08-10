# AI Agent Architecture

一套以隱私安全為前提，用來設計多代理 AI 工作空間的**參考架構、治理方法，以及可重用 Agent / Skill Contract**。

> **公開方法，不公開私人 AI 大腦。**

這個 repository 不公開 Personal Memory、私人帳號、Private Repository、Credential、Production Context 或真實 People Data；它只保留可以被其他人理解、安裝與改造的方法。

## 這個專案解決什麼

當 AI 工作流從「一個 Prompt」長成多 Agent、多 Skill、多工具與多 Repository 時，真正困難的通常不是模型能力，而是：

- 誰負責判斷？
- 誰可以寫入？
- 哪些程序應該變成 Skill？
- Context 如何交換而不把私人資料到處複製？
- Reviewer 如何取得足夠獨立性？
- 哪些操作必須回到 Human Approval？
- 私人 Runtime 的方法，如何安全萃取成公開資產？

這個專案把這些問題整理成可檢查的架構與 Contract。

## 架構層級

```text
Level 0  System Boundary
         Public / Private

Level 1  Repository Architecture
         責任放在哪裡

Level 2  Operating Model
         Agent / Skill / Tool 如何協作

Level 3  Workflow
         Intent → Routing → Execution → Validation → Approval → Handoff

Level 4  Artifact / Contract
         角色與 Repository 如何交換資訊

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
Governance  = 哪些行為被允許
```

完整說明：[架構層級模型](docs/architecture/layer-model.md)

## Six-Repository Pattern

這裡的「六倉」是責任模式，不是六個固定產品名稱：

```text
1. Knowledge Repository      canonical context / knowledge
2. Agent Control Repository  Agent / Skill / Routing / Governance
3. Evaluation Repository     外部能力隔離評估
4. Execution Repository      async / automation runtime
5. Lab Repository            公開實驗與學習
6. Portfolio Repository      精選成果與 case study
```

小型系統可以合併角色，只要責任、Privacy Boundary 與 Lifecycle 邊界仍然清楚。

完整說明：[六倉架構模式](docs/architecture/six-repository-pattern.md)

## Agent 與 Skill

Public Core 目前的 snapshot 是 **7 個 Agent Contract、18 個 Skill Contract**。這個數字是目前版本的摘要，**不是寫死在 validation script 裡的第二份 registry**。

Agent 分成兩個維度：

- **Lifecycle Agents**：Coordinator / Implementer / Reviewer / Evaluator 等工作責任。
- **Domain Agents**：Design / Product / People 等領域理解與 Skill Routing。

完整 Agent 索引：[agents/README.md](agents/README.md)

Skill 是穩定程序的真相源，每個 Public Skill 都必須定義：

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

完整 Skill 索引：[skills/README.md](skills/README.md)

哪些能力能 Public、哪些要先 Adapt、哪些必須 Keep Private：[Public Capability Catalog](docs/governance/public-capability-catalog.md)

## Reviewer 的「獨立」有條件

`Reviewer` 預設 Read-only，但 Read-only 不等於 independent。

- 不同 reviewer / context，且未先暴露原實作推理 → `independent review`
- 同一 session 只是切換 Reviewer 視角 → `structured self-review`

專案文件不把後者包裝成真正的獨立驗證。

## Adapter

核心 Contract 只維護一份：

```text
agents/ + skills/ + governance
              │
       ┌──────┴──────┐
       ↓             ↓
Claude Code        Codex
CLAUDE.md          AGENTS.md
```

Adapter 只負責平台入口與載入，不維護第二份 capability inventory。

- [Claude Code Adapter](adapters/claude-code/README.md)
- [Codex Adapter](adapters/codex/README.md)

## 快速安裝

> Installer 目前仍在 Draft PR；合併到 `main` 後才是正式預設分支入口。

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

Public Core 會安裝到 `.ai-agent-architecture/`；既有或已修改的 `CLAUDE.md` / `AGENTS.md` 不會被覆蓋。MIT `LICENSE` 會隨安裝內容一起保留。

完整規則：[INSTALL.md](INSTALL.md)

## Privacy Boundary

Public Core 不包含：

- Personal Memory / Conversation History
- Private Repository / Internal URL
- Employer / Client confidential context
- 真實 Employee / Candidate Data
- Credential / Token / Cookie / Password
- Machine-specific absolute path / Hostname / Device identifier
- Production configuration

People Coordinator 只做隱私安全的任務整理與 Human Decision Gate；不以 AI 分數、排名或風險標籤自動選擇員工／候選人。

完整規則：[PRIVACY.md](PRIVACY.md)

## 驗證

完整維護者檢查：

```bash
bash scripts/check.sh
```

它會執行：

- Shell syntax
- Installer / Uninstaller regression
- Current-tree privacy pattern scan
- Git-history privacy pattern scan（有 Git metadata 時）
- 所有 Agent / Skill Contract 結構檢查
- Adapter canonical-index linkage
- OpenSpec / 必要文件存在性檢查

單獨執行：

```bash
bash scripts/test-install.sh
bash scripts/privacy-check.sh
bash scripts/privacy-history-check.sh
```

自動檢查是 guardrail，不是「保證沒有任何敏感資料」的證明；正式公開仍需要人工 Privacy Review。

## Repository 結構

```text
AGENTS.md
CONTRIBUTING.md
LICENSE
README.md
INSTALL.md
PRIVACY.md

agents/          # Agent contracts + canonical index
skills/          # Skill contracts + canonical index
adapters/        # thin platform adapters

docs/
├── architecture/
├── methodology/
└── governance/

examples/        # synthetic examples
templates/       # public-safe templates
scripts/         # installer + validation
openspec/        # change contracts
```

## 建議閱讀順序

1. [架構層級模型](docs/architecture/layer-model.md)
2. [架構視覺圖](docs/architecture/visual-map.md)
3. [六倉架構模式](docs/architecture/six-repository-pattern.md)
4. [Agent / Skill / Governance](docs/architecture/agent-skill-governance.md)
5. [公開 Agent 索引](agents/README.md)
6. [公開 Skill 索引](skills/README.md)
7. [Public Capability Catalog](docs/governance/public-capability-catalog.md)
8. [跨倉資料流](docs/architecture/data-flow.md)
9. [安裝指南](INSTALL.md)
10. [匿名功能交付範例](examples/feature-delivery.md)
11. [Privacy](PRIVACY.md)

## 開發規範

先讀 [AGENTS.md](AGENTS.md) 與 [CONTRIBUTING.md](CONTRIBUTING.md)。架構、Governance、Installer 或 Agent / Skill Contract 的非簡單變更應同步更新 [`openspec/`](openspec/project.md)。

基本原則：Feature Branch、KISS、Public-safe synthetic examples、Evidence-based validation、Human Approval for high-risk actions。

## License

本專案採用 [MIT License](LICENSE)。安裝器也會把 License notice 一起帶入 managed package。第三方內容仍需另外確認來源 License 與 Attribution Requirement。
