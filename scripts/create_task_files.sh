#!/bin/bash

# Memory Bank Creation Script
# This script sets up the core memory bank files for project documentation

# Ensure we're in the project root
CURRENT_DIR="$(pwd)"
CURSOR_DIR="${CURRENT_DIR}/.cursor"
CURSOR_RULES_DIR="${CURSOR_DIR}/rules"
CURSOR_TASK_DIR="${CURSOR_DIR}/task"

# Create .cursor directories if they don't exist
mkdir -p "$CURSOR_RULES_DIR"
mkdir -p "$CURSOR_TASK_DIR"

# Function to create a file with default content if it doesn't exist
create_file() {
  local filepath="$1"
  local content="$2"

  if [ ! -f "$filepath" ]; then
    echo "$content" >"$filepath"
    echo "Created $filepath"
  else
    echo "$filepath already exists. Skipping."
  fi
}

# Create core memory bank files with initial templates

# 1. Project Brief
create_file "$CURSOR_TASK_DIR/plan.md" ""

# 6. Progress Tracking
create_file "$CURSOR_TASK_DIR/progress.md" ""
