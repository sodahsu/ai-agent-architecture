# AI Agent Architecture

A privacy-safe reference architecture and methodology for designing multi-agent AI workspaces.

This repository focuses on **how the system is designed** rather than exposing any person's actual AI memory, accounts, machines, repositories, credentials, or private operating context.

## What this repository explains

- How to separate private memory from public architecture
- How agents, skills, workflows, and governance fit together
- How to route work across multiple AI agents without giving every agent every permission
- How to use explicit handoffs, review gates, and human approval boundaries
- How to evaluate new skills and tools before promoting them into a stable workflow
- How to separate synchronous interaction, asynchronous execution, knowledge, experimentation, publishing, and portfolio surfaces

## Reference architecture

```text
                     Public methodology
                            │
        ┌───────────────────┼───────────────────┐
        │                   │                   │
        ▼                   ▼                   ▼
   Architecture         Methodology         Examples
        │                   │                   │
        └───────────────────┼───────────────────┘
                            ▼
                       Governance
                            │
             ┌──────────────┴──────────────┐
             ▼                             ▼
       Public-safe layer              Private runtime
       docs / templates              memory / secrets
       examples / diagrams           accounts / paths
```

## Repository structure

```text
docs/
├── architecture/
│   └── system-overview.md
├── methodology/
│   └── agent-workflow.md
└── governance/
    └── public-private-boundary.md

examples/
└── README.md

templates/
└── workspace.example.yaml

PRIVACY.md
README.md
```

## Core principle

> Publish the method, not the private brain.

Public material should describe reusable decisions, patterns, contracts, boundaries, and examples. Private runtime data must remain outside this repository.

## Privacy rule

Never commit:

- personal memory or conversation history
- real email addresses, phone numbers, names, or account identifiers
- API keys, tokens, cookies, passwords, or secrets
- private repository names or internal URLs
- employer, client, or confidential project information
- local absolute paths, hostnames, IP addresses, or device identifiers
- production integration configuration

See [PRIVACY.md](PRIVACY.md) before adding new content.

## Status

This project is being developed as a public reference architecture. The first milestone is to establish the architecture, methodology, governance boundary, and privacy-safe examples before adding executable tooling.
