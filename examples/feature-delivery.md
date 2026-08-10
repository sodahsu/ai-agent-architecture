# Synthetic Example: Feature Delivery

This example is intentionally fictional. It demonstrates the architecture without using any real person, employer, client, repository, account, or production system.

## Scenario

An example product team wants to improve the empty state of a dashboard.

Constraints:

- no authentication changes
- no production deployment
- existing component API must remain compatible
- changes must be reviewable before merge
- the reviewer must not receive write permission

## Step 1 — Intent

The operator provides a goal rather than a long implementation prompt:

```text
Improve the example dashboard empty state so first-time users understand what to do next.
```

The control layer turns this into an explicit assignment contract.

```yaml
objective: "Improve the dashboard empty state"
scope:
  include:
    - "empty-state component"
    - "related tests"
  exclude:
    - "authentication"
    - "billing"
    - "deployment"
acceptance_criteria:
  - "primary next action is visible"
  - "keyboard interaction still works"
  - "existing public component API is unchanged"
mutation_policy:
  - "feature branch only"
  - "no direct main write"
```

## Step 2 — Context retrieval

The Knowledge role returns only approved task context.

```yaml
context_contract:
  product_rule: "New users should see one primary next action"
  design_rule: "Use existing system components before adding new variants"
  technical_rule: "Keep the public component API stable"
```

It does **not** export unrelated notes, personal history, credentials, or full memory.

## Step 3 — Routing

The coordinator selects three assignments:

```text
A. Inspect current implementation        read-only
B. Implement bounded change              branch write
C. Review acceptance criteria            read-only
```

Each assignment gets different permissions.

## Step 4 — Execution

The implementation agent invokes stable skills rather than inventing a process from scratch.

```text
inspect-component
      ↓
plan-minimal-change
      ↓
implement-feature
      ↓
run-tests
      ↓
prepare-handoff
```

If a required capability is unknown, it is first sent to the Evaluation role. An unreviewed external tool is not silently installed into the stable environment.

## Step 5 — Validation

The executor returns evidence:

```yaml
result:
  status: "implemented"
  changed_scope:
    - "empty-state component"
    - "component tests"
  validation:
    unit_tests: "pass"
    accessibility_check: "pass"
    api_compatibility: "unchanged"
  mutation:
    branch: "feature/example-empty-state"
    main_modified: false
```

The reviewer independently compares the result with the original acceptance criteria.

## Step 6 — Approval gate

Because merge is a higher-risk mutation than editing a feature branch, the workflow stops at a reviewable artifact.

```text
implementation
    ↓
validation
    ↓
draft change / review artifact
    ↓
HUMAN APPROVAL
    ↓
merge decision
```

The executor's ability to create a valid change does not imply authority to merge or deploy it.

## Step 7 — Public distillation

The private implementation is not copied into the public architecture repository.

Instead, a reusable lesson may be distilled as:

> Separate inspection, implementation, and review assignments so each agent receives only the context and permissions required by its role.

That lesson can become documentation, a template, or a synthetic example like this one.

## What this example demonstrates

- intent is converted into explicit scope and acceptance criteria
- private context is reduced to a minimal context contract
- different agents receive different permissions
- stable skills own repeatable procedures
- governance limits mutation even when execution succeeds
- validation evidence travels with the result
- public documentation contains the method, not the original private work
