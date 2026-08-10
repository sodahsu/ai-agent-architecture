# Change: public-architecture-foundation

## Why

目前專案已具備公開架構、Agent / Skill Contract、Claude Code / Codex Adapter 與安裝器，但要達到可安全合併狀態，仍需要把公開開發規範、安裝安全邊界、隱私檢查與驗證流程收斂成明確契約。

## What Changes

- 建立公開 repository 的開發規範與 OpenSpec 基線。
- 強化 installer / uninstaller：
  - 不寫入安裝機器絕對路徑。
  - 不覆蓋或刪除已被使用者修改的入口檔。
  - 拒絕 `.ai-agent-architecture` symlink，避免寫入目標 repository 外。
  - 保護 symlinked `CLAUDE.md` / `AGENTS.md`。
- 增加安裝邊界案例測試。
- 增加本機 privacy check 與統一 check entrypoint。
- 同步 README / INSTALL / Privacy 文件與實際行為。

## Non-goals

- 不加入新的模型供應商 Adapter。
- 不修改 GitHub Actions、部署、Secrets 或帳務。
- 不新增 Production Runtime。
- 不替專案決定開源 License。

## Risks

- 安裝器會操作目標 repository 檔案，任何覆蓋／刪除錯誤都可能造成使用者資料損失。
- Public repository 中的任何 machine-specific metadata 都可能永久洩漏私人資訊。
- Adapter 與核心 Contract 若重複維護會產生 drift。

## Success Criteria

- 安裝／更新／解除安裝邊界案例測試通過。
- 公開內容 Privacy Check 通過。
- OpenSpec、README、INSTALL 與 scripts 行為一致。
- 分支相對 `main` 無落後，且所有變更保留在 feature branch / Draft PR 供人工審查。
