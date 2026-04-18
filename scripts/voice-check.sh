#!/usr/bin/env bash
# voice-check.sh — Studio B family voice contract guard
#
# Greps changed .html + .md files for banned SaaS-voice words per
# the family voice contract (memory://feedback_studio-b-voice.md).
# Exits non-zero if any banned word appears in added lines — blocks
# the PR. Runs locally (diff against main) or in CI (diff against the
# PR base).
#
# Usage:
#   scripts/voice-check.sh                # default: diff vs. origin/main
#   scripts/voice-check.sh main           # diff vs. another base ref
#
# The banned list is Rule 2 of the voice contract. Update here AND
# in memory/feedback_studio-b-voice.md if the list changes.

set -euo pipefail

BASE="${1:-origin/main}"

# Rule 2 banned words — case-insensitive match.
# Add to this list here AND in feedback_studio-b-voice.md as a pair.
BANNED=(
  seamless
  intuitive
  "best-in-class"
  "enterprise-grade"
  comprehensive
  "cutting-edge"
  revolutionary
  "game-changing"
  synergy
  leverage
  paradigm
  disrupt
  "AI-powered"
  "end-user"
)

# Build the regex once
PATTERN="$(printf '%s|' "${BANNED[@]}" | sed 's/|$//')"

# Fetch the base ref quietly so diffs work even on fresh shallow clones.
git fetch --quiet --depth=50 origin "$(echo "$BASE" | sed 's|^origin/||')" 2>/dev/null || true

# Files changed in the PR, filtered to content we care about.
CHANGED="$(git diff --name-only --diff-filter=AM "$BASE"...HEAD -- '*.html' '*.md' 2>/dev/null || true)"

if [ -z "$CHANGED" ]; then
  echo "voice-check: no HTML/MD changes vs. $BASE — nothing to scan."
  exit 0
fi

echo "voice-check: scanning changed files vs. $BASE"
echo "$CHANGED" | sed 's/^/  /'
echo

# Scan only added lines (prefix '+' in unified diff), skipping diff headers.
HITS="$(git diff --unified=0 "$BASE"...HEAD -- '*.html' '*.md' \
  | grep -E '^\+' \
  | grep -viE '^\+\+\+' \
  | grep -iE "($PATTERN)" \
  || true)"

if [ -n "$HITS" ]; then
  echo "❌ voice-check FAILED — banned SaaS-voice words in added content:"
  echo
  echo "$HITS" | sed 's/^/  /'
  echo
  echo "Per the Studio B voice contract (memory://feedback_studio-b-voice.md, Rule 2),"
  echo "rewrite without: ${BANNED[*]}"
  exit 1
fi

echo "✓ voice-check passed — no banned words in added content."
