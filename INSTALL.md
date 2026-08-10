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
└── adapter/
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

不會複製：

- Personal Memory
- Credential / Secret
- Private Repository metadata
- Account / Email / Device identifier
- Production configuration
- 使用者本機私人設定

## 既有入口檔處理

### 若入口不存在

安裝器會建立：

- Claude Code：`CLAUDE.md`
- Codex：`AGENTS.md`

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

入口檔若已存在則仍不覆蓋。

## 解除安裝

```bash
bash scripts/uninstall.sh --target /path/to/project
```

解除安裝只會移除 `.ai-agent-architecture/`。

為避免誤刪使用者原本的設定，`CLAUDE.md` / `AGENTS.md` 不會自動刪除。

## 安全原則

安裝器不讀取、不蒐集、不上傳目標 Repository 的內容。

它只執行本機檔案複製與目錄建立，不會：

- 呼叫外部 API
- 讀取 Secret
- 修改 Git remote
- Commit / Push
- 安裝第三方套件
- 執行 Production Deployment
