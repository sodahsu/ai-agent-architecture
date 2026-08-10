# 安裝指南

這個專案可以安裝到其他人的 Repository，作為平台中立的 AI Agent / Skill / Governance 方法層。

> 目前安裝器仍在 Draft PR 分支開發中；PR 合併到 `main` 後，公開使用者即可直接從預設分支 Clone 並安裝。

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

同一個 `.ai-agent-architecture/` installation **一次只管理一個 Adapter**。若要從 Claude Code 切換到 Codex，或反向切換，必須先執行 uninstall，再安裝另一個 Adapter；安裝器不會在同一 namespace 隱性保留雙入口。

## 快速安裝

PR 合併後可直接：

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

`INSTALL-METADATA` 只記錄公開專案識別、schema version 與 adapter 類型；**不會寫入 installer 所在機器的絕對路徑**。

## 既有入口檔處理

### 入口不存在

安裝器會建立由本專案管理、帶有 marker 的入口：

- Claude Code：`CLAUDE.md`
- Codex：`AGENTS.md`

### 入口已存在或被修改

安裝器採 fail-safe 行為：

- 使用者原本就存在的入口 → 永不覆蓋
- 本專案先前建立、但之後被使用者修改的入口 → 永不覆蓋
- symlinked `CLAUDE.md` / `AGENTS.md` → 永不沿 symlink 寫入

上述情況都會產生整合片段：

```text
.ai-agent-architecture/CLAUDE.integration.md
```

或：

```text
.ai-agent-architecture/AGENTS.integration.md
```

使用者可自行把其中規則併入既有入口。

### 未修改的 managed entry

只有當現有 entry 與前一次安裝在 `.ai-agent-architecture/adapter/` 的版本完全相同時，重新安裝才會自動更新 entry。

這避免「只因為還保留 managed marker，就把使用者後續修改覆蓋掉」。

## 更新

重新執行**相同 Adapter** 的安裝指令即可更新 `.ai-agent-architecture/` 內的公開核心。

入口檔處理規則保持不變：

- 未修改的 managed entry → 可自動更新
- 已修改的 managed entry → 保留並產生 Integration Template
- 使用者原有 entry → 永不覆蓋

若現有 `INSTALL-METADATA` 顯示另一個 Adapter，installer 會拒絕切換。請先：

```bash
bash scripts/uninstall.sh --target /path/to/project
```

再安裝新的 Adapter。

## Symlink 安全邊界

下列 managed path 若是 symbolic link，安裝器會 fail closed：

- `.ai-agent-architecture`
- `.ai-agent-architecture/INSTALL-METADATA`

另外，若 `CLAUDE.md` / `AGENTS.md` 本身是 symlink，安裝器會保留它，不沿 symlink 寫入，並改產生 Integration Template。

理由：managed namespace 不應透過 symlink 把寫入範圍延伸到 target repository 外部。

## 解除安裝

```bash
bash scripts/uninstall.sh --target /path/to/project
```

解除安裝會：

1. 移除 `.ai-agent-architecture/` managed namespace。
2. 只有當 `CLAUDE.md` / `AGENTS.md` 同時具備 managed marker，且內容與目前安裝的 adapter entry **完全相同**時，才移除入口檔。
3. 任何已修改的 managed entry、使用者原有 entry 或 symlinked entry 都保留。

若 `.ai-agent-architecture` 是 symbolic link 或非目錄物件，解除安裝會 fail closed，不沿該路徑操作。

## 自測

Repository 維護者或使用者可以執行：

```bash
bash scripts/test-install.sh
```

測試會使用暫存資料夾驗證：

- Claude Code 新專案可正常安裝
- 未修改 managed entry 可安全更新
- 已修改 managed entry 不會被更新或解除安裝誤刪
- Codex 既有 `AGENTS.md` 不會被覆蓋
- Integration Template 能正確產生
- `.ai-agent-architecture` symlink 會被拒絕
- symlinked entry 不會被覆蓋
- symlinked metadata 不會被讀取或改寫
- Adapter 不可在未 uninstall 前直接切換
- Metadata 不含來源機器絕對路徑
- 缺少必要參數時會安全失敗

維護者的完整本機檢查入口：

```bash
bash scripts/check.sh
```

它會執行 shell syntax、安裝回歸測試、Privacy Check 與 Agent / Skill Contract 結構檢查。

## 安全原則

安裝器不蒐集、不上傳目標 Repository 的內容，也不會：

- 呼叫外部 API
- 讀取 Secret
- 修改 Git remote
- Commit / Push
- 安裝第三方套件
- 執行 Production Deployment

為判斷既有入口是否可安全自動更新，安裝器只會在目標 repository 內比較現有 `CLAUDE.md` / `AGENTS.md` 與前一次安裝的 adapter entry；不會把內容送出本機。
