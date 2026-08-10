# Tasks: public-architecture-foundation

- [x] 建立公開 repository 開發規範 `AGENTS.md`
- [x] 建立 OpenSpec project baseline
- [x] 定義 installer / uninstaller safety contract
- [x] 移除 `INSTALL-METADATA` 的本機絕對路徑
- [x] 保護已修改的 managed entry，避免 update / uninstall 資料損失
- [x] 拒絕 `.ai-agent-architecture` symlink
- [x] 保護 symlinked `CLAUDE.md` / `AGENTS.md`
- [x] 擴充 installer boundary tests
- [ ] 新增 `scripts/privacy-check.sh`
- [ ] 新增統一 `scripts/check.sh`
- [ ] 同步 README / INSTALL / PRIVACY 文件
- [ ] 執行 shell syntax check
- [ ] 執行 installer smoke / regression tests
- [ ] 執行 privacy check
- [ ] 執行 contract structure check
- [ ] 最終比對 `main` 與 Draft PR 狀態

## Out of scope / user decision

- [ ] 選定正式開源 License（MIT / Apache-2.0 / other）— 屬於授權決策，不在本次自動決定範圍。
