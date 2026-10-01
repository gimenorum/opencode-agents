# OpenCode Agents

This repository provides a shared OpenCode configuration and a small set of reusable sub-agent definitions that can be installed into a project with a single script.

## What this repository contains

- `opencode.jsonc`: project-level OpenCode configuration
- `setup.sh`: installs the shared configuration into the target project directory
- `.opencode/agents/*.md`: sub-agent prompts for exploration, scouting, review, implementation, and fallback design work

## Purpose

This repository provides a reusable template for sharing OpenCode settings and sub-agent prompts across projects.

## Installation

### macOS / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/gimenorum/opencode-agents/main/setup.sh | bash
```

To install into a specific directory

```bash
curl -fsSL <URL> | bash -s <YourDirectory>
```

### Windows

### powershell

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "$script = (Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/gimenorum/opencode-agents/main/setup.ps1').Content; & ([scriptblock]::Create($script))"
```

To install into a specific directory

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "$script = (Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/gimenorum/opencode-agents/main/setup.ps1').Content; & ([scriptblock]::Create($script)) -Destination '<YourDirectory>'"
```

### cmd

```bat
powershell -NoProfile -ExecutionPolicy Bypass -Command "$script = (Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/gimenorum/opencode-agents/main/setup.ps1').Content; & ([scriptblock]::Create($script))"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$script = (Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/gimenorum/opencode-agents/main/setup.ps1').Content; & ([scriptblock]::Create($script)) -Destination '<YourDirectory>'"
```

The script downloads the files listed in `FILES` and copies them into the destination directory, overwriting files with the same names while leaving unrelated files untouched.

## Included agents

- `explore`: codebase exploration and structure understanding
- `scout`: external docs and dependency research
- `review`: code review focused on security, performance, maintainability, and edge cases
- `general`: general multi-step implementation work
- `design-fallback`: fallback design-only behavior when a quota-limited model is unavailable

## License

This project is licensed under the MIT License.

See [LICENSE](LICENSE) for the full text.
