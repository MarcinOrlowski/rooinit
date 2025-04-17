# JavaScript Security Best Practices

## General Principles
- **Never Trust User Input**: Always validate, sanitize, and/or escape data received from users or external sources before using it.
- **Principle of Least Privilege**: Grant only the minimum necessary permissions for code execution.
- **Defense in Depth**: Implement multiple layers of security controls.
- **Keep Dependencies Updated**: Regularly update frameworks, libraries, and Node.js/browser versions to patch known vulnerabilities. Use tools like `npm audit` or `yarn audit`.

## Frontend Security (Browser)
- **Cross-Site Scripting (XSS)**:
    - Sanitize user input before rendering it in the DOM.
    - Use framework-specific mechanisms for data binding that automatically handle encoding (e.g., React's JSX, Angular's interpolation).
    - Set appropriate `Content-Security-Policy` (CSP) headers to restrict script sources and execution.
    - Avoid using `innerHTML`, `outerHTML`, `document.write` with untrusted content.
- **Cross-Site Request Forgery (CSRF)**:
    - Implement anti-CSRF tokens (synchronizer token pattern) for state-changing requests (POST, PUT, DELETE).
    - Check the `Origin` or `Referer` header (though less reliable).
    - Use the `SameSite` cookie attribute (Lax or Strict).
- **Data Exposure**:
    - Avoid storing sensitive information (API keys, tokens) directly in frontend code or `localStorage`. Use secure, HttpOnly cookies for session tokens or backend-proxied API calls.
    - Be mindful of data exposed in API responses consumed by the frontend.
- **Clickjacking**: Use the `X-Frame-Options` header or CSP's `frame-ancestors` directive.

## Backend Security (Node.js)
- **Input Validation**: Validate all incoming data (request bodies, query parameters, headers) against expected formats, types, and lengths using libraries like Joi, Zod, or express-validator.
- **Authentication & Authorization**:
    - Implement robust authentication mechanisms (e.g., OAuth 2.0, JWT, secure sessions).
    - Store passwords securely using strong hashing algorithms with salts (e.g., bcrypt, Argon2).
    - Enforce proper authorization checks for all protected resources and actions.
- **Injection Attacks (SQL, NoSQL, Command)**:
    - Use parameterized queries or ORMs/ODMs that handle escaping automatically for database interactions.
    - Sanitize inputs used in shell commands. Avoid executing external commands based directly on user input.
- **Security Headers**: Use middleware like `helmet` to set important security headers (CSP, HSTS, X-Frame-Options, X-Content-Type-Options, etc.).
- **Rate Limiting**: Implement rate limiting on APIs to prevent brute-force attacks and denial-of-service.
- **Logging & Monitoring**: Log security-relevant events (login attempts, authorization failures) but avoid logging sensitive data. Monitor logs for suspicious activity.
- **Dependency Security**: Regularly scan dependencies for known vulnerabilities.

## TypeScript Specifics
- Use types to enforce data contracts and catch potential type-related vulnerabilities early.
- Be cautious with type assertions (`as`) and non-null assertions (`!`), as they bypass type safety checks.