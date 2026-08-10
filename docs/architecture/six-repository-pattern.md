# 六倉架構模式（Six-Repository Pattern）

## 為什麼需要六個 Repository？

成熟的 AI 工作空間通常會把許多性質完全不同的內容混在一起：私人記憶、Agent 規則、外部工具實驗、自動化執行、公開文章與作品集。這些內容的隱私等級、生命週期與風險並不相同。

如果全部放進同一個 repository，就很難同時做到：

- 公開方法論
- 保護私人上下文
- 隔離 production runtime
- 控制外部工具導入風險
- 讓公開成果容易理解

六倉架構的目的，是把六種責任拆開，讓每一倉都能在適合自己的安全與發布邊界內演進。

```text
1. Knowledge Repository       私人知識真相源與長期上下文
2. Agent Control Repository   穩定規則、Skills、路由與治理
3. Evaluation Repository      外部工具與 Skill 的隔離評估
4. Execution Repository       非同步任務與 Runtime 自動化
5. Lab Repository             公開實驗、筆記與學習輸出
6. Portfolio Repository       精選成果與案例
```

## 1. Knowledge Repository｜知識倉

**目的：** 保存 canonical knowledge、私人記憶、決策、筆記與專案上下文。

**預設可見性：** Private。

這一倉不應直接成為公開文件來源。真正值得分享的內容，應該先萃取成方法、模式或匿名案例，再跨越公開邊界。

## 2. Agent Control Repository｜代理控制倉

**目的：** 保存穩定 Agent 指令、可重用 Skills、Routing Rules、Workflow Contracts、Governance 與跨工具 Adapter。

**預設可見性：** Private runtime，或另外萃取一份 sanitized public core。

關鍵不是「規則能不能公開」，而是要區分：

- 可重用的方法與契約
- 真實使用者／runtime 狀態

前者可以公開，後者應保持私有。

## 3. Evaluation Repository｜評估倉

**目的：** 在導入正式系統前，隔離評估外部 Skill、MCP Server、Hook、Harness 與 AI Workflow Tool。

**預設可見性：** 當測試素材全部來自公開來源，且授權允許時，可以 Public。

候選工具應經過明確狀態：

```text
inbox → research → test → adopt / adapt / reject
```

這可以避免「只是測試一下」的 dependency，無聲無息變成 production behavior。

## 4. Execution Repository｜執行倉

**目的：** 負責排程、事件驅動 Agent、Webhook、Batch Job、CI Automation 與非同步執行。

**預設可見性：** 若連接真實 Credential 或 Production Infrastructure，應保持 Private。

可以另外萃取公開模板，但真實 runtime wiring、secret reference 與 infrastructure topology 不應因為開源而外露。

## 5. Lab Repository｜實驗倉

**目的：** 公開實驗、技術筆記、Prototype、設計探索與學習紀錄。

**預設可見性：** Public。

Lab 的價值在於呈現思考過程與學習軌跡，但內容必須是經過去識別化與整理後的版本，而不是直接同步私人知識庫。

## 6. Portfolio Repository｜作品倉

**目的：** 保存經過整理的 Case Study、成果、產品判斷與可對外展示的工作證據。

**預設可見性：** 通過保密與隱私審查後 Public。

Portfolio 必須是選擇性的。它展示「最後值得看的證據」，而不是完整內部工作紀錄。

## 資訊流

```text
                    私有邊界

 Knowledge ────────→ Agent Control ────────→ Execution
    │                     │                     │
    │                     ↓                     │
    │                Evaluation                 │
    │                     │                     │
    └──── 萃取後的經驗 ────────────────────────┘
                          ↓
                         Lab
                          ↓
                      Portfolio

                    公開邊界
```

箭頭代表的是**萃取（distillation）**，不是 raw synchronization。私人資料不應自動流進公開 repository。

## 設計原則

1. 把 canonical truth 與 public explanation 分開。
2. 把 stable behavior 與 experimental dependency 分開。
3. 把互動式判斷與非同步執行分開。
4. 把學習產物與職涯展示證據分開。
5. 跨越公開／私有邊界時，必須透過 review，而不是自動複製。
6. 隱私分類是架構的一部分，不是最後才補上的檢查項。

## 什麼時候不需要六倉？

六個 repository 本身不是目標。如果系統較小，而且不同角色的安全邊界與生命週期完全相同，可以合併角色。

只有當拆倉能明顯提升以下價值時才值得拆：

- 隱私隔離
- 治理清晰度
- 部署獨立性
- Ownership 清楚度
- 風險控制

**六倉是一種責任分離方法，不是固定數量的教條。**