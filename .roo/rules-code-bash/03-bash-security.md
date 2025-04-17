# Bash Security Best Practices

Security considerations for writing robust and secure shell scripts.

## Script Hardening

### Basic Security Measures
- Always use `set -euo pipefail` to fail on errors
- Avoid running scripts as root unless absolutely necessary
- Set restrictive permissions on scripts and sensitive files:
  ```bash
  chmod 700 myscript.sh  # Only owner can read/write/execute
  chmod 600 config.conf  # Only owner can read/write
  ```
- Set the `umask` appropriately at the start of scripts:
  ```bash
  # Only allow owner read/write for new files
  umask 077
  ```
- Use absolute paths for commands and files when security is critical
- Validate all input parameters and environment variables
- Consider using `readonly` for critical variables to prevent modification

### Avoiding Common Vulnerabilities

#### Command Injection
- Never use user input directly in commands:
  ```bash
  # VULNERABLE
  eval "find ${user_input} -type f"
  
  # SAFE
  if [[ "${user_input}" =~ ^[a-zA-Z0-9_/-]+$ ]]; then
    find "${user_input}" -type f
  else
    log_error "Invalid input pattern"
    exit 1
  fi
  ```
- Use arrays for command arguments instead of strings:
  ```bash
  # VULNERABLE
  local cmd="program --opt1 ${user_input} --opt2 value"
  eval "${cmd}"
  
  # SAFE
  local -a cmd=("program" "--opt1" "${user_input}" "--opt2" "value")
  "${cmd[@]}"
  ```

#### Path Traversal
- Validate and normalize paths:
  ```bash
  function is_valid_path() {
    local -r path="${1}"
    local -r base_dir="${2}"
    
    # Convert to absolute path
    local -r abs_path="$(cd "$(dirname "${path}")" && pwd)/$(basename "${path}")"
    
    # Check if path is within allowed directory
    if [[ "${abs_path}" == "${base_dir}"/* ]]; then
      return 0
    else
      return 1
    fi
  }
  ```
- Use `realpath` or `readlink -f` to resolve symbolic links
- Verify file paths before accessing files

#### Temporary File Vulnerabilities
- Always use `mktemp` for creating temporary files:
  ```bash
  # Create a temporary file
  readonly TEMP_FILE="$(mktemp)"
  
  # Create a temporary directory
  readonly TEMP_DIR="$(mktemp -d)"
  
  # Clean up on exit
  trap 'rm -f "${TEMP_FILE}"; rm -rf "${TEMP_DIR}"' EXIT
  ```
- Avoid predictable filenames for temporary files
- Set proper permissions on temporary files
- Always clean up temporary files and directories using trap handlers

## Sensitive Data Handling

### Secure Password Handling
- Never store passwords or secrets in scripts
- Use environment variables or secure external storage for credentials
- Don't expose secrets in command arguments (visible in ps output)
- Use read with `-s` flag for password input:
  ```bash
  read -s -p "Enter password: " password
  echo
  ```
- Clear sensitive variables when no longer needed:
  ```bash
  function clear_sensitive_vars() {
    password=""
    api_key=""
    # Ensure the shell doesn't optimize away the assignment
    local dummy="${password}${api_key}"
    dummy="${dummy}" # Silence unused variable warning
  }
  trap clear_sensitive_vars EXIT
  ```

### Secure Configuration
- Store sensitive configuration outside of scripts
- Use restrictive permissions on configuration files
- Consider encrypting sensitive configuration files
- Separate configuration from code
- Validate configuration values before use

### Secure Script Output
- Redirect sensitive information to `/dev/null`
- Avoid logging sensitive data
- Be careful with error messages that might expose system details
- Use `set +x` before sections with sensitive data if debug tracing is enabled

## Network Security

### Secure Network Operations
- Validate and sanitize URLs before fetching
- Use HTTPS for all network operations where possible
- Validate server certificates when making HTTPS requests
- Set appropriate timeouts for network operations
- Add appropriate error handling for network failures

### Secure API Interactions
- Store API keys securely, not in scripts
- Validate API responses
- Implement rate limiting for API requests
- Handle API errors gracefully
- Use HTTPS for all API calls

