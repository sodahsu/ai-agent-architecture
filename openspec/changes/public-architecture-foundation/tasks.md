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
- [x] 同步 README / INSTALL / PRIVACY 文件
- [x] 執行 shell syntax check
- [x] 執行 installer smoke / regression tests
- [x] 執行 privacy check
- [x] 執行 contract structure check
- [x] 最終比對 `main` 與 Draft PR 狀態

## Verification Notes

- Branch：`feature/public-architecture-foundation`
- 相對 `main`：`behind 0`
- Installer / Uninstaller regression fixture：pass
- Privacy positive check：pass
- Privacy negative cases（real email / concrete home path / credential-like token）：正確 fail
- Contract structure check：pass
- GitHub Actions / Deploy / Secret：本次未修改
- 由於執行環境無法直接對 GitHub 做 network clone，腳本測試使用與 repository 結構等價的 local fixture；GitHub connector 另行核對實際 branch 檔案、PR diff 與 Contract headings。

## Out of scope / user decision

- [ ] 選定正式開源 License（MIT / Apache-2.0 / other）— 屬於授權決策，不在本次自動決定範圍。
