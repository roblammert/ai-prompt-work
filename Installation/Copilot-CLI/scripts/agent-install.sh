#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<EOF
Usage: $0 [--dry-run|-n] [--force|-f] <agent-markdown-path> [scope]

Arguments:
  <agent-markdown-path>  Path to the agent markdown file to install
  [scope]                "project" to install into the project (./Agents)
                         "env" (default) to install environment-wide (~/.config/copilot/agents)

Options:
  -n|--dry-run   Show what would be done but don't copy files
  -f|--force     Overwrite target without creating a backup

Example:
  $0 Agents/Programming/rob-developer-standard.agent.md project
  $0 --dry-run Agents/Programming/rob-developer-standard.agent.md env
EOF
  exit 2
}

DRY_RUN=0
FORCE=0
POSITIONAL=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    -n|--dry-run)
      DRY_RUN=1; shift ;;
    -f|--force)
      FORCE=1; shift ;;
    -h|--help)
      usage ;;
    --) shift; break ;;
    -* ) echo "Unknown option: $1" >&2; usage ;;
    * ) POSITIONAL+=("$1"); shift ;;
  esac
done
set -- "${POSITIONAL[@]}"

if [ "$#" -lt 1 ]; then usage; fi
SRC="$(realpath "$1")"
SCOPE="${2:-env}"

if [ ! -f "$SRC" ]; then
  echo "Source file not found: $SRC" >&2
  exit 3
fi

case "$SCOPE" in
  project)
    TARGET_DIR="$(pwd)/Agents"
    ;;
  env)
    TARGET_DIR="$HOME/.config/copilot/agents"
    ;;
  *)
    echo "Invalid scope: $SCOPE" >&2
    usage
    ;;
esac

TARGET_FILE="$TARGET_DIR/$(basename "$SRC")"

mkdir -p "$TARGET_DIR"

if [ -f "$TARGET_FILE" ]; then
  SRC_SUM=$(sha256sum "$SRC" | awk '{print $1}')
  TGT_SUM=$(sha256sum "$TARGET_FILE" | awk '{print $1}') || true
  if [ "$SRC_SUM" = "$TGT_SUM" ]; then
    echo "Target exists and is identical; nothing to do: $TARGET_FILE"
    exit 0
  fi
  if [ "$DRY_RUN" -eq 1 ]; then
    echo "DRY RUN: would replace $TARGET_FILE (existing file differs)"
    exit 0
  fi
  if [ "$FORCE" -ne 1 ]; then
    BACKUP="$TARGET_FILE.$(date -u +%Y%m%dT%H%M%SZ).bak"
    echo "Backing up existing file to: $BACKUP"
    cp -v "$TARGET_FILE" "$BACKUP"
  fi
fi

if [ "$DRY_RUN" -eq 1 ]; then
  echo "DRY RUN: would copy $SRC -> $TARGET_DIR/"
  exit 0
fi

cp -v "$SRC" "$TARGET_DIR/"
chmod 644 "$TARGET_FILE"

echo "Installed $(basename "$SRC") -> $TARGET_DIR"
exit 0
