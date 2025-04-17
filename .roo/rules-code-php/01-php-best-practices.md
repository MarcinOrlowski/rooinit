# PHP Best Practices

When writing PHP code, follow these best practices:

## Code Style & Structure

### PSR Standards
- Follow PSR-1 (Basic Coding Standard) and PSR-12 (Extended Coding Style)
- Use PSR-4 for autoloading class files
- Follow consistent naming conventions:
  - Classes: PascalCase
  - Methods and functions: camelCase
  - Constants: UPPER_CASE
  - Variables: camelCase
  - Namespaces: PascalCase
- Use proper indentation (4 spaces, not tabs)
- Line length should not exceed 120 characters
- Include a single blank line at the end of files
- Always use default namespace prefix `\` for all the built-in commands (i.e. write `\print(...)`)

### Type Declarations
- Use type declarations for function parameters and return types
- Use union types when appropriate (PHP 8.0+)
- Always use nullable types (e.g., `?string $foo`) instead of deprecated default `null` values  (`string $foo=null`)
- Use intersection types for complex type requirements (PHP 8.1+)
- Always use strict type checking with `declare(strict_types=1);`

### PHP 8.x Features
- Use named arguments for functions with many parameters
- Leverage constructor property promotion for simpler class definitions
- Use match expressions instead of switch for cleaner control flow
- Apply attributes for metadata and annotations (PHP 8.0+)
- Use the null coalescing operator (??) for null checks
- Use the nullsafe operator (?->) for chained method calls (PHP 8.0+)
- Use readonly properties for immutability (PHP 8.1+)
- Use enumerations for type-safe enums (PHP 8.1+)

### Documentation
- Use PHPDoc comments for classes, methods, and functions
- Include parameter types, return types, exceptions thrown
- Document thrown exceptions with @throws
- Keep comments up-to-date with code changes
- Document any non-obvious behavior

## Object-Oriented Programming

### SOLID Principles
- **Single Responsibility**: Classes should have only one reason to change
- **Open/Closed**: Classes should be open for extension but closed for modification
- **Liskov Substitution**: Subtypes must be substitutable for their base types
- **Interface Segregation**: Many client-specific interfaces are better than one general-purpose interface
- **Dependency Inversion**: Depend on abstractions, not concretions

### Class Design
- Keep classes small and focused
- Prefer composition over inheritance
- Use interfaces to define contracts
- Make properties private or protected unless they need to be public
- Use constructor dependency injection
- Consider making classes final when they aren't designed for extension
- Use abstract classes for base functionality
- Implement appropriate design patterns

### Method Design
- Keep methods small and focused on a single task
- Follow the Command-Query Separation principle
- Avoid side effects in methods when possible
- Return early to avoid deep nesting
- Limit the number of parameters (consider value objects for many parameters)
- Use method chaining where appropriate
- Validate inputs at the beginning of methods

## Error Handling & Security

### Error Handling
- Use exceptions for error conditions, not return codes
- Create custom exception hierarchies for your application
- Catch exceptions at appropriate levels
- Include meaningful error messages
- Log exceptions with appropriate context
- Use finally blocks to ensure resource cleanup
- Consider using `try`/`catch` blocks around external API calls

### Security Best Practices
- Sanitize all user inputs
- Use prepared statements with parameterized queries for database operations
- Validate form inputs and API parameters
- Implement CSRF protection for forms
- Use `password_hash()` and `password_verify()` for password management
- Set appropriate HTTP security headers
- Follow OWASP security guidelines
- Escape output with `htmlspecialchars()` to prevent XSS
- Use Content Security Policy (CSP) headers
- Implement rate limiting for authentication attempts

## Performance Optimization

### Database Optimization
- Use indexes for frequently queried columns
- Minimize the number of database queries
- Use JOINs instead of multiple queries where appropriate
- Implement caching for expensive queries
- Keep transactions as short as possible
- Use database connection pooling in production
- Consider using query builders or ORMs for complex queries
- Be careful with N+1 query problems

### Code Optimization
- Use opcode caching (OPcache)
- Optimize loops and recursive functions
- Minimize use of global variables and static methods
- Use appropriate data structures (arrays, collections, etc.)
- Consider memory usage for large datasets
- Profile code to identify bottlenecks
- Use appropriate caching strategies (APCu, Redis, Memcached)
- Optimize autoloading

## Testing

### Unit Testing
- Write unit tests for all non-trivial methods and functions
- Use PHPUnit or Pest for testing
- Aim for high test coverage of business logic
- Mock external dependencies
- Write both positive and negative test cases
- Test edge cases and boundary conditions
- Follow the Arrange-Act-Assert pattern
- Invoke assert static way (i.e. `Assert::assertEquals(...))`. Ensure presence of required `use` enty

### Integration Testing
- Test component interactions
- Test database interactions
- Test external API integrations
- Use appropriate fixtures and data providers
- Consider using database transactions for test isolation
- Reset state between tests

### Test-Driven Development
- Consider writing tests before implementation
- Run tests frequently during development
- Refactor code once tests pass
- Maintain and update tests as requirements change