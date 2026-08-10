# 貢獻指南

感謝你對 AI Agent Architecture 的改善。

這是一個公開 repository；提交前請把所有內容視為可能被永久保存、搜尋與 Fork。

## 開發流程

1. 從最新 `main` 建立 feature branch。
2. 只修改與目標直接相關的內容，遵守 KISS。
3. 非簡單架構、Governance、Installer 或 Agent / Skill Contract 變更，更新 `openspec/`。
4. 文件主要使用繁體中文；程式碼、檔名與固定技術術語可保留英文。
5. 提交 PR，不直接寫入 `main`。

## 提交前檢查

```bash
bash scripts/check.sh
```

至少應確認：

- Shell syntax 通過
- Installer / Uninstaller regression tests 通過
- Privacy Check 通過
- Agent / Skill Contract 結構完整
- README / INSTALL / OpenSpec 與實作一致

## Privacy

請先閱讀 [PRIVACY.md](PRIVACY.md)。

不要提交：

- Personal Memory / Conversation History
- 真實私人 Email、Account、Device 或本機絕對路徑
- Private Repository / Internal URL
- Employer / Client / Confidential Project Data
- Token、Credential、Secret 或 Production Configuration
- 原始 Log、Screenshot 或 Config Dump，除非已確認完全不含敏感資訊

範例請使用 synthetic data 與 placeholder。

## Agent / Skill Contract

核心 Contract 的真相源：

- Agent：`agents/`
- Skill：`skills/`

Adapter 只負責平台入口與映射，不應複製完整程序形成第二份真相源。

## Installer 變更

任何 Installer / Uninstaller 修改都必須特別檢查：

- 不覆蓋使用者既有或已修改入口
- 不越過 target repository 的 write boundary
- 不把來源機器路徑或 identifier 寫進安裝產物
- 解除安裝只移除本專案明確管理且可安全辨識的內容

## License

專案目前尚未選定正式 License。正式 Release 前會由維護者決定授權條款；請勿假設尚未加入的授權條款。
