# Language-Agnostic Best Practices

## Code style
- Use 4 spaces for indentation (not tabs)
- Limit lines to 120 characters for code and docstrings/comments
- Use blank lines to separate functions, classes, and logical sections or similar elements- Follow consistent naming conventions:
- Follow consistent naming conventions and unless language requires otherwise, keep the following as our defaults:
  - Classes: PascalCase
  - Methods and functions: camelCase
  - Constants: UPPER_CASE
  - Variables: camelCase
  - Namespaces: PascalCase

## Version Control
- Commit small, logical changes with descriptive messages
- Use feature branches for new development
- Review code changes carefully before merging
- Keep the main branch stable and deployable
- Tag important releases with semantic version numbers

## Documentation
- Document public APIs and interfaces
- Maintain up-to-date README files
- Document architectural decisions and their rationales
- Include setup instructions and examples
- Document non-obvious behavior and edge cases

## Project Organization
- Maintain a consistent project structure
- Separate configuration from code
- Group related functionality together
- Use appropriate encapsulation to hide implementation details
- Follow established conventions for the ecosystem

## Development Workflow
- Automate repetitive tasks
- Use linters and static analyzers
- Implement continuous integration
- Perform code reviews
- Maintain a comprehensive test suite

## Refactoring
- Refactor incrementally, not all at once
- Ensure tests pass before and after refactoring
- Address technical debt proactively
- Look for common code smells:
  - Long methods/functions
  - Duplicate code
  - Large classes
  - Feature envy
  - Primitive obsession
  - Long parameter lists

## Dependency Management
- Choose dependencies carefully
- Keep dependencies updated
- Prefer stable, well-maintained libraries
- Consider the licensing implications of dependencies
- Avoid deep dependency chains when possible