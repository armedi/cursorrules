#!/bin/bash
#
# download_rules.sh - Downloads .cursor/rules directory from github.com/armedi/cursorrules
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

# Target directory
TARGET_DIR=".cursor/rules"

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

if [ ! -d "$TARGET_DIR" ]; then
  mkdir -p "$TARGET_DIR" || error_message "Failed to create $TARGET_DIR directory"
fi

# Download the repository as a zip file
echo "Downloading rules from ${REPO_URL}..."
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
echo "Extracting rules files..."
EXTRACT_DIR="${TEMP_DIR}/extract"
mkdir -p "${EXTRACT_DIR}"

if command -v unzip &> /dev/null; then
  if ! unzip -q "${ZIP_FILE}" -d "${EXTRACT_DIR}"; then
    error_message "Failed to extract zip file. The file may be corrupted."
  fi
else
  error_message "unzip is not installed. Please install it and try again."
fi

# Find the .cursor/rules directory in the extracted files
RULES_DIR=$(find "${EXTRACT_DIR}" -type d -name "rules" -path "*/.cursor/*" | head -n 1)

if [ -z "${RULES_DIR}" ]; then
  # If the rules directory doesn't exist in the repo, create an empty one
  echo "No rules directory found in the repository. Creating an empty one."
else
  # Copy all files from the extracted rules directory to the target directory
  echo "Copying rules files to ${TARGET_DIR}..."
  if ! cp -R "${RULES_DIR}"/* "${TARGET_DIR}/" 2>/dev/null; then
    # The directory might be empty, which is fine
    if [ "$(ls -A "${RULES_DIR}")" ]; then
      error_message "Failed to copy rules files. Check permissions and try again."
    fi
  fi
fi

# Success confirmation
echo ""
echo "✓ Successfully downloaded rules from ${REPO_URL}"
echo "✓ Files are located in: $(pwd)/${TARGET_DIR}"
echo ""

exit 0
