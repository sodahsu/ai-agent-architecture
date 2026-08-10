# Public / Private Boundary

## Objective

Make the public repository useful without making private runtime context reconstructable.

## Classification model

| Class | Examples | Public? |
|---|---|---|
| Method | architecture patterns, decision rules, review gates | Yes |
| Template | synthetic configs, generic contracts, placeholders | Yes |
| Public evidence | public docs, public repositories, published case studies | Yes |
| Personal context | memory, preferences, conversations, private notes | No |
| Operational identity | usernames, machine paths, account IDs, private repo names | No |
| Secrets | tokens, cookies, keys, passwords, webhook secrets | Never |
| Confidential work | employer/client/project internals | No |

## Promotion rule

Content may move from a private workspace into this repository only through **manual distillation**.

```text
private source
    ↓
extract reusable lesson
    ↓
remove identity and operational details
    ↓
replace real values with synthetic examples
    ↓
review privacy + confidentiality
    ↓
publish method
```

Raw synchronization across the boundary is not allowed.

## Agent rule

An AI agent preparing public content should receive only the minimum private context needed to derive the reusable lesson. The final artifact must stand on its own without relying on private identifiers.

## High-risk signals

Stop and review when content contains:

- `@` addresses or account-like identifiers
- filesystem roots such as `/Users/`, `/home/`, drive letters, or network shares
- token/key/secret/password/cookie vocabulary next to concrete values
- internal hostnames, IP addresses, webhook endpoints, or private URLs
- names of employers, clients, private projects, or private repositories
- pasted logs, screenshots, stack traces, or configuration dumps

These signals do not prove a leak, but they require inspection before merge.

## Merge gate

A public change is ready to merge only when:

- the method remains understandable after anonymization
- examples are synthetic
- no credential or operational identifier is present
- no private dependency is required to understand the documentation
- links point only to intentionally public resources
