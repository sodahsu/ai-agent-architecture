# System Overview

## Goal

Design an AI workspace where reusable methods can be shared publicly while private memory, credentials, machine state, and operational context remain isolated.

## Layers

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

Knowledge and memory are separate concerns:

Public methodology  ← patterns, contracts, examples
Private memory      ← personal/project context and canonical facts
```

### 1. Interaction layer

Receives natural-language goals and converts them into explicit work intent. It should avoid embedding sensitive context in reusable public instructions.

### 2. Routing / decision layer

Chooses the appropriate agent, workflow, or skill. Routing should follow least privilege: each task receives only the tools and context it needs.

### 3. Execution skills

Reusable procedures contain constraints, inputs, expected outputs, validation steps, and permitted tools. Skills should be small enough to audit and composable enough to reuse.

### 4. Review and approval gates

High-impact actions should cross explicit gates before execution. Examples include publishing, deployment, destructive changes, secret handling, migrations, and writes to protected branches.

### 5. Runtime layer

Actual accounts, tokens, machine paths, private repositories, production services, and personal memory live outside the public architecture repository.

## Architectural properties

- privacy by separation
- least-privilege execution
- explicit handoffs
- observable decisions
- reversible changes by default
- human approval for high-risk actions
- reusable methods independent of one AI vendor
