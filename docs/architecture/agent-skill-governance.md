# Agent / Skill / Governance Model

A multi-agent system becomes easier to reason about when three concerns are separated:

- **Agents decide and coordinate.**
- **Skills define repeatable execution procedures.**
- **Governance constrains what both are allowed to do.**

Governance is not a fourth execution layer. It is a cross-cutting control plane that limits routing, permissions, mutation, validation, and approval.

## Model

```mermaid
flowchart TB
    G[Governance control plane\npermissions · risk · approval · validation]

    subgraph DECISION[Decision layer]
        A1[Router / Coordinator]
        A2[Specialist Agent]
        A3[Reviewer Agent]
    end

    subgraph EXECUTION[Execution layer]
        S1[Skill: inspect]
        S2[Skill: implement]
        S3[Skill: test]
        S4[Skill: handoff]
    end

    T[Tools / APIs / Files / Repositories]

    A1 --> A2
    A2 --> S1
    A2 --> S2
    A3 --> S3
    A3 --> S4
    S1 --> T
    S2 --> T
    S3 --> T
    S4 --> T

    G -. constrains .-> A1
    G -. constrains .-> A2
    G -. constrains .-> A3
    G -. constrains .-> S1
    G -. constrains .-> S2
    G -. constrains .-> S3
    G -. constrains .-> S4
    G -. constrains .-> T
```

## Responsibility boundaries

### Agent

An agent owns judgment within a bounded responsibility.

Typical responsibilities:

- interpret the current goal
- choose a workflow or skill
- split work into assignments
- decide when evidence is sufficient
- escalate ambiguity or risk

An agent should **not** duplicate detailed procedural rules already owned by a skill.

### Skill

A skill is a reusable execution contract.

A useful skill definition includes:

```yaml
name: example-review
inputs:
  - target
  - acceptance_criteria
outputs:
  - findings
  - evidence
preconditions:
  - target_is_readable
permissions:
  - read
validation:
  - evidence_required
```

The skill should define the repeatable procedure, expected artifacts, failure conditions, and tool boundary.

### Governance

Governance determines whether an otherwise valid action is permitted.

Examples:

- protected branches cannot be written directly
- secrets cannot be copied into prompts or public artifacts
- external skills must be evaluated before promotion
- production deployment requires human approval
- destructive actions require explicit authorization
- validation evidence is required before completion

## Decision precedence

When rules conflict, use an explicit precedence model:

```text
Security / privacy boundary
        ↓
Governance policy
        ↓
Task-specific constraints
        ↓
Skill contract
        ↓
Agent discretion
        ↓
Model preference
```

Higher layers narrow lower layers. An agent cannot override a security boundary because it believes another path is more efficient.

## Least-context and least-privilege assignment

Each subtask should receive:

1. only the context needed to make the decision,
2. only the tools needed to perform the procedure,
3. only the write scope needed for the output,
4. explicit completion criteria.

Example:

```yaml
assignment:
  objective: "Review example component accessibility"
  context:
    - "component source"
    - "acceptance criteria"
  tools:
    - "read files"
    - "run accessibility tests"
  writes:
    - "none"
  complete_when:
    - "findings include evidence and severity"
```

A later implementation assignment may receive write permission, but the reviewer does not need it.

## Promotion lifecycle

Capabilities should move through states instead of appearing directly in the stable agent environment.

```mermaid
flowchart LR
    I[Candidate] --> R[Research]
    R --> T[Test]
    T --> D{Decision}
    D -->|reject| X[Rejected / archived]
    D -->|adapt| A[Adapted pattern]
    D -->|adopt| S[Stable skill]
    A --> G[Governed production use]
    S --> G
```

This makes the system explainable: stable behavior exists because it passed an explicit evaluation and promotion decision.
