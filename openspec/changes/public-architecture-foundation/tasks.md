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
- [x] 建立 Public Capability Catalog
- [x] 將 Agent 分成 Lifecycle / Domain 兩個維度
- [x] 建立目前 Public Core Agent / Skill Contract
- [x] 新增 Public Capability OpenSpec
- [x] 新增 `scripts/privacy-check.sh`
- [x] 新增 `scripts/privacy-history-check.sh`
- [x] 新增統一 `scripts/check.sh`
- [x] Installer regression test 驗證 Public Agent / Skill 會一起安裝
- [x] 同步 README / INSTALL / PRIVACY / Adapter 文件

## Reverse Review Fixes

- [x] MIT `LICENSE` 隨 Public Core 安裝，避免散布 notice 遺失
- [x] Installer regression 驗證 `.ai-agent-architecture/LICENSE`
- [x] 移除 `check.sh` 的固定 7 / 18 capability count gate
- [x] Capability count 改為依實際檔案動態盤點
- [x] Claude Code Adapter 移除手寫 capability inventory
- [x] Codex Adapter 移除手寫 capability inventory
- [x] Adapter 改由 `agents/README.md` / `skills/README.md` 發現能力
- [x] Reviewer 區分 independent review / structured self-review
- [x] Adversarial Review 不再把同 session multi-lens 誇大成 independent review
- [x] People Coordinator 禁止 AI 自動員工／候選人排名與評分
- [x] 文件明示 `.ai-agent-architecture/` 是可替換的 managed namespace
- [x] Current-tree Privacy Check 擴充常見文字格式
- [x] 新增 Git history Privacy Scan，避免只檢查最終 diff
- [x] 根 README 簡化，減少與 canonical docs 重複

## Verification Notes

- Branch：`feature/public-architecture-foundation`
- 相對 `main`：每輪收尾重新確認
- Public capability inventory：由實際 `agents/*.md` / `skills/*/SKILL.md` 動態盤點
- Current-tree privacy：`scripts/privacy-check.sh`
- Git-history privacy：`scripts/privacy-history-check.sh`（需真實 Git worktree）
- Public Capability Boundary：`docs/governance/public-capability-catalog.md`
- Public Capability Spec：`specs/public-capabilities/spec.md`
- GitHub Actions / Deploy / Secret：本次未修改
- 正式 License：repository 已採用 MIT；Installer 現在同步散布 notice

### Environment limitation

目前執行環境無法直接 `git clone` remote feature branch，因此：

1. GitHub connector 用來核對真實 branch / PR 檔案、diff 與狀態。
2. Installer / Privacy / Contract scripts 使用等價 fixture 做本機回歸。
3. `privacy-history-check.sh` 已加入，但真正的 remote branch history 掃描仍必須在可取得 `.git` metadata 的 clone 中執行；沒有 Git metadata 時腳本會明確顯示 skipped。

## Keep-private boundary

本次不公開：

- Personal Memory / Personal Assistant / private knowledge bridge
- 私人發布與個人品牌 Runtime
- Provider account routing / billing / quota / production deployment
- Machine-specific sync / bootstrap
- 真實 People / Employee / Candidate Data
- 未完成 License / Attribution Review 的第三方 Skill 原文
