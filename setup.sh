#!/usr/bin/env bash
# Install shared OpenCode settings into a project.
#
#   cd ~/path/to/project
#   curl -fsSL https://raw.githubusercontent.com/gimenorum/opencode-agents/main/setup.sh | bash
#
# The destination is the current working directory. To install into a different directory,
# pass it as the first argument.
#   curl -fsSL <URL> | bash -s ~/path/to/project
#
# Existing files with the same name are always overwritten. Other files already present in the
# destination directory are left untouched.
set -euo pipefail

readonly BASE_URL="https://raw.githubusercontent.com/gimenorum/opencode-agents/main"

# List of files to distribute. Add one entry here whenever a new sub-agent is added.
readonly FILES=(
  "opencode.jsonc"
  ".opencode/agents/explore.md"
  ".opencode/agents/scout.md"
  ".opencode/agents/review.md"
  ".opencode/agents/general.md"
  ".opencode/agents/design-fallback.md"
)

log() { printf '%s\n' "$*"; }
die() { printf 'Error: %s\n' "$*" >&2; exit 1; }

command -v curl >/dev/null 2>&1 || die "curl is required"

dest="${1:-$PWD}"
[ -d "$dest" ] || die "Destination does not exist: $dest"
dest="$(cd "$dest" && pwd)"

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

# Fetch everything first so nothing is installed if any download fails.
for file in "${FILES[@]}"; do
  mkdir -p "$tmp/$(dirname "$file")"
  if ! curl -fsSL "$BASE_URL/$file" -o "$tmp/$file"; then
    die "Failed to fetch: $file"
  fi
  [ -s "$tmp/$file" ] || die "File is empty: $file"
done

log "Target directory: $dest"
for file in "${FILES[@]}"; do
  mkdir -p "$dest/$(dirname "$file")"
  cp "$tmp/$file" "$dest/$file"
  chmod 644 "$dest/$file"
done

log "Setup completed. The configuration is loaded from opencode.jsonc and .opencode/ in the project root."
if command -v opencode >/dev/null 2>&1; then
  log "If you are using an existing background service, run opencode service restart before continuing."
fi
