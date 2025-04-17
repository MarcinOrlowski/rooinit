# Python Frameworks & Libraries

Guidance for working with popular Python frameworks and libraries.

## Web Development

### Django
- Follow the Django project structure and naming conventions
- Use Django's ORM properly with select_related/prefetch_related to prevent N+1 queries
- Leverage Django's built-in security features (CSRF, XSS protection, etc.)
- Use class-based views for reusable view logic
- Keep views thin, move business logic to models or service layers
- Use Django forms for validation
- Implement proper permission checks
- Follow REST best practices with Django REST Framework
- Use Django's testing tools for views, models, and forms

### Flask
- Follow the application factory pattern for flexibility
- Use Blueprints for organizing routes
- Leverage Flask extensions for common functionality
- Implement proper error handling
- Use Flask-SQLAlchemy for database operations
- Consider Flask-RESTful or Flask-RESTX for building APIs
- Implement proper authentication and authorization
- Use Flask's context locals carefully to avoid memory leaks
- Test with pytest and Flask's test client

### FastAPI
- Leverage automatic request validation using Pydantic models
- Use dependency injection for shared components
- Take advantage of async functionality for I/O-bound operations
- Document APIs using OpenAPI and Swagger UI
- Implement proper exception handling with HTTPException
- Use proper status codes and response models
- Implement middleware for cross-cutting concerns
- Use proper authentication and security schemes
- Test with TestClient from FastAPI.testclient

## Data Science & Machine Learning

### NumPy
- Use vectorized operations instead of explicit loops
- Avoid unnecessary copies of large arrays
- Use broadcasting for efficient operations
- Leverage numpy's random module for reproducible results
- Use appropriate data types to save memory
- Use memory-mapped files for very large datasets
- Apply masking operations for conditional logic

### Pandas
- Use vectorized operations instead of apply when possible
- Chain operations for clarity but be aware of performance implications
- Use appropriate data types (categories, sparse arrays)
- Handle missing data explicitly (fillna, dropna)
- Use method chaining for data transformations
- Use loc/iloc for explicit indexing
- Apply groupby operations effectively
- Use pandas' built-in time series functionality

### SciPy
- Use specialized submodules for specific tasks
- Leverage sparse matrices for large, sparse datasets
- Use optimized algorithms for numerical operations
- Apply statistical functions appropriately
- Use domain-specific routines for signal processing, image processing, etc.

### Scikit-learn
- Follow the fit/transform/predict pattern consistently
- Use pipelines for preprocessing and model training
- Perform proper cross-validation
- Handle class imbalance appropriately
- Scale features when necessary
- Tune hyperparameters methodically
- Evaluate models with appropriate metrics
- Monitor for data leakage

### PyTorch/TensorFlow
- Use GPU acceleration when available
- Implement proper data loading pipelines
- Batch data appropriately for memory constraints
- Structure models using higher-level APIs when possible
- Implement proper training loops with validation
- Use learning rate schedules
- Save and load models correctly
- Apply regularization techniques as needed
- Implement callbacks for monitoring training

## Asynchronous Programming

### asyncio
- Use `async`/`await` syntax over older coroutine styles
- Create tasks for concurrent operations
- Use proper error handling in coroutines
- Avoid blocking calls in async code
- Use asyncio.gather for concurrent tasks
- Consider thread pools for CPU-bound tasks
- Implement proper cancellation handling
- Use async context managers for resource management

### aiohttp
- Use session context managers
- Make concurrent requests with gather
- Handle connection pooling appropriately
- Implement proper timeouts
- Handle errors and retries
- Use streaming responses for large payloads

## DevOps & Tooling

### Packaging & Distribution
- Use pyproject.toml for modern Python packaging
- Create proper setup.py or setup.cfg for compatibility
- Define dependencies with appropriate version constraints
- Use virtual environments for isolation
- Consider containerization with Docker
- Set up CI/CD pipelines for testing and deployment

### Environment Management
- Use virtual environments for project isolation
- Consider conda for complex dependencies
- Use .env files for environment variables
- Keep development, testing, and production environments consistent
- Use dependency pinning for reproducibility

### Logging & Monitoring
- Use the built-in logging module
- Configure appropriate log levels
- Include contextual information in logs
- Implement structured logging when possible
- Consider using specialized libraries for production logging
- Implement proper error tracking and alerting

## Database Interaction

### SQLAlchemy
- Use the ORM for database abstraction
- Define models with proper relationships
- Use session management correctly
- Implement proper transaction handling
- Use eager loading to prevent N+1 query problems
- Optimize queries for performance
- Use connection pooling

### Database Best Practices
- Use connection pooling
- Implement proper migrations
- Use parameterized queries to prevent SQL injection
- Handle transactions properly
- Implement appropriate indexes
- Use database-specific features judiciously
- Consider query optimization for performance
- Implement proper error handling for database operations