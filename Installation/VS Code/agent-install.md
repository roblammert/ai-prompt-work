# VS Code — Agent installation (User prompts)

Overview

This guide shows how to install a local agent/prompt file for VS Code-based AI assistant integrations that support custom user prompts. The snippets use the standard VS Code user prompts folder.

Prerequisites

- Visual Studio Code installed
- The AI assistant extension that supports custom prompts (e.g., GitHub Copilot Chat or other) installed and enabled
- A local copy of the agent file in your repo (e.g., `Agents/Programming/rob-developer-standard.agent.md`)

Target prompts folder (example for this user)

The local VS Code prompts folder on this machine is:

/home/roblammert/.config/Code/User/prompts

Install steps

1. Create a folder for agents inside the VS Code prompts folder:

```bash
mkdir -p "/home/roblammert/.config/Code/User/prompts/Agents"
```

2. Copy the agent file into the prompts folder for VS Code:

```bash
cp Agents/Programming/rob-developer-standard.agent.md "/home/roblammert/.config/Code/User/prompts/Agents/rob-developer-standard.agent.md"
```

3. Reload or restart VS Code so the extension picks up new prompts:

```bash
# From terminal
code --reload
# Or restart the editor manually
```

4. In the AI extension UI, confirm the new prompt/agent appears under user prompts and test it by invoking the assistant and selecting the agent.

Verification

- Open the extension's prompts panel and look for the agent under the user prompts section.
- Run a quick test query using the agent to confirm expected behavior.

Troubleshooting

- If the prompt doesn't appear, ensure the file is valid Markdown and the extension supports loading prompts from the user prompts folder.
- Confirm file permissions and that VS Code has access to the prompts folder.

Notes

- Some extensions provide their own prompts folder or require a different structure — consult the extension settings if the agent is not discovered.
- If you prefer a workspace-level setup, place the prompts in a workspace-specific prompts folder if the extension supports it.

Install via script (optional)

Scripts are available in `Installation/VS Code/scripts/` to install or uninstall an agent either to the workspace or environment prompts folder.

Shell example — environment-wide (Linux):

```bash
Installation/VS Code/scripts/agent-install.sh Agents/Programming/rob-developer-standard.agent.md env
```

Shell example — workspace-scoped:

```bash
Installation/VS Code/scripts/agent-install.sh Agents/Programming/rob-developer-standard.agent.md project
```

Shell example — dry run:

```bash
Installation/VS Code/scripts/agent-install.sh --dry-run Agents/Programming/rob-developer-standard.agent.md env
```

PowerShell example — environment-wide (Windows/PowerShell):

```powershell
.\Installation\VS Code\scripts\agent-install.ps1 -SourcePath Agents/Programming/rob-developer-standard.agent.md -Scope env
```

Uninstall examples:

```bash
Installation/VS Code/scripts/agent-uninstall.sh rob-developer-standard.agent.md env
```

```powershell
.\Installation\VS Code\scripts\agent-uninstall.ps1 -NameOrPath rob-developer-standard.agent.md -Scope env
```

Notes about the scripts:

- `project` installs to `./.vscode/prompts/Agents`; `env` installs to `~/.config/Code/User/prompts/Agents` (Linux). Adjust paths on other OSes.
- Installers support `--dry-run` and `--force` (shell) and `-DryRun`/`-Force` (PowerShell).
- Installers compare SHA-256 checksums and skip copying when the source and target are identical.
- On overwrite (without `--force`), the installer creates a timestamped `.bak` backup of the existing file.
- After running an environment install you may need to restart VS Code for the extension to pick up the new prompt files.
