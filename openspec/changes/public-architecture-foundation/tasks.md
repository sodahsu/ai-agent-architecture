# Tasks: public-architecture-foundation

- [x] 建立公開 repository 開發規範 `AGENTS.md`
- [x] 建立 OpenSpec project baseline
- [x] 定義 installer / uninstaller safety contract
- [x] 移除 `INSTALL-METADATA` 的本機絕對路徑
- [x] 保護已修改的 managed entry，避免 update / uninstall 資料損失
- [x] 拒絕 `.ai-agent-architecture` symlink
- [x] 保護 symlinked `CLAUDE.md` / `AGENTS.md`
- [x] 拒絕 symlinked `INSTALL-METADATA`
- [x] 禁止未 uninstall 直接切換 Adapter
- [x] 擴充 installer boundary tests
- [x] 新增 `scripts/privacy-check.sh`
- [x] 新增統一 `scripts/check.sh`
- [x] 建立 Public Capability Catalog
- [x] 將 Agent 分成 Lifecycle / Domain 兩個維度
- [x] 公開 Design / Product / People Domain Coordinators
- [x] 公開 Clarify / Adversarial Review / Roadmap Planning
- [x] 公開 Design Brief / Review / Spec / System
- [x] 公開 Code Review / Root Cause / Task Checkpoint / Skill Audit
- [x] 公開 Meeting to Decisions
- [x] Public Core 達到 7 Agents / 18 Skills
- [x] 新增 Public Capability OpenSpec
- [x] Installer regression test 驗證新增 Agent / Skill 會一起安裝
- [x] 同步根 README 的 Public Capability 摘要與數量
- [x] 執行 shell syntax check
- [x] 執行 installer smoke / regression tests
- [x] 執行 privacy check
- [x] 執行 privacy negative case
- [x] 執行 contract structure check（含 7 Agents / 18 Skills count）
- [x] 最終比對 `main` 與 Draft PR 狀態

## Verification Notes

- Branch：`feature/public-architecture-foundation`
- 相對 `main`：`behind 0`
- GitHub PR changed-file inventory：7 Agent Contract / 18 Skill Contract
- Local equivalent fixture：`install tests passed`
- Local equivalent fixture：`privacy checks passed`
- Local equivalent fixture：`all checks passed (7 agents, 18 skills)`
- Privacy negative case（unexpected real email pattern）：正確 fail
- GitHub PR diff 搜尋未發現私人 AI brain repository 名稱、Personal Memory store 名稱或私人 Email
- Public Capability Boundary：`docs/governance/public-capability-catalog.md`
- Public Capability Spec：`specs/public-capabilities/spec.md`
- GitHub Actions / Deploy / Secret：本次未修改
- 正式 License：repository `main` 已存在 MIT License；本次只同步相關文件，不修改授權本文。

### Environment limitation

執行環境無法解析 `github.com` DNS，因此不能用 `git clone` 直接把 remote feature branch 拉進本機執行。為避免把環境問題誤報成測試結果，本次採兩段驗證：

1. GitHub connector 核對實際 branch / PR 的檔案、diff、數量與敏感字串。
2. 以目前 branch 的 Installer / Uninstaller / Privacy / Check 契約建立等價本機 fixture，執行完整回歸。

## Keep-private boundary

本次不公開：

- Personal Memory / Personal Assistant / private knowledge bridge
- 私人發布與個人品牌 Runtime
- Provider account routing / billing / quota / production deployment
- Machine-specific sync / bootstrap
- 真實 People / Employee / Candidate Data
- 未完成 License / Attribution Review 的第三方 Skill 原文
