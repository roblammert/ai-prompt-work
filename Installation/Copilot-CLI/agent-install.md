# Copilot-CLI — Agent installation

Overview

This document explains how to install a local agent for use with a Copilot-style CLI (example: @githubnext/copilot-cli). The steps are generic — adjust paths and CLI names for your environment.

Prerequisites

- `git` installed
- Copilot CLI installed (example installation shown below)
- A local copy of the agent file (e.g., `rob-developer-standard.agent.md`) available in your repo under `Agents/`

Install steps

1. Install (or confirm) the Copilot CLI is installed (example using npm):

```bash
npm install -g @githubnext/copilot-cli
# or your platform's install method
```

2. Create an agents directory for the Copilot CLI (example):

```bash
mkdir -p "$HOME/.config/copilot/agents"
```

3. Copy the agent file into the Copilot CLI agents directory (adjust source path as needed):

```bash
cp Agents/Programming/rob-developer-standard.agent.md "$HOME/.config/copilot/agents/"
```

4. (Optional) Set an env var so your shell/IDE points to the agents folder:

```bash
export COPILOT_AGENTS_DIR="$HOME/.config/copilot/agents"
# Add to ~/.bashrc or ~/.profile to persist
```

5. Restart or reload the Copilot CLI / shell so the new env var and files are picked up.

Verification

- Confirm the CLI recognizes the agent. Example (CLI subcommands vary by implementation):

```bash
copilot agents list
# or
copilot --list-agents
```

- Alternatively, run a simple Copilot CLI chat command referencing the agent name (CLI-specific).

Troubleshooting

- If the agent isn't found, double-check the target directory and file permissions.
- Ensure the Copilot CLI version supports custom agents or local prompts.
- If your CLI uses a different agent directory, set the correct env var or move the file accordingly.

Notes

- Replace example commands with your environment's package manager and CLI names if different.
- Keep sensitive information out of agent files.

Install via script (optional)

You can use the provided installer and uninstaller scripts to manage agents. Scripts are located in `Installation/Copilot-CLI/scripts/`.

Shell example — environment-wide (with checksum/idempotency):

```bash
Installation/Copilot-CLI/scripts/agent-install.sh Agents/Programming/rob-developer-standard.agent.md env
```

Shell example — project-scoped:

```bash
Installation/Copilot-CLI/scripts/agent-install.sh Agents/Programming/rob-developer-standard.agent.md project
```

Shell example — dry run (no changes):

```bash
Installation/Copilot-CLI/scripts/agent-install.sh --dry-run Agents/Programming/rob-developer-standard.agent.md env
```

Shell example — force overwrite (no backup):

```bash
Installation/Copilot-CLI/scripts/agent-install.sh --force Agents/Programming/rob-developer-standard.agent.md env
```

PowerShell example — environment-wide:

```powershell
.\Installation\Copilot-CLI\scripts\agent-install.ps1 -SourcePath Agents/Programming/rob-developer-standard.agent.md -Scope env
```

PowerShell example — dry run:

```powershell
.\Installation\Copilot-CLI\scripts\agent-install.ps1 -SourcePath Agents/Programming/rob-developer-standard.agent.md -Scope env -DryRun
```

Uninstall examples:

```bash
Installation/Copilot-CLI/scripts/agent-uninstall.sh rob-developer-standard.agent.md env
```

```powershell
.\Installation\Copilot-CLI\scripts\agent-uninstall.ps1 -NameOrPath rob-developer-standard.agent.md -Scope env
```

Notes about the scripts:

- The scripts accept a source path and an optional scope (`project` or `env`).
- The shell scripts support `--dry-run` and `--force`. PowerShell versions support `-DryRun` and `-Force`.
- On overwrite (without `--force`), the installer creates a timestamped `.bak` backup of the existing file.
- Installers compare SHA-256 checksums and skip copying when the source and target are identical (idempotent).
- Uninstall scripts support `--dry-run` to preview removals.
- Ensure shell scripts are executable (`chmod +x`) before running.
