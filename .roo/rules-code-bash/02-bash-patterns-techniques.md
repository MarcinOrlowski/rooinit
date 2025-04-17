# Bash Patterns & Techniques

Common patterns and techniques for robust shell scripting.

## Script Templates

### Basic Script Template
```bash
#!/bin/bash
set -euo pipefail

# Script metadata
readonly SCRIPT_NAME="$(basename "${0}")"
readonly SCRIPT_DIR="$(cd "$(dirname "${0}")" && pwd)"

# Constants
readonly DEFAULT_CONFIG="/etc/app/config"
readonly MAX_RETRIES=3

# Usage information
function show_usage() {
  cat <<EOF
Usage: ${SCRIPT_NAME} [OPTIONS] ARGUMENT

Description:
  Brief description of what the script does.

Options:
  -c FILE    Configuration file (default: ${DEFAULT_CONFIG})
  -v         Enable verbose output
  -h         Show this help message and exit

Arguments:
  ARGUMENT   Description of the required argument
EOF
}

# Logging functions
function log_error() {
  echo "[ERROR] ${1}" >&2
}

function log_info() {
  echo "[INFO] ${1}"
}

function log_debug() {
  if [[ "${VERBOSE:-0}" -eq 1 ]]; then
    echo "[DEBUG] ${1}"
  fi
}

# Cleanup function
function cleanup() {
  # Cleanup code (remove temp files, etc.)
  log_debug "Cleaning up resources"
}

# Main function
function main() {
  # Default values
  local config_file="${DEFAULT_CONFIG}"
  local verbose=0
  
  # Parse options
  local opt
  while getopts ":c:vh" opt; do
    case "${opt}" in
      c)
        config_file="${OPTARG}"
        ;;
      v)
        verbose=1
        ;;
      h)
        show_usage
        exit 0
        ;;
      \?)
        log_error "Invalid option: -${OPTARG}"
        show_usage
        exit 1
        ;;
      :)
        log_error "Option -${OPTARG} requires an argument"
        show_usage
        exit 1
        ;;
    esac
  done
  
  # Make verbose setting available to log_debug function
  readonly VERBOSE="${verbose}"
  
  # Remove the parsed options
  shift $((OPTIND - 1))
  
  # Check for required arguments
  if [[ $# -lt 1 ]]; then
    log_error "Missing required argument"
    show_usage
    exit 1
  fi
  
  local -r argument="${1}"
  
  # Script logic goes here
  log_info "Processing ${argument}"
  
  # Return success
  return 0
}

# Set up trap
trap cleanup EXIT

# Call main and exit with its return code
main "$@"
exit $?
```

## Command Line Argument Parsing

### Using getopts (for simple scripts)
```bash
function parse_args() {
  local opt
  while getopts ":f:o:vh" opt; do
    case "${opt}" in
      f)
        readonly INPUT_FILE="${OPTARG}"
        ;;
      o)
        readonly OUTPUT_FILE="${OPTARG}"
        ;;
      v)
        readonly VERBOSE=1
        ;;
      h)
        show_usage
        exit 0
        ;;
      \?)
        log_error "Invalid option: -${OPTARG}"
        show_usage
        exit 1
        ;;
      :)
        log_error "Option -${OPTARG} requires an argument"
        show_usage
        exit 1
        ;;
    esac
  done
  
  # Remove the parsed options
  shift $((OPTIND - 1))
  
  # Remaining arguments are in $@
  readonly POSITIONAL_ARGS=("$@")
}
```

### Using getopt (for complex scripts with long options)
```bash
function parse_args() {
  local options
  options=$(getopt -o "f:o:vh" --long "file:,output:,verbose,help" -n "${SCRIPT_NAME}" -- "$@")
  
  if [[ $? -ne 0 ]]; then
    log_error "Failed to parse options"
    show_usage
    exit 1
  fi
  
  eval set -- "${options}"
  
  while true; do
    case "${1}" in
      -f|--file)
        readonly INPUT_FILE="${2}"
        shift 2
        ;;
      -o|--output)
        readonly OUTPUT_FILE="${2}"
        shift 2
        ;;
      -v|--verbose)
        readonly VERBOSE=1
        shift
        ;;
      -h|--help)
        show_usage
        exit 0
        ;;
      --)
        shift
        break
        ;;
      *)
        log_error "Invalid option: ${1}"
        show_usage
        exit 1
        ;;
    esac
  done
  
  # Remaining arguments are in $@
  readonly POSITIONAL_ARGS=("$@")
}
```

## Error Handling Patterns

### Comprehensive Error Handling
```bash
#!/bin/bash
set -euo pipefail

# Global exit code
readonly E_SUCCESS=0
readonly E_GENERAL=1
readonly E_MISSING_DEPENDENCY=2
readonly E_INVALID_INPUT=3
readonly E_PERMISSION_DENIED=4

# Error tracking
ERROR_COUNT=0

function handle_error() {
  local -r line_no="${1}"
  local -r command="${2}"
  local -r error_code="${3}"
  
  log_error "Error on line ${line_no} running command '${command}': Exit code ${error_code}"
  ERROR_COUNT=$((ERROR_COUNT + 1))
}

# Set trap for command failures (if set -e is disabled)
trap 'handle_error "${LINENO}" "${BASH_COMMAND}" "$?"' ERR

function check_dependencies() {
  local -r deps=("$@")
  local missing_deps=()
  
  for dep in "${deps[@]}"; do
    if ! command -v "${dep}" &> /dev/null; then
      missing_deps+=("${dep}")
    fi
  done
  
  if [[ "${#missing_deps[@]}" -gt 0 ]]; then
    log_error "Missing dependencies: ${missing_deps[*]}"
    exit "${E_MISSING_DEPENDENCY}"
  fi
}

function safe_command() {
  local -r cmd="${1}"
  local -r error_msg="${2:-Command failed}"
  local -r error_code="${3:-${E_GENERAL}}"
  
  log_debug "Running: ${cmd}"
  
  if ! eval "${cmd}"; then
    log_error "${error_msg}"
    exit "${error_code}"
  fi
}
```

