#!/bin/bash

# Memory Bank Creation Script
# This script sets up the core memory bank files for project documentation

# Ensure we're in the project root
CURRENT_DIR="$(pwd)"
MEMORY_BANK_DIR="${CURRENT_DIR}/memory-bank"
CURSOR_DIR="${CURRENT_DIR}/.cursor"

# Create memory-bank and .cursor directories if they don't exist
mkdir -p "$MEMORY_BANK_DIR"
mkdir -p "$CURSOR_DIR/rules"

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
create_file "$MEMORY_BANK_DIR/projectbrief.md" "# Project Brief

## Project Overview


## Core Requirements
- 

## Key Objectives
- 

## Constraints
- 
"

# 2. Product Context
create_file "$MEMORY_BANK_DIR/productContext.md" "# Product Context

## Problem Statement


## User Experience Goals
- 

## Key Features
- 
"

# 3. Active Context
create_file "$MEMORY_BANK_DIR/activeContext.md" "# Active Context

## Current Work Focus
- 

## Recent Changes
- 

## Next Steps
- 

## Active Decisions and Considerations
- 
"

# 4. System Patterns
create_file "$MEMORY_BANK_DIR/systemPatterns.md" "# System Patterns

## Architecture Overview
- 

## Design Patterns
- 

## Component Relationships
- 
"

# 5. Technical Context
create_file "$MEMORY_BANK_DIR/techContext.md" "# Technical Context

## Technologies Used
- 

## Development Setup
- 

## Technical Constraints
- 

## Dependencies
- 
"

# 6. Progress Tracking
create_file "$MEMORY_BANK_DIR/progress.md" "# Project Progress

## Completed
- 

## In Progress
- 

## Pending
- 

## Known Issues
- 
"

# Create projectRules.md in .cursor directory
create_file "$CURSOR_DIR/projectRules.md" "# Project Rules

## Project Patterns and Insights

### Critical Implementation Paths
- 

### User Preferences and Workflow
- 

### Project-Specific Patterns
- 

### Known Challenges
- 

### Decision Evolution
- 

### Tool Usage Patterns
- 
"

# Create project.mdc rule file
create_file "$CURSOR_DIR/rules/project.mdc" "---
description: Project Rules
globs: *
---
[projectRules.md](mdc:.cursor/projectRules.md)
"

echo "Memory Bank and Project Rules initialization complete."
