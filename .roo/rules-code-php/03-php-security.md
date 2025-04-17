# PHP Security Best Practices

Security guidelines for PHP development to prevent common vulnerabilities.

## Input Validation & Sanitization

### User Input Handling
- Never trust user input from any source (GET, POST, cookies, etc.)
- Validate all input against expected formats, types, and ranges
- Use PHP's filter functions (filter_var, filter_input) for validation
- Apply type casting when appropriate
- Implement whitelist validation rather than blacklist
- Validate on both client and server sides
- Use form libraries (Laravel Form Requests, Symfony Forms) when available
- Implement proper validation for file uploads
- Consider using validation libraries for complex validation rules

### SQL Injection Prevention
- Always use prepared statements with parameterized queries
  ```php
  // UNSAFE
  $query = "SELECT * FROM users WHERE username = '" . $username . "'";
  
  // SAFE
  $stmt = $pdo->prepare("SELECT * FROM users WHERE username = ?");
  $stmt->execute([$username]);
  ```
- Use PDO or MySQLi with prepared statements
- Never concatenate user input directly into SQL strings
- Consider using query builders or ORMs which handle parameterization automatically
- Apply the principle of least privilege for database accounts
- Escape output when necessary using appropriate functions

### Cross-Site Scripting (XSS) Prevention
- Always escape output with htmlspecialchars() or equivalent
  ```php
  // UNSAFE
  echo "Hello, " . $username;
  
  // SAFE
  echo "Hello, " . htmlspecialchars($username, ENT_QUOTES, 'UTF-8');
  ```
- Use template engines with automatic escaping (Twig, Blade)
- Implement Content Security Policy (CSP) headers
- Apply context-specific escaping (HTML, JavaScript, CSS, URL)
- Use proper encoding for special contexts
- Consider using HTML Purifier for rich text input
- Implement proper cookie security (HttpOnly, Secure, SameSite flags)

### Cross-Site Request Forgery (CSRF) Prevention
- Implement CSRF tokens for all state-changing operations
- Use framework-provided CSRF protection (Laravel, Symfony)
- Validate CSRF tokens on the server side
- Use SameSite cookie attribute
- Implement proper session management
- Consider using double-submit cookies for API endpoints

## Authentication & Authorization

### Password Handling
- Never store plaintext passwords
- Use password_hash() and password_verify() for password management
  ```php
  // Hashing a password
  $hashedPassword = password_hash($password, PASSWORD_DEFAULT, ['cost' => 12]);
  
  // Verifying a password
  if (password_verify($password, $hashedPassword)) {
      // Valid password
  }
  ```
- Use an appropriate hashing algorithm (Argon2id preferred, bcrypt acceptable)
- Implement password policies (minimum length, complexity)
- Provide secure password recovery mechanisms
- Consider implementing multi-factor authentication
- Implement account lockout after failed attempts
- Regularly update password hashing methods as better algorithms become available

### Session Security
- Use PHP's built-in session management securely
- Set session.cookie_secure, session.cookie_httponly, and session.cookie_samesite
- Regenerate session IDs after login and privilege changes
  ```php
  session_regenerate_id(true);
  ```
- Use appropriate session timeouts
- Store minimal data in sessions
- Implement proper session validation
- Consider using secure session storage backends
- Validate session data on the server side
- Destroy sessions properly on logout

### Access Control
- Implement proper authorization checks for all sensitive operations
- Use role-based or capability-based access control
- Follow the principle of least privilege
- Implement proper permission checks at the controller/action level
- Use middleware or guards for access control
- Never rely on security by obscurity
- Validate access rights on the server side, not just in the UI
- Log security-relevant events

## Data Protection

### Sensitive Data Handling
- Never store sensitive data in plaintext
- Use appropriate encryption for sensitive data
- Store API keys and secrets securely
- Use .env files or secure vaults for configuration
- Implement proper key management
- Consider using dedicated services for particularly sensitive data (payments, etc.)
- Remove sensitive data from logs and error messages
- Be mindful of data in memory dumps

### File Security
- Validate and sanitize all uploaded files
- Store uploaded files outside of the web root when possible
- Restrict allowed file types and sizes
- Generate random filenames to prevent guessing
- Scan uploaded files for malware if possible
- Properly set file permissions
- Validate file integrity
- Never trust file metadata from the client

### Encryption & Hashing
- Use modern, secure cryptographic libraries
- Never implement your own cryptography
- Use PHP's built-in crypto functions or defuse/php-encryption
- Use appropriate encryption algorithms (AES-256-GCM)
- Implement proper key management
- Use HMAC for message authentication
- Apply encryption consistently across the application
- Keep encryption libraries updated

## Application Configuration

### Error Handling
- Hide detailed error messages from users in production
- Set display_errors = Off in production
- Implement proper exception handling
- Log errors securely without exposing sensitive information
- Use custom error pages
- Set up proper logging with appropriate log levels
- Consider using a centralized logging system
- Implement proper debugging in development only

### Server Configuration
- Keep PHP updated to the latest stable version
- Disable unnecessary PHP modules and functions
- Configure PHP securely (php.ini settings)
- Use proper file permissions
- Consider using PHP-FPM with appropriate settings
- Implement proper web server configuration (Apache, Nginx)
- Use HTTPS for all connections
- Consider using a web application firewall (WAF)

### Framework Security
- Keep frameworks and libraries updated
- Follow framework-specific security best practices
- Use security-focused middleware
- Implement proper validation and sanitization
- Use framework security features rather than custom implementations
- Configure framework security settings properly
- Stay informed about security updates for your framework

## API Security

### REST API Security
- Implement proper authentication (JWT, OAuth2)
- Validate all API inputs
- Implement rate limiting
- Use HTTPS for all API traffic
- Implement proper error handling without leaking information
- Apply appropriate access controls
- Log API calls appropriately
- Implement proper CORS headers
- Consider using API gateways for additional security

### JWT Implementation
- Use strong algorithms (RS256, ES256 preferred over HS256)
- Keep signing keys secure
- Set appropriate token expiration times
- Validate all parts of the token
- Include only necessary claims
- Implement proper token revocation if needed
- Consider using refresh tokens for longer sessions
- Validate issuer and audience claims

## Common Vulnerabilities

### Directory Traversal Prevention
- Validate file paths against a whitelist
- Use basename() and realpath() to prevent path manipulation
- Avoid using user input in file operations when possible
- Never pass user input directly to file functions
- Implement proper permission checks for file access
- Use stream wrappers or abstraction libraries when possible

### Command Injection Prevention
- Avoid shell_exec(), exec(), system(), passthru(), and backtick operators
- If shell commands are necessary, use escapeshellarg() and escapeshellcmd()
  ```php
  // UNSAFE
  system("ping " . $userInput);
  
  // SAFER
  system("ping " . escapeshellarg($userInput));
  ```
- Consider using built-in PHP functions instead of external commands
- Implement proper input validation for command parameters
- Use the least privileged user account for running commands
- Consider alternatives like APIs or libraries instead of shell commands

### Other Injection Flaws
- Prevent LDAP injection with proper input filtering
- Avoid XML injection with secure XML parsing
- Prevent mail header injection when sending emails
- Be cautious with eval(), create_function(), and unserialize()
- Use json_decode() instead of unserialize() when possible
- Implement proper templating to prevent template injection

### Insecure Deserialization
- Avoid unserialize() on untrusted data
- Use JSON or other alternatives when possible
- If serialization is necessary, implement proper validation and signing
- Consider using libraries like opis/closure for safer serialization
- Never deserialize data from untrusted sources
- Be mindful of PHP object injection vulnerabilities