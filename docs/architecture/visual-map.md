# Architecture Visual Map

This document visualizes the reference architecture without exposing any real account, repository, workspace, machine, or private memory.

## Six-repository pattern

```mermaid
flowchart TB
    subgraph PRIVATE[Private operating layer]
        K[1. Knowledge Repository\nCanonical private context]
        C[2. Agent Control Repository\nRules, routing, stable skills]
        X[4. Execution Repository\nAsync jobs and automation]
    end

    subgraph REVIEW[Controlled promotion boundary]
        E[3. Evaluation Repository\nTest external tools and skills]
        G{{Governance gates\nprivacy · permissions · validation}}
    end

    subgraph PUBLIC[Public evidence layer]
        L[5. Lab Repository\nExperiments and technical writing]
        P[6. Portfolio Repository\nCurated outcomes and case studies]
    end

    K -->|approved context contract| C
    E -->|adopt / adapt| G
    G -->|stable capability| C
    C -->|bounded assignment| X
    X -->|result + evidence| C
    C -->|sanitized insight| L
    L -->|validated narrative| P
    P -. feedback .-> C
```

The six repositories are **roles**, not mandatory product names. A team may implement them as six repositories, fewer repositories with strict directories, or more repositories when security boundaries require it.

## Public / private boundary

```mermaid
flowchart LR
    A[Private source material] --> B{Sanitization gate}
    B -->|contains identity, secrets, private context| R[Reject or keep private]
    B -->|reusable and non-identifying| M[Method / pattern / contract]
    M --> D[Public documentation]
    M --> T[Public template]
    M --> E[Public synthetic example]
```

The public project should publish **reusable decisions and system design**, not snapshots of the operator's actual brain.

## Control loop

```mermaid
flowchart LR
    I[Intent] --> R[Route]
    R --> A[Assign]
    A --> E[Execute]
    E --> V[Validate]
    V --> H{Human approval required?}
    H -->|yes| P[Approval gate]
    H -->|no| O[Output]
    P -->|approved| O
    P -->|revise| R
    O --> F[Feedback / learning]
    F --> R
```

This loop separates **decision-making**, **execution**, and **approval** so that an agent is not implicitly authorized to do everything simply because it can perform the task.

## Design properties

A healthy implementation should make these properties visible:

1. **Canonical truth is explicit.** Memory and policy each have a defined source of truth.
2. **Permissions are narrow.** Agents receive only the tools and write scope needed for the assignment.
3. **Promotion is deliberate.** Experimental skills do not become stable behavior automatically.
4. **Execution is reversible by default.** Changes prefer branches, drafts, proposals, or previews over direct irreversible writes.
5. **Public artifacts are sanitized.** Examples are synthetic and cannot be used to reconstruct private operating context.
