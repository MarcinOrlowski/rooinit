#!/bin/bash
#
# rooinit - Initializes a directory for Roo by symlinking or copying configuration files.
#
# Usage: rooinit.sh [--copy] [--verbose]
#   Run this script in the directory you want to initialize.
#
# Options:
#   --copy      Copy files/directories instead of creating symbolic links.
#   --verbose   Enable verbose output.
#   -h, --help  Show this help message.
#
# Description:
#   Checks if the target directory (current working directory) already contains
#   a '.roomodes' or '.roo'. If not, it creates symbolic links pointing to
#   these items in the script's installation directory. If --copy is specified,
#   it copies them instead. Uses absolute paths for symlink targets.
#
# Exits:
#   0 on successful initialization.
#   1 if initialization is aborted due to existing files/directories, errors, or invalid options.
#
set -euo pipefail

# --- Constants ---
# Get the directory where this script resides, handling symlinks and spaces.
# BASH_SOURCE[0] is the path to the script itself.
# dirname gets the directory part.
# cd into that directory.
# pwd prints the absolute path.
# &amp;> /dev/null suppresses output from cd/dirname.
readonly SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
readonly TARGET_DIR="." # Operate on the current working directory

# --- Argument Parsing ---
COPY_MODE=false
VERBOSE=false

function show_usage() {
  # Display usage information from the script's header comments.
  grep '^# Usage:' "${BASH_SOURCE[0]}"
  grep '^# Options:' -A 3 "${BASH_SOURCE[0]}" # Show Options section
}

# Simple argument parsing loop
# Using a loop allows handling flags anywhere in the command line
# Note: This simple loop doesn't handle combined short options or options with arguments well.
# If more complex options are needed later, consider using getopt.
TEMP_ARGS=() # Store non-flag arguments if needed later
while [[ $# -gt 0 ]]; do
  case "${1}" in
    --copy)
      COPY_MODE=true
      shift
      ;;
    --verbose)
      VERBOSE=true
      shift
      ;;
    -h|--help)
      show_usage
      exit 0
      ;;
    *)
      # For now, we ignore positional arguments but error on unknown flags
      if [[ "${1}" == -* ]]; then
          log_error "Unknown option: ${1}"
          show_usage
          exit 1
      fi
      TEMP_ARGS+=("${1}")
      shift
      ;;
  esac
done

# Make settings available globally and read-only
readonly COPY_MODE
readonly VERBOSE

# --- Logging Functions ---
function log_error() {
  echo "*** ${1}" >&2
}

function log_verbose() {
  if [[ "${VERBOSE}" = true ]]; then
    echo "[DEBUG] ${1}"
  fi
}

function log_info() {
    echo "${1}"
}

# --- Gitignore Handling ---
function update_gitignore() {
  local -r gitignore_path="${TARGET_DIR}/.gitignore"
  local -r comment_line="# Do not add trailing slash for .roo entry, it will not work for symlinked folders"
  local -r roo_line=".roo"
  local -r roomodes_line=".roomodes"
  local added_file=false
  local added_lines=false

  log_verbose "Checking/updating ${gitignore_path}"

  # Check if .gitignore exists, create if not
  if [[ ! -f "${gitignore_path}" ]]; then
    if touch "${gitignore_path}"; then
      log_info "Created ${gitignore_path}"
      added_file=true
    else
      log_error "Failed to create ${gitignore_path}. Skipping .gitignore update."
      return 1
    fi
  fi

  # Ensure the required lines are present
  if ! grep -qxF -- "${comment_line}" "${gitignore_path}"; then
    if echo "${comment_line}" >> "${gitignore_path}"; then
      added_lines=true
    else
      log_error "Failed to add comment to ${gitignore_path}"
    fi
  fi

  if ! grep -qxF -- "${roo_line}" "${gitignore_path}"; then
    if echo "${roo_line}" >> "${gitignore_path}"; then
      log_verbose "Added '${roo_line}' to ${gitignore_path}"
      added_lines=true
    else
      log_error "Failed to add '${roo_line}' to ${gitignore_path}"
    fi
  fi

  if ! grep -qxF -- "${roomodes_line}" "${gitignore_path}"; then
    if echo "${roomodes_line}" >> "${gitignore_path}"; then
      log_verbose "Added '${roomodes_line}' to ${gitignore_path}"
      added_lines=true
    else
      log_error "Failed to add '${roomodes_line}' to ${gitignore_path}"
    fi
  fi

  if [[ "${added_file}" = false && "${added_lines}" = false ]]; then
      log_verbose "${gitignore_path} already contains the required entries."
  else
      log_info "Configured ${gitignore_path} to exclude Roo config files"
  fi

  return 0
}

