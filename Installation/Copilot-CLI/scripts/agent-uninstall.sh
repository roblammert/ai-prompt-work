#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<EOF
Usage: $0 [--dry-run|-n] <agent-filename-or-path> [scope]

Arguments:
  <agent-filename-or-path>  Filename (e.g. rob-developer-standard.agent.md) or full path
  [scope]                   "project" to remove from ./Agents, "env" (default) from ~/.config/copilot/agents

Options:
  -n|--dry-run   Show what would be removed but do not delete
EOF
  exit 2
}

DRY_RUN=0
POSITIONAL=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    -n|--dry-run)
      DRY_RUN=1; shift ;;
    -h|--help)
      usage ;;
    --) shift; break ;;
    -* ) echo "Unknown option: $1" >&2; usage ;;
    * ) POSITIONAL+=("$1"); shift ;;
  esac
done
set -- "${POSITIONAL[@]}"

if [ "$#" -lt 1 ]; then usage; fi
NAME="$1"
SCOPE="${2:-env}"

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

if [[ "$NAME" = */* ]]; then
  TARGET_FILE="$NAME"
else
  TARGET_FILE="$TARGET_DIR/$NAME"
fi

if [ ! -f "$TARGET_FILE" ]; then
  echo "Not found: $TARGET_FILE" >&2
  exit 1
fi

if [ "$DRY_RUN" -eq 1 ]; then
  echo "DRY RUN: would remove $TARGET_FILE"
  exit 0
fi

rm -v "$TARGET_FILE"
echo "Removed $TARGET_FILE"
exit 0
