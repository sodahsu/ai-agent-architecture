# Change: public-architecture-foundation

## Why

目前專案已具備公開架構、Agent / Skill Contract、Claude Code / Codex Adapter 與安裝器。要達到可安全合併、可由其他人採用的狀態，需要同時把公開開發規範、安裝安全邊界、隱私檢查、Public Capability Boundary 與驗證流程收斂成明確契約。

## What Changes

- 建立公開 repository 的開發規範與 OpenSpec 基線。
- 強化 installer / uninstaller：
  - 不寫入安裝機器絕對路徑。
  - 不覆蓋或刪除已被使用者修改的入口檔。
  - 拒絕 managed namespace / metadata symlink，避免寫入目標 repository 外。
  - 保護 symlinked `CLAUDE.md` / `AGENTS.md`。
  - 同一 installation 一次只管理一個 Adapter。
- 增加安裝邊界案例測試。
- 增加本機 privacy check 與統一 check entrypoint。
- 定義 Public Capability Catalog，區分 Public Core / Adapt Before Public / Keep Private。
- 將可泛化能力整理成 7 個 Public Agents：
  - 4 個 Lifecycle Agents
  - 3 個 Domain Agents
- 將可泛化程序整理成 18 個 Public Skills，涵蓋 Core / Governance、Product / Knowledge、Design、Engineering / Operations。
- 公開 Agent / Skill 去除 Personal Memory、Private Repository、Credential、Machine Path 與 Production Runtime 耦合。
- 同步 README / INSTALL / Privacy / Agent / Skill 文件與實際行為。

## Non-goals

- 不加入新的模型供應商 Adapter。
- 不修改 GitHub Actions、部署、Secrets 或帳務。
- 不新增 Production Runtime。
- 不把私人 Memory、私人發布流程、Provider Account Routing、Billing / Quota 或 Machine Sync 直接公開。
- 不把第三方 Skill 原文在沒有 License / Attribution Review 的情況下搬進 Public Core。

## Risks

- 安裝器會操作目標 repository 檔案，任何覆蓋／刪除錯誤都可能造成使用者資料損失。
- Public repository 中的任何 machine-specific metadata 都可能永久洩漏私人資訊。
- Adapter 與核心 Contract 若重複維護會產生 drift。
- Domain Agent 與 Lifecycle Agent 若未清楚分層，使用者可能誤以為專業路由角色自動取得寫入權。
- 私人能力若直接 Copy 到公開版，可能洩漏私人依賴或形成無法被其他人使用的假公開能力。

## Success Criteria

- 安裝／更新／解除安裝邊界案例測試通過。
- 公開內容 Privacy Check 通過。
- 7 個 Public Agent 與 18 個 Public Skill Contract 通過結構檢查。
- Public Capability Catalog 明確列出公開與 Keep-private 邊界。
- OpenSpec、README、INSTALL 與 scripts 行為一致。
- 分支相對 `main` 無落後，且所有變更保留在 feature branch / Draft PR 供人工審查。
