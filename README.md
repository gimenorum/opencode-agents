# OpenCode Agents

This repository provides a shared OpenCode configuration and a small set of reusable sub-agent definitions that can be installed into a project with a single script.

## What this repository contains

- `opencode.jsonc`: project-level OpenCode configuration
- `setup.sh`: installs the shared configuration into the target project directory
- `.opencode/agents/*.md`: sub-agent prompts for exploration, scouting, review, implementation, and fallback design work

## Purpose

The repository is intended to standardize OpenCode setup across multiple projects. Instead of copying the same configuration manually, you can run the installer script and apply the same agent setup to any project directory.

## Installation

From any project directory:

```bash
curl -fsSL https://raw.githubusercontent.com/gimenorum/opencode-agents/main/setup.sh | bash
```

To install into a specific directory:

```bash
curl -fsSL <URL> | bash -s ~/path/to/project
```

The script downloads the files listed in `FILES` and copies them into the destination directory, overwriting files with the same names while leaving unrelated files untouched.

## Included agents

- `explore`: codebase exploration and structure understanding
- `scout`: external docs and dependency research
- `review`: code review focused on security, performance, maintainability, and edge cases
- `general`: general multi-step implementation work
- `design-fallback`: fallback design-only behavior when a quota-limited model is unavailable

## Notes

- The configuration uses OpenCode as the execution environment.
- The installer is intentionally conservative: it fetches all files first and only installs them if all downloads succeed.
- If a background OpenCode service is already running, restart it after installation if needed.

## License

This project is licensed under the MIT License.

See [LICENSE](LICENSE) for the full text.
