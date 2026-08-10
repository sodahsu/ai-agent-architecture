# 安裝指南

這個專案可以安裝到其他人的 Repository，作為平台中立的 AI Agent / Skill / Governance 方法層。

## 支援模式

目前支援：

- Claude Code
- Codex

安裝後會把公開核心放進目標 Repository 的：

```text
.ai-agent-architecture/
├── agents/
├── skills/
├── docs/
├── adapter/
├── PRIVACY.md
└── INSTALL-METADATA
```

並依 Adapter 建立入口：

```text
Claude Code → CLAUDE.md
Codex       → AGENTS.md
```

如果目標 Repository 已經存在 `CLAUDE.md` 或 `AGENTS.md`，安裝器**不會覆蓋**，而是建立一份整合片段，讓使用者手動合併。

## 快速安裝

先 Clone：

```bash
git clone https://github.com/sodahsu/ai-agent-architecture.git
cd ai-agent-architecture
```

安裝 Claude Code Adapter：

```bash
bash scripts/install.sh --adapter claude-code --target /path/to/project
```

安裝 Codex Adapter：

```bash
bash scripts/install.sh --adapter codex --target /path/to/project
```

也可以在目標專案內執行：

```bash
bash /path/to/ai-agent-architecture/scripts/install.sh --adapter codex --target .
```

## 安裝內容

安裝器只複製公開、安全的核心內容：

- `agents/`
- `skills/`
- `docs/architecture/`
- `docs/governance/`
- 對應 Adapter 文件
- `PRIVACY.md`

不會複製：

- Personal Memory
- Credential / Secret
- Private Repository metadata
- Account / Email / Device identifier
- Production configuration
- 使用者本機私人設定

## 既有入口檔處理

### 若入口不存在

安裝器會建立由本專案管理、帶有 marker 的入口：

- Claude Code：`CLAUDE.md`
- Codex：`AGENTS.md`

之後重新安裝時，只會自動更新帶有本專案 marker 的入口。

### 若入口已存在

不覆蓋原檔。

會產生：

```text
.ai-agent-architecture/CLAUDE.integration.md
```

或：

```text
.ai-agent-architecture/AGENTS.integration.md
```

使用者可自行把其中規則併入既有入口。

## 更新

重新執行安裝指令即可更新 `.ai-agent-architecture/` 內的公開核心。

入口檔處理規則保持不變：

- 本專案管理的入口 → 可安全更新
- 使用者原有入口 → 永不覆蓋

## 解除安裝

```bash
bash scripts/uninstall.sh --target /path/to/project
```

解除安裝會：

1. 移除 `.ai-agent-architecture/`
2. 若 `CLAUDE.md` / `AGENTS.md` 明確帶有本專案 managed marker，才會移除
3. 使用者原本存在的入口檔永遠保留

## 自測

Repository 維護者或使用者可以執行：

```bash
bash scripts/test-install.sh
```

測試會使用暫存資料夾驗證：

- Claude Code 新專案可正常安裝與解除安裝
- Codex 既有 `AGENTS.md` 不會被覆蓋
- Integration Template 能正確產生
- 解除安裝不會誤刪使用者既有入口

## 安全原則

安裝器不讀取、不蒐集、不上傳目標 Repository 的內容。

它只執行本機檔案複製與目錄建立，不會：

- 呼叫外部 API
- 讀取 Secret
- 修改 Git remote
- Commit / Push
- 安裝第三方套件
- 執行 Production Deployment
