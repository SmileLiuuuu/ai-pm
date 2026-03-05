#!/usr/bin/env bash

set -e

REPO_URL="https://github.com/SmileLiuuuu/ai-pm.git"
echo "🌱 AI Product Manager installer"
echo "Repository: $REPO_URL"
echo

# Detect host (Cursor vs Claude Code)
TARGET_DIR=""

if [ -d "$HOME/.cursor" ]; then
  TARGET_DIR="$HOME/.cursor/skills/ai_pm"
  PARENT_DIR="$HOME/.cursor/skills"
  echo "Detected Cursor environment."
elif [ -d "$HOME/.claude" ]; then
  TARGET_DIR="$HOME/.claude/skills/ai-pm"
  PARENT_DIR="$HOME/.claude/skills"
  echo "Detected Claude Code environment."
else
  echo "❌ Could not detect Cursor or Claude Code environment."
  echo "Please create either ~/.cursor or ~/.claude first and re-run."
  exit 1
fi

mkdir -p "$PARENT_DIR"

echo "Target install directory: $TARGET_DIR"
echo

if [ -d "$TARGET_DIR/.git" ]; then
  echo "🔍 Existing git installation detected. Checking for updates..."
  cd "$TARGET_DIR"

  CURRENT_REMOTE=$(git remote get-url origin 2>/dev/null || echo "")
  if [ "$CURRENT_REMOTE" != "$REPO_URL" ]; then
    echo "⚠️ Existing git repo origin does not match $REPO_URL"
    BACKUP_DIR="${TARGET_DIR}_backup_$(date +%Y%m%d%H%M%S)"
    echo "Backing up current directory to: $BACKUP_DIR"
    cd ..
    mv "$TARGET_DIR" "$BACKUP_DIR"
    echo "Cloning fresh copy..."
    git clone "$REPO_URL" "$TARGET_DIR"
  else
    echo "Fetching latest changes from origin..."
    git fetch origin main
    LOCAL_HASH=$(git rev-parse HEAD)
    REMOTE_HASH=$(git rev-parse origin/main)

    if [ "$LOCAL_HASH" = "$REMOTE_HASH" ]; then
      echo "✅ Already up to date. No update needed."
    else
      echo "⬆️ Updates available. Pulling latest version..."
      git pull origin main
      echo "✅ Updated to latest version."
    fi
  fi
elif [ -d "$TARGET_DIR" ]; then
  echo "⚠️ Directory exists but is not a git repo."
  BACKUP_DIR="${TARGET_DIR}_backup_$(date +%Y%m%d%H%M%S)"
  echo "Backing up current directory to: $BACKUP_DIR"
  mv "$TARGET_DIR" "$BACKUP_DIR"
  echo "Cloning fresh copy..."
  git clone "$REPO_URL" "$TARGET_DIR"
else
  echo "🚀 Fresh install..."
  git clone "$REPO_URL" "$TARGET_DIR"
fi

echo
echo "✨ Done."
echo "If you are using Cursor, restart it and the 'AI Product Manager' skill will be available from ~/.cursor/skills/ai_pm."
echo "If you are using Claude Code, restart it and the skill will be available from ~/.claude/skills/ai-pm."

