# 架構視覺圖（Architecture Visual Map）

這份文件只呈現可公開的參考架構，不包含任何真實帳號、repository、workspace、裝置或私人記憶。

## 六倉架構

```mermaid
flowchart TB
    subgraph PRIVATE[私有運作層]
        K[1. Knowledge Repository\n私人知識真相源]
        C[2. Agent Control Repository\n規則、路由、穩定 Skills]
        X[4. Execution Repository\n非同步任務與自動化]
    end

    subgraph REVIEW[受控晉升邊界]
        E[3. Evaluation Repository\n測試外部工具與 Skills]
        G{{Governance Gates\n隱私 · 權限 · 驗證}}
    end

    subgraph PUBLIC[公開證據層]
        L[5. Lab Repository\n實驗與技術文章]
        P[6. Portfolio Repository\n精選成果與案例]
    end

    K -->|核准後的 Context Contract| C
    E -->|adopt / adapt| G
    G -->|穩定能力| C
    C -->|有邊界的 Assignment| X
    X -->|結果 + 驗證證據| C
    C -->|去識別化洞察| L
    L -->|驗證後敘事| P
    P -. 回饋 .-> C
```

六個 repository 是**架構角色**，不是強制的產品名稱。實際系統可以真的拆成六個 repository，也可以在安全邊界一致時合併；若風險與部署需求更複雜，也可能拆得更多。

## 公開／私有邊界

```mermaid
flowchart LR
    A[私人原始素材] --> B{去識別化 Gate}
    B -->|含身份、Secret、私人上下文| R[拒絕公開或維持 Private]
    B -->|可重用且不可識別| M[Method / Pattern / Contract]
    M --> D[公開文件]
    M --> T[公開模板]
    M --> E[公開虛構範例]
```

公開專案應該發布的是**可重用的決策與系統設計**，不是操作者真實 AI 大腦的快照。

## 控制迴路

```mermaid
flowchart LR
    I[Intent] --> R[Route]
    R --> A[Assign]
    A --> E[Execute]
    E --> V[Validate]
    V --> H{需要人工批准？}
    H -->|是| P[Approval Gate]
    H -->|否| O[Output]
    P -->|批准| O
    P -->|要求修正| R
    O --> F[Feedback / Learning]
    F --> R
```

這個迴路刻意把**判斷、執行與批准**分開。Agent 能做到某件事，不代表它自然擁有執行該操作的權限。

## 健康架構應具備的特性

1. **Canonical Truth 明確。** 記憶與政策都有清楚的真相源。
2. **Permissions 狹窄。** Agent 只取得任務真正需要的工具與寫入範圍。
3. **能力晉升有程序。** 實驗中的 Skill 不會自動變成 stable behavior。
4. **預設可回復。** 優先使用 branch、draft、proposal、preview，而不是不可逆直接寫入。
5. **公開 Artifact 已去識別化。** 範例使用 synthetic data，無法反推出私人運作上下文。