## Privilege Management

### Principle of Least Privilege
- Drop privileges when possible:
  ```bash
  function drop_privileges() {
    if [[ "${EUID}" -eq 0 && -n "${SUDO_USER:-}" ]]; then
      local -r user="${SUDO_USER}"
      log_info "Dropping privileges to user: ${user}"
      exec sudo -u "${user}" "${0}" "$@"
    fi
  }
  ```
- Use sudo selectively only for operations that require it:
  ```bash
  # Only use sudo for specific commands that need it
  function safe_sudo_command() {
    local -r cmd="${1}"
    if [[ "${EUID}" -ne 0 ]]; then
      sudo "${cmd}"
    else
      "${cmd}"
    fi
  }
  ```
- Check for required permissions before executing critical operations
- Consider using capabilities instead of full root privileges when possible

### Secure File Operations
- Create files with restrictive permissions:
  ```bash
  # Create a file with restrictive permissions
  function create_secure_file() {
    local -r path="${1}"
    local -r content="${2}"
    
    # Ensure directory exists
    mkdir -p "$(dirname "${path}")"
    
    # Use echo with redirection
    echo "${content}" > "${path}"
    
    # Set restrictive permissions
    chmod 600 "${path}"
  }
  ```
- Always validate files before acting on them:
  ```bash
  function validate_file() {
    local -r file="${1}"
    
    # Check if file exists
    if [[ ! -f "${file}" ]]; then
      log_error "File does not exist: ${file}"
      return 1
    fi
    
    # Check if file is readable
    if [[ ! -r "${file}" ]]; then
      log_error "File is not readable: ${file}"
      return 1
    fi
    
    # Check file ownership
    if [[ "$(stat -c %U "${file}")" != "${EXPECTED_OWNER}" ]]; then
      log_error "File has unexpected owner: ${file}"
      return 1
    fi
    
    # Check file permissions
    local -r perms="$(stat -c %a "${file}")"
    if [[ "${perms}" != "600" ]]; then
      log_error "File has incorrect permissions: ${file} (${perms})"
      return 1
    fi
    
    return 0
  }
  ```

## Input Validation

### String Validation
- Use pattern matching for validating input formats:
  ```bash
  function is_valid_username() {
    local -r username="${1}"
    
    # Username must be 3-32 characters, alphanumeric and underscores only
    if [[ "${username}" =~ ^[a-zA-Z0-9_]{3,32}$ ]]; then
      return 0
    else
      return 1
    fi
  }
  ```
- Validate all external inputs thoroughly
- Be cautious with regex that could lead to catastrophic backtracking
- Consider using external tools for complex validation (e.g., jq for JSON)

### Numeric Validation
- Validate numeric inputs before using them in calculations:
  ```bash
  function is_valid_integer() {
    local -r value="${1}"
    local -r min="${2:-}"
    local -r max="${3:-}"
    
    # Check if the value is an integer
    if ! [[ "${value}" =~ ^[0-9]+$ ]]; then
      return 1
    fi
    
    # Check minimum value if provided
    if [[ -n "${min}" && "${value}" -lt "${min}" ]]; then
      return 1
    fi
    
    # Check maximum value if provided
    if [[ -n "${max}" && "${value}" -gt "${max}" ]]; then
      return 1
    fi
    
    return 0
  }
  ```
- Be careful with integer overflows in calculations
- Use bc or awk for complex numeric operations

### File Path Validation
- Validate file paths before accessing files:
  ```bash
  function is_safe_path() {
    local -r path="${1}"
    local -r allowed_dir="${2}"
    
    # Normalize path
    local -r norm_path="$(realpath -m "${path}")"
    local -r norm_allowed="$(realpath -m "${allowed_dir}")"
    
    # Check if normalized path starts with allowed directory
    if [[ "${norm_path}" == "${norm_allowed}"/* ]]; then
      return 0
    else
      return 1
    fi
  }
  ```
- Check file types before operations (is it a regular file, directory, symlink, etc.)
- Be careful with special file types (/dev/*, sockets, pipes, etc.)