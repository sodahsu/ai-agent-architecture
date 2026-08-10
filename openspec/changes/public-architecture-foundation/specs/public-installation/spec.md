# Spec: Public Installation Safety

## Requirement: Privacy-safe metadata

安裝器 MUST NOT 把來源機器的絕對路徑、Hostname、Account Identifier 或其他 machine-specific value 寫入目標 repository。

### Scenario: Installation metadata

- WHEN 使用者安裝任一 Adapter
- THEN `INSTALL-METADATA` 僅包含公開專案識別、schema version 與 adapter 類型
- AND MUST NOT 包含 `installed_from=<absolute-path>` 或其他本機路徑

## Requirement: License notice propagation

Installer 散布 Public Core 時 MUST 一起保留 repository 的 MIT License notice。

### Scenario: Public package installation

- WHEN 使用者安裝任一 Adapter
- THEN `.ai-agent-architecture/LICENSE` MUST 存在
- AND MUST 包含 MIT License notice

## Requirement: Managed namespace ownership

`.ai-agent-architecture/` MUST 被明確定義為 installer-managed namespace，避免使用者誤以為其中任意自訂資料都會在 update / uninstall 時被保留。

### Scenario: User wants project-specific customization

- WHEN 使用者需要加入專案專屬規則或私人設定
- THEN 文件 MUST 指示使用既有 `CLAUDE.md` / `AGENTS.md` 或其他專案設定
- AND MUST NOT 建議把唯一副本存進 `.ai-agent-architecture/`

## Requirement: Existing entry preservation

安裝器 MUST NOT 覆蓋使用者既有或已修改的 `CLAUDE.md` / `AGENTS.md`。

### Scenario: Existing user entry

- GIVEN 目標已存在非 managed entry
- WHEN 執行安裝
- THEN 原 entry 保持不變
- AND 產生 `.ai-agent-architecture/<ENTRY>.integration.md`

### Scenario: Modified managed entry

- GIVEN entry 原先由本專案建立，但之後已被使用者修改
- WHEN 重新安裝
- THEN MUST preserve 使用者版本
- AND MUST 產生 integration template，而不是覆蓋

### Scenario: Unmodified managed entry

- GIVEN entry 與前一次安裝的 adapter entry 完全相同
- WHEN 重新安裝
- THEN MAY 自動更新成新版本

## Requirement: Single adapter per managed namespace

同一個 `.ai-agent-architecture` installation MUST 一次只管理一個 Adapter，避免留下 orphan entry 或雙入口狀態。

### Scenario: Adapter switch without uninstall

- GIVEN 目前 metadata 顯示已安裝 `claude-code`
- WHEN 使用者直接要求安裝 `codex`
- THEN installer MUST fail closed
- AND 原本 installation 與 `CLAUDE.md` MUST 保持不變
- AND 使用者應先執行 uninstall，再安裝另一個 Adapter

## Requirement: Safe uninstall

解除安裝 MUST NOT 只因存在 managed marker 就刪除 entry。

### Scenario: Unmodified managed entry

- GIVEN entry 與目前安裝在 `.ai-agent-architecture/adapter/` 的版本完全相同
- WHEN 解除安裝
- THEN MAY 移除 entry

### Scenario: Modified managed entry

- GIVEN entry 帶 managed marker 但內容已修改
- WHEN 解除安裝
- THEN MUST preserve entry
- AND 僅移除 `.ai-agent-architecture/` managed namespace

## Requirement: Symlink boundary

安裝器與解除安裝器 MUST NOT 透過 managed symlink 對 target repository 外的路徑執行讀寫。

### Scenario: Managed namespace is a symlink

- GIVEN `.ai-agent-architecture` 是 symbolic link
- WHEN install 或 uninstall
- THEN MUST fail closed
- AND MUST NOT 修改 symlink target

### Scenario: Entry is a symlink

- GIVEN `CLAUDE.md` 或 `AGENTS.md` 是 symbolic link
- WHEN install
- THEN MUST preserve symlink 與其 target
- AND 產生 integration template

### Scenario: Metadata is a symlink

- GIVEN `.ai-agent-architecture/INSTALL-METADATA` 是 symbolic link
- WHEN install
- THEN MUST fail closed before reading or replacing metadata
- AND MUST NOT 修改 symlink target

## Requirement: Local verification

Repository MUST 提供不依賴 Production、Secret 或外部 API 的本機驗證入口。

### Scenario: Maintainer check

- WHEN 執行 `bash scripts/check.sh`
- THEN shell syntax、installation regression、current-tree privacy、available git-history privacy 與 contract structure checks MUST 執行
- AND 若不是 Git worktree，history check MUST 明確標記 skipped
- AND 不得修改使用者 repository 之外的持久狀態