function main() {
  log_verbose "Starting Roo initialization check in directory: $(pwd)"

  # Pre-check 1: Check for existing .roomodes file or symlink in the target directory
  if [[ -e "${TARGET_DIR}/.roomodes" ]]; then
    log_error "'.roomodes' already exists in this directory. Aborting."
    exit 1
  fi

  if [[ -e "${TARGET_DIR}/.roo" ]]; then
    log_error "'.roo' already exists in this directory. Aborting."
    exit 1
  fi

  log_verbose "Pre-checks passed. Proceeding with initialization."

  # Determine operation mode
  local operation_mode="symlink"
  local operation_verb="Linking"
  local operation_past_verb="Linked"
  if [[ "${COPY_MODE}" = true ]]; then
    operation_mode="copy"
    operation_verb="Copying"
    operation_past_verb="Copied"
  fi
  log_verbose "Operation mode: ${operation_mode}"

  local source_roomodes="${SCRIPT_DIR}/.roomodes"
  local target_roomodes="${TARGET_DIR}/.roomodes"

  # Check if source exists
  if [[ ! -f "${source_roomodes}" ]]; then
      log_error "Source file '.roomodes' not found in ${SCRIPT_DIR}. Aborting."
      exit 1
  fi

  log_verbose "${operation_verb} '.roomodes' from ${source_roomodes} to ${target_roomodes}"
  if [[ "${COPY_MODE}" = true ]]; then
    # Copy Mode
    if cp "${source_roomodes}" "${target_roomodes}"; then
      log_verbose "${operation_past_verb} .roomodes."
    else
      log_error "Failed to copy '.roomodes'. Aborting."
      exit 1
    fi
  else
    # Symlink Mode (Default) - Use absolute path for source
    if ln -s "${source_roomodes}" "${target_roomodes}"; then
      log_verbose "${operation_past_verb} .roomodes."
    else
      log_error "Failed to create symlink for '.roomodes'. Aborting."
      exit 1
    fi
  fi

  # --- Initialization Step 2: Handle .roo directory ---
  local source_roo="${SCRIPT_DIR}/.roo"
  local target_roo="${TARGET_DIR}/.roo"

  # Check if source exists
  if [[ ! -d "${source_roo}" ]]; then
      log_error "Source directory '.roo' not found in ${SCRIPT_DIR}. Aborting."
      # Attempt cleanup of the previously created item (.roomodes file or link)
      log_verbose "Attempting cleanup of ${target_roomodes}"
      rm -f "${target_roomodes}"
      exit 1
  fi

  log_verbose "${operation_verb} '.roo' directory from ${source_roo} to ${target_roo}"
  if [[ "${COPY_MODE}" = true ]]; then
    # Copy Mode
    if cp -r "${source_roo}" "${target_roo}"; then
      log_verbose "${operation_past_verb} .roo directory."
    else
      log_error "Failed to copy '.roo' directory. Attempting cleanup."
      rm -f "${target_roomodes}"
      log_error "Aborting initialization."
      exit 1
    fi
  else
    # Symlink Mode (Default) - Use absolute path for source
    if ln -s "${source_roo}" "${target_roo}"; then
      log_verbose "${operation_past_verb} .roo directory."
    else
      log_error "Failed to create symlink for '.roo' directory. Attempting cleanup."
      rm -f "${target_roomodes}"
      log_error "Aborting initialization."
      exit 1
    fi
  fi

  log_verbose "Roo project initialized successfully using ${operation_mode} mode."

  # Update .gitignore
  if ! update_gitignore; then
    log_error "There was an issue updating the .gitignore file."
    # Decide if this should be a fatal error for the whole script?
    # For now, let's consider it non-fatal, the main init succeeded.
  fi

  return 0
}

main
exit $?