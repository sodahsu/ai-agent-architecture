# 安裝指南

這個專案可安裝到其他 Repository，作為平台中立的 Agent / Skill / Governance 方法層。

> 目前安裝器仍在 Draft PR 分支開發中；合併到 `main` 後才是正式的預設分支安裝入口。

## 支援 Adapter

- Claude Code → `CLAUDE.md`
- Codex → `AGENTS.md`

同一個 `.ai-agent-architecture/` installation 一次只管理一個 Adapter。切換 Adapter 前必須先 uninstall，避免留下 orphan entry 或雙入口。

## 快速安裝

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

## 安裝內容

```text
.ai-agent-architecture/
├── agents/
├── skills/
├── docs/
│   ├── architecture/
│   └── governance/
├── adapter/
├── PRIVACY.md
├── LICENSE
└── INSTALL-METADATA
```

`LICENSE` 會跟著 Public Core 一起安裝，以保留 MIT License 的 copyright / permission notice。

不會複製 Personal Memory、Credential、Private Repository metadata、Account / Device identifier、Production configuration 或使用者本機私人設定。

## Managed Namespace

`.ai-agent-architecture/` 是由 installer 管理的 namespace。重新安裝會更新其中的 Public Core，uninstall 會移除整個 namespace。

**不要把自己的文件、Secret 或客製設定存進 `.ai-agent-architecture/`。** 專案自己的規則應留在既有 `CLAUDE.md` / `AGENTS.md` 或其他專案設定中。

## 入口檔保護

### 入口不存在

安裝器會建立帶有 managed marker 的 `CLAUDE.md` 或 `AGENTS.md`。

### 入口已存在、已修改或是 symlink

安裝器不覆蓋，改產生：

```text
.ai-agent-architecture/CLAUDE.integration.md
```

或：

```text
.ai-agent-architecture/AGENTS.integration.md
```

使用者自行決定是否整合。

### 未修改的 managed entry

只有當入口內容與上一次安裝的 Adapter entry 完全相同，重新安裝才會自動更新。

## 更新

重新執行相同 Adapter 的 install 指令即可。

若目前 metadata 顯示不同 Adapter，installer 會拒絕切換。先執行：

```bash
bash scripts/uninstall.sh --target /path/to/project
```

再安裝另一個 Adapter。

## Symlink 邊界

下列情況 fail closed：

- `.ai-agent-architecture` 是 symlink
- `.ai-agent-architecture/INSTALL-METADATA` 是 symlink

若 `CLAUDE.md` / `AGENTS.md` 本身是 symlink，安裝器保留它與其 target，不沿 symlink 寫入，改產生 Integration Template。

## 解除安裝

```bash
bash scripts/uninstall.sh --target /path/to/project
```

解除安裝會：

1. 移除 `.ai-agent-architecture/` managed namespace。
2. 只有當 managed `CLAUDE.md` / `AGENTS.md` 仍與安裝版本完全相同時才移除入口。
3. 已修改、使用者原有或 symlinked entry 一律保留。

## Metadata

`INSTALL-METADATA` 只包含：

```text
project=ai-agent-architecture
schema_version=1
adapter=<claude-code|codex>
```

不寫入 installer 所在機器的絕對路徑、Hostname、Account Identifier 或 Secret。

## 自測

Installer / Uninstaller regression：

```bash
bash scripts/test-install.sh
```

維護者完整檢查：

```bash
bash scripts/check.sh
```

目前檔案 Privacy Check：

```bash
bash scripts/privacy-check.sh
```

Git 歷史 Privacy Check（需在 Git worktree）：

```bash
bash scripts/privacy-history-check.sh
```

回歸測試涵蓋：

- fresh install
- Public Agent / Skill package copy
- MIT License notice copy
- safe managed-entry update
- modified entry preservation
- existing entry preservation
- namespace / metadata symlink rejection
- entry symlink preservation
- adapter-switch rejection
- privacy-safe metadata
- uninstall safety

## 安全原則

Installer 不會：

- 呼叫外部 API
- 讀取 Secret
- 修改 Git remote
- Commit / Push
- 安裝第三方套件
- 執行 Production Deployment

Installer 的安全邊界主要保護「目標 Repository 外部路徑」與「使用者入口檔」。`.ai-agent-architecture/` 本身是可替換的 managed namespace，不提供任意使用者資料保存保證。
