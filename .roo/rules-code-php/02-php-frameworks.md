# PHP Frameworks & Libraries

Guidance for working with popular PHP frameworks and libraries.

## Laravel

### Laravel Best Practices
- Follow Laravel's directory structure and naming conventions
- Use Laravel's built-in features rather than reinventing the wheel
- Implement proper validation using Form Requests
- Use Eloquent ORM effectively with proper relationships
- Implement Repository pattern for complex database operations
- Use Laravel's authentication system for security
- Leverage middleware for cross-cutting concerns
- Use Laravel Mix for asset compilation
- Follow RESTful conventions for API endpoints
- Use Resource classes for API responses
- Implement proper exception handling
- Use Laravel's queue system for background processing
- Use Laravel's event system for decoupled architecture
- Implement proper caching strategies

### Eloquent ORM Usage
- Define proper relationships between models
- Use eager loading to prevent N+1 query issues
- Create model factories for testing
- Use model observers for cross-cutting concerns
- Implement proper scopes for query reusability
- Use query builders for complex queries
- Implement soft deletes when appropriate
- Use model events judiciously
- Implement proper validation in models or form requests
- Use Eloquent accessors and mutators for data transformation
- Consider custom collections for specialized model collections

### Laravel Security
- Use Laravel's CSRF protection
- Implement proper authentication and authorization
- Use Gates and Policies for authorization
- Sanitize user inputs through validation
- Use Laravel's encryption facilities
- Implement proper file upload validation and restrictions
- Set up proper environment configuration
- Use .env files for sensitive configuration
- Implement rate limiting for APIs
- Follow Laravel Security best practices

## Symfony

### Symfony Best Practices
- Follow Symfony's directory structure and conventions
- Use Symfony's dependency injection container
- Create reusable bundles for modular functionality
- Use Symfony's form system for input handling
- Implement proper validation using constraints
- Use Doctrine ORM effectively
- Leverage Symfony's security component
- Use Symfony's event dispatcher for decoupled architecture
- Implement proper logging and error handling
- Use Twig templating engine effectively
- Follow Symfony's coding standards
- Use Symfony's console component for CLI commands

### Doctrine ORM Usage
- Define proper entity relationships
- Use repositories for database queries
- Implement custom repository methods when needed
- Use Doctrine query builder for complex queries
- Implement proper validation in entities
- Use data fixtures for testing
- Consider using Doctrine migrations for schema changes
- Use proper caching strategies
- Be aware of lazy loading vs. eager loading
- Use Doctrine events judiciously

### Symfony Security
- Implement proper authentication and authorization
- Use voters for fine-grained permission checks
- Sanitize user inputs through validation
- Use Symfony's CSRF protection
- Implement proper password handling
- Set up proper environment configuration
- Use .env files for sensitive configuration
- Follow Symfony Security best practices

## Popular Libraries

### Composer Package Management
- Create a proper composer.json file
- Specify precise version constraints
- Use composer.lock for reproducible builds
- Organize autoloading efficiently
- Follow PSR-4 autoloading standard
- Consider creating custom packages for reusable code
- Use composer scripts for common tasks
- Update dependencies regularly
- Check for security vulnerabilities with composer audit

### PHPUnit
- Write comprehensive unit tests
- Use data providers for multiple test cases
- Mock dependencies appropriately
- Use fixtures for test data
- Test both success and failure scenarios
- Configure PHPUnit properly for your project
- Run tests regularly during development
- Consider using test doubles (mocks, stubs, etc.)

### Monolog
- Configure appropriate log channels
- Use proper log levels (debug, info, warning, error, etc.)
- Implement context in log messages
- Configure appropriate handlers (file, database, email, etc.)
- Set up log rotation
- Consider using processors for additional context

### Guzzle
- Use Guzzle for HTTP requests
- Configure appropriate timeouts
- Handle exceptions properly
- Use middleware for cross-cutting concerns
- Consider using asynchronous requests for performance
- Implement proper retry strategies

### Carbon
- Use Carbon for date and time manipulation
- Leverage Carbon's fluent interface
- Use Carbon's localization features
- Be aware of timezone issues
- Use proper formatting methods

### Flysystem
- Use Flysystem for filesystem abstraction
- Implement proper file validation
- Use appropriate adapters (local, S3, etc.)
- Handle exceptions properly
- Consider using caching

## API Development

### RESTful API Best Practices
- Use proper HTTP methods (GET, POST, PUT, DELETE, etc.)
- Implement appropriate status codes
- Use proper content negotiation
- Implement pagination for large collections
- Use proper error responses
- Document your API (OpenAPI/Swagger)
- Implement proper validation
- Use API resources for response transformation
- Consider using API versioning
- Implement proper rate limiting

### JWT Authentication
- Use secure algorithms (RS256 or ES256)
- Set appropriate token expiration
- Include only necessary claims
- Implement proper token validation
- Consider using refresh tokens
- Store tokens securely
- Implement proper CORS handling

### GraphQL
- Define proper schema
- Implement resolvers effectively
- Use proper type definitions
- Consider using dataloaders for N+1 query prevention
- Implement proper error handling
- Consider using pagination
- Implement proper authentication and authorization
- Document your schema