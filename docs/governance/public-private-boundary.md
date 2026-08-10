# 公開／私有邊界（Public / Private Boundary）

## 目標

讓公開 repository 足夠有用，同時避免任何人能從公開內容反推出真實私人 runtime context。

## 分類模型

| 類別 | 範例 | 可公開？ |
|---|---|---|
| Method | 架構模式、決策規則、Review Gate | 可以 |
| Template | 虛構設定、通用 Contract、Placeholder | 可以 |
| Public Evidence | 公開文件、公開 Repository、已發布案例 | 可以 |
| Personal Context | 記憶、偏好、對話、私人筆記 | 不可以 |
| Operational Identity | Username、本機路徑、Account ID、Private Repo 名稱 | 不可以 |
| Secrets | Token、Cookie、Key、Password、Webhook Secret | 永遠不可以 |
| Confidential Work | 雇主／客戶／內部專案資訊 | 不可以 |

## 公開晉升規則

內容若要從私人 workspace 移動到這個公開 repository，只能透過**人工萃取（manual distillation）**：

```text
Private Source
    ↓
萃取可重用 Lesson
    ↓
移除身份與 Operational Details
    ↓
把真實值替換成 Synthetic Example
    ↓
進行 Privacy + Confidentiality Review
    ↓
發布 Method
```

禁止跨越邊界做 Raw Synchronization。

## Agent 規則

AI Agent 在準備公開內容時，只應取得推導可重用方法真正需要的最小私人上下文。

最終 Public Artifact 必須能獨立理解，不應依賴任何私人 Identifier 才看得懂。

## 高風險訊號

內容出現下列訊號時，應停止並人工檢查：

- `@` Email 或類似 Account Identifier
- `/Users/`、`/home/`、磁碟機代號或 Network Share 等檔案系統根路徑
- token / key / secret / password / cookie 等詞旁邊出現具體值
- Internal Hostname、IP、Webhook Endpoint 或 Private URL
- 雇主、客戶、私人專案或 Private Repository 名稱
- 貼上的 Log、Screenshot、Stack Trace 或 Config Dump

這些訊號不一定代表真的洩漏，但代表在 merge 前必須人工確認。

## Merge Gate

Public Change 只有在以下條件都成立時才適合 Merge：

- 匿名化後方法仍然完整可理解
- 範例全部使用 Synthetic Data
- 不存在 Credential 或 Operational Identifier
- 理解文件不需要任何 Private Dependency
- 連結只指向刻意公開的資源
- 無法從多份公開文件交叉拼回真實私人運作拓樸

## 原則

**可以公開「怎麼做」，但不要公開「你實際在哪裡、用什麼帳號、對哪些私人資料做」。**