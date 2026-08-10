# 系統總覽（System Overview）

## 目標

設計一套 AI 工作空間，使可重用的方法能安全公開，同時把私人記憶、Credential、裝置狀態與真實運作上下文隔離在公開架構之外。

## 分層

```text
Interaction Layer
    ↓
Routing / Decision Layer
    ↓
Execution Skills
    ↓
Review & Approval Gates
    ↓
Runtime / External Systems
```

知識與記憶另外分成兩種責任：

```text
Public Methodology  ← 模式、契約、範例
Private Memory      ← 個人／專案上下文與 canonical facts
```

### 1. Interaction Layer｜互動層

接收自然語言目標，轉成明確的工作意圖。可重用的公開指令中，不應混入敏感私人上下文。

### 2. Routing / Decision Layer｜路由與決策層

選擇適合的 Agent、Workflow 或 Skill。路由必須遵守 Least Privilege：每個任務只取得完成工作真正需要的工具與上下文。

### 3. Execution Skills｜執行技能層

可重用程序應明確定義：

- Inputs
- Preconditions
- Constraints
- Expected Outputs
- Validation Steps
- Tool Permissions

Skill 應該小到可以審查，也要能彼此組合，而不是變成不可理解的大型 prompt。

### 4. Review & Approval Gates｜審查與批准層

高影響操作必須先通過明確 Gate，例如：

- 對外發布
- Production Deployment
- 破壞性修改
- Secret Handling
- Data Migration
- Protected Branch 寫入

### 5. Runtime Layer｜實際執行層

真實 Account、Token、本機路徑、Private Repository、Production Service 與 Personal Memory 都應留在公開架構 repository 之外。

## 架構特性

- Privacy by Separation：透過責任分離保護隱私
- Least-Privilege Execution：最小權限執行
- Explicit Handoffs：交接必須有明確 artifact
- Observable Decisions：重要判斷可被回顧
- Reversible by Default：預設採用可回復變更
- Human Approval for High Risk：高風險操作由人批准
- Vendor-Independent Methodology：方法不綁定單一 AI 供應商

這套架構的核心不是追求「完全自主」，而是讓 AI 在清楚的責任、上下文、權限與批准邊界內自主執行。