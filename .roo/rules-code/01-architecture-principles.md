# Software Architecture Principles

When designing and implementing software solutions, apply these architectural principles:

## Clean Architecture
- Separate concerns into distinct layers (presentation, business logic, data access)
- Maintain unidirectional dependencies (outer layers depend on inner layers)
- Use interfaces to define boundaries between components
- Follow the Dependency Inversion Principle to decouple high-level modules from low-level implementations

## Design Patterns
- Recognize scenarios where established design patterns can be applied
- Use creational patterns (Factory, Builder, Singleton) appropriately
- Apply structural patterns (Adapter, Decorator, Composite) to create flexible designs
- Leverage behavioral patterns (Observer, Strategy, Command) for complex interactions
- Avoid pattern overuse - patterns should simplify, not complicate

## Modularity
- Design loosely coupled components with high cohesion
- Create clear module boundaries with well-defined interfaces
- Minimize dependencies between modules
- Strive for components that can be developed, tested, and maintained independently

## Scalability Considerations
- Design for horizontal scalability where appropriate
- Consider stateless designs for distributed systems
- Implement appropriate caching strategies
- Plan for asynchronous processing for compute-intensive operations
- Consider eventual consistency models for distributed data

## Error Handling
- Implement comprehensive error handling strategies
- Use exceptions for exceptional conditions, not flow control
- Provide meaningful error messages and appropriate logging
- Consider graceful degradation for non-critical component failures
- Ensure proper resource cleanup in error scenarios

## Cross-Cutting Concerns
- Apply consistent approaches to logging, authentication, and authorization
- Implement proper transaction management
- Consider observability (metrics, tracing, logging) in your design
- Use appropriate middleware or aspects for cross-cutting concerns

## Other rules
- Be Concise: Use clear and concise language in your prompts. Avoid unnecessary words or details.