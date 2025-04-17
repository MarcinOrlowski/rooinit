# Architectural Patterns & Principles

When designing software systems, consider these architectural patterns and principles:

## Architectural Styles & Patterns

### Monolithic Architecture
- Simpler development and deployment process
- Easier to test and debug as a single unit
- May be appropriate for smaller applications or initial MVPs
- Consider future decomposition options if growth is expected

### Microservices Architecture
- Enables independent development and deployment of services
- Allows different technology stacks for different services
- Improves fault isolation and resilience
- Increases operational complexity and requires solid DevOps practices
- Consider service boundaries based on business domains (Domain-Driven Design)

### Layered Architecture
- Separation of concerns through distinct layers (presentation, business, data)
- Clear dependencies between layers (upper layers depend on lower layers)
- Promotes code organization and maintainability
- May lead to unnecessary coupling if not carefully designed

### Event-Driven Architecture
- Decouples components through event producers and consumers
- Enables asynchronous processing and better scalability
- Works well for systems with complex workflows or integrations
- Consider event schemas, versioning, and delivery guarantees

### Serverless Architecture
- Reduces operational overhead and infrastructure management
- Pay-per-use pricing model
- Function-oriented design with managed services
- Consider cold start latency and vendor lock-in implications

## Key Architectural Principles

### Separation of Concerns
- Divide the system into distinct features with minimal overlap
- Isolate business logic from infrastructure and UI concerns
- Use interfaces to define clear component boundaries

### Single Responsibility Principle
- Each component should have one reason to change
- Avoid mixing different concerns in the same component
- Consider both technical and business responsibilities

### Don't Repeat Yourself (DRY)
- Extract common functionality into reusable components
- Maintain a single source of truth for business rules
- Balance with pragmatic duplication when necessary

### YAGNI (You Aren't Gonna Need It)
- Avoid speculative generality and over-engineering
- Build for current requirements with extension points for the future
- Prefer simplicity over unnecessary flexibility

### Principle of Least Knowledge (Law of Demeter)
- Components should only communicate with immediate dependencies
- Reduce coupling between distant components
- Use facades or mediators to simplify complex interactions

## Quality Attributes & Trade-offs

Always consider these quality attributes in your architectural decisions:

1. **Performance** - Response time, throughput, resource utilization
2. **Scalability** - Ability to handle growing load by adding resources
3. **Reliability** - System availability and fault tolerance
4. **Security** - Protection against threats and vulnerabilities
5. **Maintainability** - Ease of making changes and fixing issues
6. **Testability** - Ability to effectively test the system
7. **Deployability** - Ease of deploying the system to production
8. **Observability** - Ability to monitor and troubleshoot the system

Remember that architectural decisions always involve trade-offs between these attributes. Make these trade-offs explicit in your designs.


## Other rules
- Be Concise: Use clear and concise language in your prompts. Avoid unnecessary words or details.