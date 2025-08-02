#!/usr/bin/env bash
set -euo pipefail

remote=agent-os-upstream
branch=main
prefix=templates/base/_upstream

git fetch $remote $branch
git subtree pull --prefix="$prefix" $remote $branch --squash

# Propagate files to each template flavour
for t in base python typescript; do
  rm -rf templates/$t/.agent-os templates/$t/.github/copilot
  cp -R "$prefix/.agent-os"          "templates/$t/"
  cp -R "$prefix/.github/copilot"    "templates/$t/.github/"
done

rm -rf "$prefix"
git add templates
echo "Synced Agent‑OS upstream at $(date)"
