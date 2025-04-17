# Python Security Best Practices

Security considerations and practices for Python development.

## Input Validation & Sanitization

### User Input Handling
- Never trust user input
- Validate all input against expected formats, types, and ranges
- Use schema validation libraries like Pydantic, marshmallow, or cerberus
- Implement proper type checking
- Sanitize input before processing or storing
- Use allowlists rather than denylists for validation when possible

### Command Injection Prevention
- Avoid using `os.system()`, `subprocess.call()` with shell=True
- Use `subprocess.run()` with a list of arguments instead
- Never directly interpolate user input into command strings
- Use shlex.quote if string interpolation is unavoidable
```python
# Unsafe
os.system(f"ping {user_input}")

# Safe
subprocess.run(["ping", user_input], capture_output=True)
```

### SQL Injection Prevention
- Use parameterized queries or ORM frameworks
- Never directly interpolate values into SQL strings
- Apply the principle of least privilege for database accounts
- Validate and sanitize inputs before using in database queries
```python
# Unsafe
cursor.execute(f"SELECT * FROM users WHERE username = '{username}'")

# Safe
cursor.execute("SELECT * FROM users WHERE username = %s", (username,))
```

### Path Traversal Prevention
- Use `pathlib` for safe path manipulation
- Validate file paths against allowlists
- Normalize paths before validation
- Prevent directory traversal attacks with `os.path.abspath` and verification
```python
# Vulnerable to path traversal
file_path = user_directory + user_input
with open(file_path, 'r') as f:
    data = f.read()

# Safe approach
user_path = pathlib.Path(user_directory) / user_input
if not user_path.is_relative_to(pathlib.Path(user_directory)):
    raise SecurityError("Path traversal detected")
with open(user_path, 'r') as f:
    data = f.read()
```

## Data Protection

### Sensitive Data Handling
- Never hardcode credentials in source code
- Use environment variables or secure vaults for secrets
- Implement proper access controls for sensitive data
- Encrypt sensitive data at rest and in transit
- Use dedicated libraries for handling credentials (like python-dotenv)
- Redact sensitive information in logs and error messages

### Cryptography Best Practices
- Use established cryptography libraries (cryptography, pyca)
- Don't implement your own cryptographic algorithms
- Use strong, industry-standard algorithms (AES, RSA, etc.)
- Implement proper key management
- Use appropriate key sizes and initialization vectors
- Consider using higher-level APIs rather than primitives

### Password Handling
- Use dedicated password hashing libraries (passlib, bcrypt)
- Never store plaintext passwords
- Implement password complexity requirements
- Use salted password hashing with appropriate work factors
- Consider PBKDF2, bcrypt, or Argon2 for password hashing
```python
# Good password hashing with bcrypt
import bcrypt

def hash_password(password: str) -> bytes:
    return bcrypt.hashpw(password.encode(), bcrypt.gensalt(rounds=12))

def verify_password(plain_password: str, hashed_password: bytes) -> bool:
    return bcrypt.checkpw(plain_password.encode(), hashed_password)
```

## Web Application Security

### CSRF Protection
- Implement proper CSRF token validation
- Use web framework's built-in CSRF protection
- Apply CSRF protection to all state-changing operations
- Ensure tokens are tied to the user's session
- Use the SameSite cookie attribute

### XSS Prevention
- Escape output in templates
- Use content security policy (CSP) headers
- Validate and sanitize input before storing or displaying
- Use auto-escaping template engines
- Apply appropriate headers (X-XSS-Protection)

### Authentication & Authorization
- Implement proper session management
- Use secure cookies (Secure, HttpOnly flags)
- Apply the principle of least privilege
- Implement proper access control checks
- Use multi-factor authentication where appropriate
- Consider OAuth2 for third-party authentication
- Implement proper password reset mechanisms
- Use rate limiting for authentication attempts

### API Security
- Implement proper authentication for APIs
- Use HTTPS for all API communications
- Apply rate limiting to prevent abuse
- Validate all API inputs
- Implement proper error handling that doesn't leak sensitive information
- Use appropriate HTTP methods and status codes
- Consider using JWT with proper signing

## Dependency Management

### Dependency Security
- Regularly audit and update dependencies
- Use tools like safety, pip-audit, or snyk
- Pin dependency versions for stability
- Use virtual environments to isolate dependencies
- Consider container scanning for vulnerabilities
- Be cautious with third-party packages from unknown sources

### Code Execution Risks
- Avoid using `eval()` or `exec()` with untrusted input
- Be cautious with dynamic imports
- Avoid using `pickle` with untrusted data (use JSON instead)
- Be careful with deserialization of untrusted data
- Use safer alternatives when possible (ast.literal_eval instead of eval)

## Server Configuration

### Production Deployment
- Disable debug mode in production
- Set appropriate file permissions
- Run services with least privilege
- Use proper WSGI/ASGI servers (Gunicorn, uWSGI, etc.)
- Implement proper logging and monitoring
- Set secure HTTP headers
- Use HTTPS with proper TLS configuration

### Container Security
- Use minimal base images
- Don't run containers as root
- Scan images for vulnerabilities
- Keep base images updated
- Implement proper secrets management
- Use read-only file systems where possible
- Limit container capabilities