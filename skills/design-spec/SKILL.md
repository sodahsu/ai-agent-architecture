# Skill: design-spec

## Purpose

把已決定的設計方案轉成可交付 Design Spec，定義行為、狀態、邊界條件、例外與不在本次範圍的內容，減少設計與實作之間的猜測。

## Inputs

- Feature / Component Name
- Approved Design / Flow
- Behavior Notes
- Existing Component / Token Context（可選）
- Technical Constraints（可選）

## Outputs

- Overview
- Behavior Specification
- State Matrix
- Edge Cases
- Out-of-scope
- Open Questions

## Preconditions

- 主要設計方向已經確定；本 Skill 不用來替代前期探索。
- 若關鍵行為仍未決，必須標記 Open Question，而不是自行補完產品決策。

## Permissions

- Read: approved design + relevant constraints
- Write: specification artifact only
- Code / design tool write: none by default

## Procedure

1. 用一段話說明功能存在的目的與使用情境。
2. 按 Trigger → System Behavior → User-visible State 描述主要互動。
3. 至少檢查 Default、Loading、Empty、Error、Success，以及功能特有狀態。
4. 列出權限不足、資料異常、Network Failure、重複操作等適用的 Edge Cases。
5. 與已提供的 Design System / Component Contract 比對；衝突標記為 Open Question。
6. 明確列出 Out-of-scope，避免實作者自行擴張需求。
7. 將未決產品／設計問題與已確定規格分開。

## Validation

另一個 Implementer 應能根據 Spec 判斷每個主要狀態怎麼觸發、系統如何回應，以及哪些情況不在本次實作範圍。

## Failure Conditions

- 核心流程尚未決定
- Spec 需要自行發明未授權的產品行為才能完整
- State / Edge Case 完全無法從現有設計與需求推定

## Completion Criteria

主要行為與狀態皆有明確定義，Edge Cases 與 Open Questions 已揭露，且 Spec 不要求實作者依賴完整聊天紀錄補足規則。
