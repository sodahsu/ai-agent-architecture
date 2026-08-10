# Agent Workflow Methodology

## Purpose

Turn ambiguous work into a controlled sequence that multiple AI agents can execute without losing ownership, context, or review responsibility.

## Workflow

```text
Goal
 ↓
Clarify constraints
 ↓
Plan work
 ↓
Assign agent / skill
 ↓
Execute smallest safe unit
 ↓
Validate result
 ↓
Review risk
 ↓
Human approval when required
 ↓
Handoff or complete
```

## Method

### 1. Start from the goal

Capture the intended outcome, constraints, non-goals, and success criteria before choosing tools.

### 2. Separate planning from execution

Planning decides what should change. Execution performs the bounded change. This separation makes review and rollback easier.

### 3. Route by capability and risk

Choose an agent because it has the required capability, not because it has the broadest access. Give it only the context and permissions required for that task.

### 4. Work in small reversible units

Prefer feature branches, drafts, proposed changes, previews, and generated artifacts over direct irreversible writes.

### 5. Validate before handoff

Each unit should define its own verification: tests, lint, build, content checks, policy checks, or structured review.

### 6. Preserve explicit handoff state

A handoff should state:

- what was requested
- what changed
- what was validated
- known risks or unresolved questions
- what the next actor may do

### 7. Require human approval at risk boundaries

Publishing, deployment, destructive actions, credentials, migrations, billing, protected branches, and other high-impact operations should not be inferred as implicitly approved.

## Principle

The purpose of multi-agent collaboration is not maximum autonomy. It is **clear delegation with bounded authority and verifiable return paths**.
