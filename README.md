Agent installation scripts and docs

Summary of changes (2026-04-05):

- Added installation and uninstallation documentation and scripts for three agent targets:
  - Copilot-CLI
  - Gemini-CLI
  - VS Code (user prompts)

- Files added/updated:
  - Installation/Copilot-CLI/agent-install.md (docs updated)
  - Installation/Gemini-CLI/agent-install.md (docs updated)
  - Installation/VS Code/agent-install.md (docs updated)

  - Installation/Copilot-CLI/scripts/agent-install.sh (installer; dry-run, force, checksum, backup)
  - Installation/Copilot-CLI/scripts/agent-install.ps1 (PowerShell installer; DryRun/Force, checksum, backup)
  - Installation/Copilot-CLI/scripts/agent-uninstall.sh (uninstaller; dry-run)
  - Installation/Copilot-CLI/scripts/agent-uninstall.ps1 (PowerShell uninstaller)

  - Installation/Gemini-CLI/scripts/agent-install.sh (installer; dry-run, force, checksum, backup)
  - Installation/Gemini-CLI/scripts/agent-install.ps1 (PowerShell installer; DryRun/Force, checksum, backup)
  - Installation/Gemini-CLI/scripts/agent-uninstall.sh (uninstaller; dry-run)
  - Installation/Gemini-CLI/scripts/agent-uninstall.ps1 (PowerShell uninstaller)

  - Installation/VS Code/scripts/agent-install.sh (installer; dry-run, force, checksum, backup)
  - Installation/VS Code/scripts/agent-install.ps1 (PowerShell installer; DryRun/Force, checksum, backup)
  - Installation/VS Code/scripts/agent-uninstall.sh (uninstaller; dry-run)
  - Installation/VS Code/scripts/agent-uninstall.ps1 (PowerShell uninstaller)

Notes:
- Installers are idempotent (skip copy if identical), back up existing files with a timestamped .bak, and support dry-run.
- Shell scripts are marked executable.
- Documentation references the `Installation/` folder and shows script usage examples.

Recommended next steps:
- Add a minimal sample agent file under `Agents/` for smoke tests.
- Add a small test script in `/tests` to validate install/uninstall flows.

If you'd like, I can commit these changes now and push to the current branch.
