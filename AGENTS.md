# AI Agent Architecture 開發規範

本 repository 是公開專案。所有開發、文件、範例與測試資料都必須假設會被永久公開、搜尋、Fork 與第三方索引。

## 工作原則

1. 不直接修改 `main`；使用 feature branch 與 PR。
2. 遵守 KISS，只處理當前需求，不順便重構。
3. 非簡單架構、治理、安裝器、Agent / Skill Contract 變更，先更新對應 OpenSpec。
4. 修改腳本後至少執行：
   - `bash -n scripts/*.sh`
   - `bash scripts/test-install.sh`
   - `bash scripts/privacy-check.sh`
   - `bash scripts/check.sh`
5. 不因為工具有能力就自動取得 Merge、Deploy、Secret、Billing 或 destructive action 權限。

## 公開內容規則

禁止提交：

- 個人記憶、私人對話、私人 prompt 或履歷細節
- 非必要的真實姓名、Email、電話、地址、Account ID 或私人 Username
- 私有 repository、issue、PR、內部 URL 或公司／客戶／機密專案資訊
- API Key、Token、Cookie、Password、Credential、Webhook Secret 或真實環境值
- 本機絕對路徑、Hostname、IP、SSH 設定或 machine-specific identifier
- Production configuration 或可回推出真實基礎設施的內容

專案本身已公開的 repository 名稱與公開 GitHub URL 可作為安裝與文件入口使用；不得藉此加入其他私人帳號或系統資訊。

## 文件語言

- 主要文件使用繁體中文（台灣用語）。
- 檔名、程式碼、介面欄位與業界固定術語可保留英文。
- 範例必須使用 synthetic data、placeholder 與不可識別真實對象的情境。

## 架構真相源

- Repository / Layer 模型：`docs/architecture/`
- Governance / Privacy：`docs/governance/`、`PRIVACY.md`
- Agent Contract：`agents/`
- Skill Contract：`skills/`
- Platform Adapter：`adapters/`
- 安裝行為：`scripts/install.sh`、`scripts/uninstall.sh`
- 變更契約：`openspec/`

Adapter 只做平台映射，不得複製並形成第二份 Agent / Skill 程序真相源。

## 完成條件

變更可以進入人工合併審查前，必須至少滿足：

- 相關測試通過
- Privacy Check 通過
- 文件、OpenSpec 與實作一致
- 沒有已知會覆蓋或刪除使用者資料的行為
- 沒有把私人 runtime、credential 或 machine context 帶進公開內容
