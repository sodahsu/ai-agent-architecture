# 公開內容隱私規範

這是一個公開 repository。任何提交進來的檔案與已 push 的 commit，都必須假設會被永久公開、搜尋、Fork，也可能被第三方索引或保存。

## 可以公開

- 泛化後的架構模式
- 可重複使用的方法論
- 去識別化工作流程
- 通用範例與模板
- 完全虛構的 sample data
- 已公開的官方文件連結
- 本專案本身刻意公開的 repository 名稱、Clone URL 與必要專案識別資訊

## 禁止公開

- 個人記憶、私人筆記、日誌、對話歷史或私人 prompt
- 非必要的真實姓名、個人 Email、電話、地址、Account ID 或私人 Username
- 雇主、客戶、內部專案或其他機密商業資訊
- 私有 repository 名稱、private issue / PR、內部 domain 或非公開 URL
- API Key、OAuth Token、PAT、Cookie、Credential、Secret、Webhook Secret 或真實環境值
- 本機絕對路徑、裝置名稱、Hostname、IP、SSH 設定或 machine-specific identifier
- 會暴露真實基礎設施的 production deployment 設定
- 可能包含上述資訊的原始 log、截圖、config dump 或匯出資料

## 範例規則

優先使用 placeholder：

```text
<workspace>
<private-memory-store>
<runtime-agent>
<example-repository>
user@example.com
```

範例應保留方法所需的結構，但不能讓第三方合理回推出真實身份或私人環境。

## 安裝器資料規則

`INSTALL-METADATA` 只可保存公開專案識別、schema version 與 adapter 類型，不得包含來源機器絕對路徑、使用者名稱、Hostname、IP、Device Identifier、Credential 或環境變數值。

安裝產物會包含本專案的 `LICENSE`；使用者不應把自己的私人設定放進 `.ai-agent-architecture/` managed namespace。

## 目前檔案檢查

```bash
bash scripts/privacy-check.sh
```

它會掃描目前 working tree 中常見文字格式，攔截部分 Email、具體 home path、credential-like token、private key 等高風險模式。

## Git 歷史檢查

刪掉目前檔案中的敏感資料，**不代表 Git 歷史已經安全**。在真實 Git clone 中執行：

```bash
bash scripts/privacy-history-check.sh
```

它會掃描可達 Git refs 的 patch history，尋找相同類型的常見洩漏模式。若不是 Git worktree，腳本會明確顯示 skipped，而不是假裝已檢查歷史。

若歷史檢查發現真實 Credential：先 revoke / rotate，再處理歷史清理；不要只刪目前檔案後就視為安全。

## 提交前人工檢查

每次準備公開變更前，至少確認：

1. 能否識別真實人物、雇主、客戶、私人帳號、裝置或私人專案？
2. 是否洩漏私人資料實際儲存位置或存取線索？
3. 是否包含真實 credential、secret value 或 production endpoint？
4. 是否可以改用 synthetic data / placeholder？
5. Installer、Example、Test output 是否把本機 context 帶進 repository？
6. 這些內容是否曾出現在已 push 的舊 commit？

自動化檢查只能攔截常見模式，**不能證明 repository 沒有任何敏感資訊，也不能取代人工 Privacy Review 或專業 secret scanner。**

## 設計原則

**公開可重用的知識；把真實身份、私人上下文與 production 運作資訊留在公開 repository 之外。**
