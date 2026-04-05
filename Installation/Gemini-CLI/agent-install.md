# Gemini-CLI — Agent installation

Overview

This document describes how to install a local agent for a Gemini-style CLI. Steps are intentionally generic — adapt to the concrete Gemini CLI implementation you use.

Prerequisites

- `git` installed
- Gemini CLI installed (use your vendor's install instructions)
- Local agent file in the repository (e.g., `Agents/Programming/rob-developer-standard.agent.md`)

Install steps

1. Install the Gemini CLI (example placeholder — use the official installer):

```bash
# Example placeholder — replace with real install command
# curl -sSL https://example.com/gemini/install.sh | bash
```

2. Create a local agents directory for Gemini:

```bash
mkdir -p "$HOME/.config/gemini/agents"
```

3. Copy the agent file into the Gemini agents directory:

```bash
cp Agents/Programming/rob-developer-standard.agent.md "$HOME/.config/gemini/agents/"
```

4. (Optional) Set environment variable for the agents directory:

```bash
export GEMINI_AGENTS_DIR="$HOME/.config/gemini/agents"
# add to ~/.bashrc to persist
```

5. Restart the CLI or reload your shell.

Verification

- List available agents (CLI-specific). Example placeholder:

```bash
gemini agents list
# or
gemini --list-agents
```

- Run a simple command that uses the new agent to ensure it behaves as expected.

Troubleshooting

- If the CLI doesn't show the agent, confirm the directory path and permissions.
- Consult the Gemini CLI docs for the exact agent-folder location or config keys.

Notes

- The exact install commands depend on the Gemini CLI distribution. Replace placeholder commands with your vendor's instructions.

Install via script (optional)

Use the installer and uninstaller scripts in `Installation/Gemini-CLI/scripts/` to copy or remove an agent in the project or environment location.

Shell example — environment-wide (default):

```bash
Installation/Gemini-CLI/scripts/agent-install.sh Agents/Programming/rob-developer-standard.agent.md env
```

Shell example — project-scoped:

```bash
Installation/Gemini-CLI/scripts/agent-install.sh Agents/Programming/rob-developer-standard.agent.md project
```

Shell example — dry run:

```bash
Installation/Gemini-CLI/scripts/agent-install.sh --dry-run Agents/Programming/rob-developer-standard.agent.md env
```

PowerShell example — environment-wide:

```powershell
.\Installation\Gemini-CLI\scripts\agent-install.ps1 -SourcePath Agents/Programming/rob-developer-standard.agent.md -Scope env
```

Uninstall examples:

```bash
Installation/Gemini-CLI/scripts/agent-uninstall.sh rob-developer-standard.agent.md env
```

```powershell
.\Installation\Gemini-CLI\scripts\agent-uninstall.ps1 -NameOrPath rob-developer-standard.agent.md -Scope env
```

Notes about the scripts:

- The scripts accept a source path and an optional scope (`project` or `env`).
- Installers support `--dry-run` (`-n`) and `--force` (`-f`) for shell, and `-DryRun`/`-Force` for PowerShell.
- Installers compare SHA-256 checksums and skip copying when the source and target are identical.
- On overwrite (without `--force`), the installer creates a timestamped `.bak` backup of the existing file.
