# Bash Scripting Style Standards

Follow these style standards for clean, consistent, and reliable shell scripts.

## Script Structure

### Script Header
Every script should start with:
```bash
#!/bin/bash
set -euo pipefail
```

Include a descriptive header comment block with:
- Script name and purpose
- Author information
- Usage examples
- Input and output description
- Dependencies

Example:
```bash
#!/bin/bash
set -euo pipefail
#
# backup_database.sh - Backs up MySQL databases to compressed files
#
# Usage: backup_database.sh [OPTIONS] DATABASE_NAME
#
# Options:
#   -o DIR    Output directory (default: /var/backups)
#   -c        Enable compression
#   -h        Show this help message
#
# Dependencies: mysql, mysqldump, gzip
```

### Script Organization
- Group related functionality into sections with clear comments
- Define constants and configuration at the top
- Define functions after constants but before main execution
- Include a main function or clearly defined script execution flow
- Include cleanup and trap handlers early in the script

## Variables & Constants

### Variable Naming
- Use `UPPERCASE` for constants and environment variables
- Use `lowercase` for local variables and function names
- Use descriptive names that clearly indicate purpose
- Use underscores to separate words in variable names

### Variable Declaration & Usage
- **ALWAYS** use `${variable}` syntax, not `$variable`
- Quote all variable expansions: `"${variable}"`
- Declare all function-local variables with `local`
- Make variables read-only whenever possible:
  ```bash
  readonly LOCAL_VARIABLE="value"
  local -r ANOTHER_VARIABLE="another value"  # Combines local and readonly
  ```
- Make variables read-only as soon as they won't change anymore
- Use `${variable:-default}` for default values
- Use `${variable:?error message}` for required variables

Example:
```bash
# Constants declared as readonly at the top
readonly CONFIG_FILE="/etc/myapp.conf"
readonly MAX_RETRIES=5

function process_file() {
  # Local function variables, declared readonly where appropriate
  local -r filename="${1:?Missing filename argument}"
  local line_count
  
  # Make read-only as soon as the value is set and won't change
  line_count=$(wc -l < "${filename}")
  readonly line_count
  
  # Rest of the function...
}
```

## Functions

### Function Declaration
- Use the modern function declaration format:
  ```bash
  function name() {
    # Code
  }
  ```
- Include a comment block before each function explaining:
  - Purpose
  - Arguments (with types if applicable)
  - Return value or side effects
  - Example usage if complex

### Function Usage
- Pass arguments explicitly, avoid using global variables
- Return values with `return` for status, `echo` for data
- Keep functions focused on a single responsibility
- Validate function arguments at the beginning
- Use meaningful names that describe the action performed

Example:
```bash
# Validates if a file exists and is readable
# Args:
#   $1 - Path to the file to check
# Returns:
#   0 if file exists and is readable, 1 otherwise
function is_file_readable() {
  local -r file_path="${1:?Missing file path argument}"
  
  if [[ -r "${file_path}" ]]; then
    return 0
  else
    return 1
  fi
}
```

## Error Handling & Logging

### Error Handling
- Always include the `set -euo pipefail` directive
- Set up trap handlers for cleanup:
  ```bash
  function cleanup() {
    # Cleanup code
  }
  trap cleanup EXIT
  ```
- Check return codes for commands that can fail
- Use descriptive error messages that go to stderr
- Exit with meaningful error codes

### Logging
- Implement proper logging functions:
  ```bash
  function log_error() {
    echo "[ERROR] ${1}" >&2
  }
  
  function log_info() {
    echo "[INFO] ${1}"
  }
  
  function log_debug() {
    if [[ "${DEBUG:-0}" -eq 1 ]]; then
      echo "[DEBUG] ${1}"
    fi
  }
  ```
- Use appropriate log levels for different messages
- Include timestamps in logs for long-running scripts
- Use exit codes that reflect the type of error

## Command Execution

### Command Substitution
- Always use `$(command)` instead of backticks
- Quote command substitution results: `"$(command)"`
- Check command existence before using non-standard utilities:
  ```bash
  if ! command -v jq &> /dev/null; then
    log_error "jq is required but not installed"
    exit 1
  fi
  ```

### Conditionals & Tests
- Use `[[` instead of `[` for tests (more powerful, fewer bugs)
- Use `&&` and `||` for simple conditionals
- Use explicit `-eq`, `-ne`, etc. for numeric comparisons
- Use `=` and `!=` for string comparisons
- Add spaces around operators and brackets

Example:
```bash
if [[ "${status}" -eq 0 && "${size}" -gt 1024 ]]; then
  log_info "Processing complete, size: ${size} bytes"
fi
```

## Security Considerations

### Input Validation
- Always validate and sanitize all inputs
- Use pattern matching to validate input format:
  ```bash
  if [[ ! "${input}" =~ ^[a-zA-Z0-9_]+$ ]]; then
    log_error "Invalid input format"
    exit 1
  fi
  ```
- Be especially careful with filenames containing spaces or special characters
- Use absolute paths where appropriate to avoid path injection

### Temporary Files
- Always use `mktemp` for temporary files:
  ```bash
  readonly TEMP_FILE="$(mktemp)"
  trap 'rm -f "${TEMP_FILE}"' EXIT
  ```
- Set appropriate permissions on sensitive files
- Clean up temporary files with trap handlers