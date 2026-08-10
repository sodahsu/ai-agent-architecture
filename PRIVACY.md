# 公開內容隱私規範

這是一個公開 repository。任何提交進來的檔案，都必須假設會被永久公開、被搜尋、被 fork，也可能被第三方索引或保存。

## 可以公開

- 泛化後的架構模式
- 可重複使用的方法論
- 去識別化的工作流程圖
- 通用範例與模板
- 完全虛構的 sample data
- 已公開的官方文件連結

## 禁止公開

不得提交下列內容：

- 個人記憶、私人筆記、日誌、對話歷史或私人 prompt
- 真實姓名、個人 Email、電話、地址、Account ID 或 Username
- 雇主、客戶、內部專案或其他機密商業資訊
- 私有 repository 名稱、private issue / PR 連結、內部 domain 或非公開 URL
- API Key、OAuth Token、PAT、Cookie、Credential、Secret、Webhook Secret 或真實環境變數值
- 本機絕對路徑、裝置名稱、Hostname、IP、SSH 設定或其他 machine-specific identifier
- 會暴露基礎設施細節的 production deployment 設定
- 可能包含上述資訊的原始 log、截圖或匯出資料

## 範例撰寫規則

優先使用 placeholder：

```text
<workspace>
<private-memory-store>
<runtime-agent>
<example-repository>
user@example.com
```

不得在 commit 前把這些 placeholder 替換成真實本機值或實際帳號資訊。

## 提交前檢查

每次準備公開變更前，至少確認：

1. 內容能否識別真實人物、雇主、客戶、帳號、裝置或私人專案？
2. 內容是否洩漏私人資料實際儲存位置，或提供可存取它的操作線索？
3. 是否包含真實 credential、secret value 或 production endpoint？
4. 是否可以改用完全虛構的名稱與 placeholder，而不影響要傳達的方法？

只要其中任何一項造成不必要暴露，就應在 merge 前泛化、去識別化或移除。

## 設計原則

**公開可重用的知識；把真實身份、私人上下文與 production 運作資訊留在公開 repository 之外。**