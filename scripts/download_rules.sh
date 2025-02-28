#!/bin/bash
#
# download_rules.sh - Downloads .cursor/rules and .cursor/task directories from github.com/armedi/cursorrules
#
# Usage: curl https://raw.githubusercontent.com/armedi/cursorrules/refs/heads/main/scripts/download_rules.sh | bash
#

# Error handling
set -e

# Function to display error messages
error_message() {
  echo "Error: $1" >&2
  exit 1
}

# GitHub repository information
REPO_OWNER="armedi"
REPO_NAME="cursorrules"
BRANCH="main"
REPO_URL="https://github.com/${REPO_OWNER}/${REPO_NAME}"
ZIP_URL="${REPO_URL}/archive/refs/heads/${BRANCH}.zip"

# Target directories
RULES_DIR=".cursor/rules"
TASK_DIR=".cursor/task"

# Temporary directory for download
TEMP_DIR=$(mktemp -d)

# Cleanup function to remove temporary directory
cleanup() {
  rm -rf "$TEMP_DIR"
}

# Set trap to ensure cleanup on exit
trap cleanup EXIT

# Create target directories if they don't exist
echo "Checking and creating directories if needed..."
if [ ! -d ".cursor" ]; then
  mkdir -p ".cursor" || error_message "Failed to create .cursor directory"
fi

if [ ! -d "$RULES_DIR" ]; then
  mkdir -p "$RULES_DIR" || error_message "Failed to create $RULES_DIR directory"
fi

if [ ! -d "$TASK_DIR" ]; then
  mkdir -p "$TASK_DIR" || error_message "Failed to create $TASK_DIR directory"
fi

# Download the repository as a zip file
echo "Downloading files from ${REPO_URL}..."
ZIP_FILE="${TEMP_DIR}/repo.zip"

if command -v curl &> /dev/null; then
  if ! curl -L -s --fail "${ZIP_URL}" -o "${ZIP_FILE}"; then
    error_message "Failed to download repository. Please check your internet connection and try again."
  fi
elif command -v wget &> /dev/null; then
  if ! wget -q "${ZIP_URL}" -O "${ZIP_FILE}"; then
    error_message "Failed to download repository. Please check your internet connection and try again."
  fi
else
  error_message "Neither curl nor wget is installed. Please install one of them and try again."
fi

# Check if the download was successful
if [ ! -s "${ZIP_FILE}" ]; then
  error_message "Downloaded file is empty. There might be an issue with the repository URL."
fi

# Extract the zip file
echo "Extracting files..."
EXTRACT_DIR="${TEMP_DIR}/extract"
mkdir -p "${EXTRACT_DIR}"

if command -v unzip &> /dev/null; then
  if ! unzip -q "${ZIP_FILE}" -d "${EXTRACT_DIR}"; then
    error_message "Failed to extract zip file. The file may be corrupted."
  fi
else
  error_message "unzip is not installed. Please install it and try again."
fi

# Process the .cursor/rules directory
EXTRACTED_RULES_DIR=$(find "${EXTRACT_DIR}" -type d -name "rules" -path "*/.cursor/*" | head -n 1)

if [ -z "${EXTRACTED_RULES_DIR}" ]; then
  echo "No rules directory found in the repository."
else
  # Copy all files from the extracted rules directory to the target directory
  echo "Copying rules files to ${RULES_DIR}..."
  # First try with specific files
  cp -Rf "${EXTRACTED_RULES_DIR}/"* "${RULES_DIR}/" 2>/dev/null || true
  
  # Check if any files were copied
  if [ "$(ls -A "${EXTRACTED_RULES_DIR}")" ] && [ ! "$(ls -A "${RULES_DIR}" 2>/dev/null)" ]; then
    echo "Warning: Standard file copy for rules directory might have failed, trying direct directory copy..."
    cp -Rf "${EXTRACTED_RULES_DIR}/." "${RULES_DIR}/" || error_message "Failed to copy rules files. Check permissions and try again."
  fi
fi

# Process the .cursor/task directory
EXTRACTED_TASK_DIR=$(find "${EXTRACT_DIR}" -type d -name "task" -path "*/.cursor/*" | head -n 1)

if [ -z "${EXTRACTED_TASK_DIR}" ]; then
  echo "No task directory found in the repository."
else
  # Display directory contents for debugging
  echo "Found task directory with the following files:"
  ls -la "${EXTRACTED_TASK_DIR}" || true
  
  # Copy all files from the extracted task directory to the target directory
  echo "Copying task files to ${TASK_DIR}..."
  
  # Ensure target directory is clean and writable
  rm -rf "${TASK_DIR}/*" 2>/dev/null || true
  
  # Try direct directory copy instead of wildcard pattern
  if ! cp -Rf "${EXTRACTED_TASK_DIR}/." "${TASK_DIR}/"; then
    error_message "Failed to copy task files. Check permissions and try again."
  fi
  
  # Verify the copy was successful
  echo "Verifying task files were copied successfully..."
  ls -la "${TASK_DIR}" || true
fi

# Success confirmation
echo ""
echo "✓ Successfully downloaded files from ${REPO_URL}"
echo "✓ Rules files are located in: $(pwd)/${RULES_DIR}"
echo "✓ Task files are located in: $(pwd)/${TASK_DIR}"
echo ""

exit 0
