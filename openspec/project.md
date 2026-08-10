# Project: AI Agent Architecture

## Purpose

提供一套可公開、可安裝、平台中立的 AI Agent 架構與方法論，讓使用者能理解並採用 Repository / Agent / Skill / Tool / Workflow / Artifact / Governance 的責任分層。

## Scope

本專案包含：

- 六倉責任模式與架構層級
- Agent / Skill Contract
- Governance 與 Privacy Boundary
- Claude Code / Codex Adapter
- 安裝、更新、解除安裝與本機驗證腳本
- Synthetic Example 與公開文件

## Non-goals

- 不保存任何人的私人 AI Memory
- 不提供 Production Credential 或真實部署設定
- 不綁定單一模型供應商
- 不自動 Merge、Deploy 或操作受保護資源
- 不把 Adapter 變成第二份 Agent / Skill 真相源

## Design Principles

1. 公開方法，不公開私人 AI 大腦。
2. Capability 不等於 Permission。
3. Context 與 Tool 權限採最小必要原則。
4. 變更預設可逆、可審查。
5. 公開範例必須 synthetic、不可回推私人上下文。
6. KISS：優先維持小而清楚的契約，不為未發生的需求增加抽象層。

## Development Rules

- 不直接修改 `main`。
- 非簡單架構、治理、安裝器或 Contract 變更應有 OpenSpec。
- 不變更部署、Secrets、帳務或 GitHub Actions，除非需求明確要求。

## Validation

```bash
bash -n scripts/*.sh
bash scripts/test-install.sh
bash scripts/privacy-check.sh
bash scripts/check.sh
```

若環境無法取得完整 checkout，應以可重現 fixture 驗證腳本行為，並在交接中註明限制。
