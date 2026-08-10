# Privacy Policy for Public Content

This repository is public. Every committed file must be safe to expose permanently.

## Allowed

- generalized architecture patterns
- reusable methodology
- anonymized workflow diagrams
- generic examples and templates
- synthetic sample data
- public documentation links

## Forbidden

Do not commit any of the following:

- personal memory, notes, journals, conversation history, or private prompts
- real names, personal email addresses, phone numbers, addresses, account IDs, or usernames
- employer, client, internal project, or confidential business information
- private repository names, private issue or PR links, internal domains, or non-public URLs
- API keys, OAuth tokens, PATs, cookies, credentials, secrets, webhook secrets, or environment values
- local absolute paths, device names, hostnames, IP addresses, SSH configuration, or machine-specific identifiers
- production deployment configuration that exposes infrastructure details
- raw logs or screenshots that may contain any of the above

## Example policy

Prefer placeholders:

```text
<workspace>
<private-memory-store>
<runtime-agent>
<example-repository>
user@example.com
```

Do not replace them with real local values in committed files.

## Pre-commit review

Before publishing a change, verify:

1. Can this content identify a real person, employer, client, account, machine, or private project?
2. Does it reveal where private data is stored or how to access it?
3. Does it contain a real credential, secret name paired with an operational value, or production endpoint?
4. Can the example be rewritten with synthetic placeholders without losing the lesson?

If any answer creates unnecessary exposure, generalize or remove the content before merging.

## Design rule

**Publish reusable knowledge. Keep operational identity and private context outside the public repository.**
