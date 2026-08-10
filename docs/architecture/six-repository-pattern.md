# Six-Repository Pattern

## Why six repositories?

A mature AI workspace often mixes concerns that have very different privacy, lifecycle, and risk requirements. Keeping everything in one repository makes it difficult to publish useful methods without exposing private context or operational infrastructure.

The Six-Repository Pattern separates six responsibilities so each can evolve under an appropriate security and publishing boundary.

```text
1. Knowledge Repository        private truth and long-term context
2. Agent Control Repository    stable rules, skills, routing, governance
3. Evaluation Repository       isolated testing of external tools and skills
4. Execution Repository        asynchronous jobs and runtime automation
5. Lab Repository              public experiments, notes, and learning
6. Portfolio Repository        curated outcomes and case studies
```

## 1. Knowledge Repository

**Purpose:** canonical knowledge, private memory, decisions, notes, and project context.

**Default visibility:** private.

It should not become the public documentation surface. Public lessons should be distilled out of it rather than exposing the original source material.

## 2. Agent Control Repository

**Purpose:** stable agent instructions, reusable skills, routing rules, workflow contracts, governance, and cross-tool adapters.

**Default visibility:** private runtime or a sanitized public core.

The important distinction is between reusable methodology and actual user/runtime state.

## 3. Evaluation Repository

**Purpose:** quarantine and evaluate external skills, MCP servers, hooks, harnesses, and AI workflow tools before adoption.

**Default visibility:** public-safe when all evaluation inputs are public and licensing permits it.

A candidate moves through explicit states such as:

```text
inbox → research → test → adopt / adapt / reject
```

This prevents experimental dependencies from silently becoming production behavior.

## 4. Execution Repository

**Purpose:** scheduled work, event-driven agents, webhooks, batch jobs, CI-based automation, and asynchronous execution.

**Default visibility:** private when connected to real credentials or production infrastructure.

Public templates can be extracted separately, but real runtime wiring should remain isolated.

## 5. Lab Repository

**Purpose:** publish experiments, technical notes, prototypes, design explorations, and lessons learned.

**Default visibility:** public.

The lab shows the reasoning process and creates a durable learning trail without exposing raw private knowledge.

## 6. Portfolio Repository

**Purpose:** curated case studies, outcomes, product decisions, and professionally presented work.

**Default visibility:** public, after confidentiality and privacy review.

The portfolio is selective. It shows finished evidence rather than the entire internal working history.

## Information flow

```text
                    private boundary

 Knowledge ────────→ Agent Control ────────→ Execution
    │                     │                     │
    │                     ↓                     │
    │                Evaluation                 │
    │                     │                     │
    └──── distilled lessons ────────────────────┘
                          ↓
                         Lab
                          ↓
                      Portfolio

                    public boundary
```

The arrows represent **distillation**, not raw synchronization. Private data should not automatically flow into public repositories.

## Design principles

1. Separate canonical truth from public explanation.
2. Separate stable behavior from experimental dependencies.
3. Separate interactive decision-making from asynchronous execution.
4. Separate learning artifacts from curated career evidence.
5. Promote knowledge across boundaries through review, not automatic copying.
6. Treat privacy classification as part of architecture, not an afterthought.

## When not to use six repositories

Six repositories are not a goal by themselves. Smaller systems should merge roles when the security and lifecycle boundaries are identical. Split only when a boundary creates meaningful gains in privacy, governance, deployment independence, or clarity of ownership.
