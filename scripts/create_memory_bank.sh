#!/bin/bash

# Memory Bank Creation Script
# This script sets up the core memory bank files for project documentation

# Ensure we're in the project root
CURRENT_DIR="$(pwd)"
MEMORY_BANK_DIR="${CURRENT_DIR}/memory-bank"

# Create memory-bank directory if it doesn't exist
mkdir -p "$MEMORY_BANK_DIR"

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

echo "Memory Bank initialization complete."
