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
- [ ] 同步根 README 的 Public Capability 摘要與數量
- [ ] 執行 shell syntax check
- [ ] 執行 installer smoke / regression tests
- [ ] 執行 privacy check
- [ ] 執行 contract structure check（含 7 Agents / 18 Skills count）
- [ ] 最終比對 `main` 與 Draft PR 狀態

## Verification Notes

- Branch：`feature/public-architecture-foundation`
- Public Capability Boundary：`docs/governance/public-capability-catalog.md`
- Public Capability Spec：`specs/public-capabilities/spec.md`
- GitHub Actions / Deploy / Secret：本次未修改
- 正式 License：repository `main` 已存在 MIT License；本次不修改 License 內容。

## Keep-private boundary

本次不公開：

- Personal Memory / Personal Assistant / private knowledge bridge
- 私人發布與個人品牌 Runtime
- Provider account routing / billing / quota / production deployment
- Machine-specific sync / bootstrap
- 真實 People / Employee / Candidate Data
- 未完成 License / Attribution Review 的第三方 Skill 原文