### Retrying Commands
```bash
function retry_command() {
  local -r cmd="${1}"
  local -r max_attempts="${2:-3}"
  local -r delay="${3:-5}"
  local -r error_msg="${4:-Command failed after ${max_attempts} attempts}"
  
  local attempt=1
  
  while [[ "${attempt}" -le "${max_attempts}" ]]; do
    log_debug "Attempt ${attempt}/${max_attempts}: ${cmd}"
    
    if eval "${cmd}"; then
      return 0
    else
      log_debug "Attempt ${attempt} failed. Waiting ${delay} seconds before retry..."
      sleep "${delay}"
      attempt=$((attempt + 1))
    fi
  done
  
  log_error "${error_msg}"
  return 1
}
```

## File Processing Patterns

### Line-by-Line Processing
```bash
function process_file() {
  local -r file="${1:?Missing file argument}"
  
  if [[ ! -r "${file}" ]]; then
    log_error "Cannot read file: ${file}"
    return 1
  fi
  
  while IFS= read -r line; do
    # Process each line
    process_line "${line}"
  done < "${file}"
}

function process_line() {
  local -r line="${1}"
  
  # Skip empty lines and comments
  if [[ -z "${line}" || "${line}" =~ ^# ]]; then
    return 0
  fi
  
  # Process the line
  echo "Processing: ${line}"
}
```

### CSV Processing
```bash
function process_csv() {
  local -r csv_file="${1:?Missing CSV file argument}"
  local -r delimiter="${2:-,}"
  local -r has_header="${3:-1}"
  
  if [[ ! -r "${csv_file}" ]]; then
    log_error "Cannot read CSV file: ${csv_file}"
    return 1
  fi
  
  local line_num=0
  
  while IFS= read -r line; do
    line_num=$((line_num + 1))
    
    # Skip header if has_header is set
    if [[ "${has_header}" -eq 1 && "${line_num}" -eq 1 ]]; then
      continue
    fi
    
    # Split the line into fields
    IFS="${delimiter}" read -r -a fields <<< "${line}"
    
    # Process the fields
    process_csv_row "${fields[@]}"
  done < "${csv_file}"
}

function process_csv_row() {
  # First argument is field 1, second is field 2, etc.
  local -r field1="${1:-}"
  local -r field2="${2:-}"
  
  # Process the row
  echo "Field 1: ${field1}, Field 2: ${field2}"
}
```

## Configuration Management

### Reading Config Files
```bash
function load_config() {
  local -r config_file="${1:?Missing config file argument}"
  
  if [[ ! -r "${config_file}" ]]; then
    log_error "Cannot read config file: ${config_file}"
    return 1
  fi
  
  # Read config file and export variables
  while IFS= read -r line; do
    # Skip empty lines and comments
    if [[ -z "${line}" || "${line}" =~ ^# ]]; then
      continue
    fi
    
    # Extract variable name and value
    if [[ "${line}" =~ ^([A-Za-z_][A-Za-z0-9_]*)=(.*)$ ]]; then
      local name="${BASH_REMATCH[1]}"
      local value="${BASH_REMATCH[2]}"
      
      # Remove quotes if present
      value="${value#\"}"
      value="${value%\"}"
      value="${value#\'}"
      value="${value%\'}"
      
      # Export the variable
      export "${name}=${value}"
      log_debug "Config: ${name}=${value}"
    fi
  done < "${config_file}"
}
```

### Validating Configuration
```bash
function validate_config() {
  local -r required_vars=("$@")
  local missing_vars=()
  
  for var in "${required_vars[@]}"; do
    if [[ -z "${!var:-}" ]]; then
      missing_vars+=("${var}")
    fi
  done
  
  if [[ "${#missing_vars[@]}" -gt 0 ]]; then
    log_error "Missing required configuration variables: ${missing_vars[*]}"
    return 1
  fi
  
  return 0
}
```

## Parallel Execution

### Using Background Processes with Wait
```bash
function process_items_parallel() {
  local -r items=("$@")
  local -r max_concurrent="${MAX_CONCURRENT:-4}"
  local running=0
  local pids=()
  
  for item in "${items[@]}"; do
    # If we've reached the maximum number of concurrent processes, wait for one to finish
    if [[ "${running}" -ge "${max_concurrent}" ]]; then
      wait -n
      running=$((running - 1))
    fi
    
    # Start a new background process
    process_item "${item}" &
    pids+=("$!")
    running=$((running + 1))
  done
  
  # Wait for all remaining processes to finish
  for pid in "${pids[@]}"; do
    wait "${pid}"
  done
}

function process_item() {
  local -r item="${1}"
  
  # Process the item
  echo "Processing item: ${item}"
  sleep 1
}
```