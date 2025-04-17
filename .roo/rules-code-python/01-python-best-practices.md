# Python Best Practices

When writing Python code, follow these best practices:

## Code Style & Readability

### PEP 8 Compliance
- Target Python 3.12 or newer
- Always use virtual environment named `venv` using built-in `venv` module
- Use 4 spaces for indentation (not tabs)
- Limit lines to 120 characters for code and docstrings/comments
- Use blank lines to separate functions, classes, and logical sections
- Follow naming conventions:
  - `snake_case` for functions, methods, and variables
  - `PascalCase` for classes
  - `UPPER_CASE` for constants
- Use meaningful, descriptive names for variables, functions, and classes

### The Zen of Python
Follow "The Zen of Python" (PEP 20) principles:
```python
import this
```
Particularly emphasize:
- Beautiful is better than ugly
- Explicit is better than implicit
- Simple is better than complex
- Readability counts
- Special cases aren't special enough to break the rules
- Errors should never pass silently

### Comments & Documentation
- Write docstrings for all public modules, functions, classes, and methods
- Use Google style, NumPy style, or reStructuredText format consistently
- Include type hints in function signatures (PEP 484)
- Document parameters, return values, and exceptions raised
- Add comments to explain "why" not "what" the code does
- Keep comments up-to-date with code changes

## Modern Python Features

### Type Hints
- Use type annotations for function arguments and return values
- Leverage `typing` module for complex types (List, Dict, Optional, Union, etc.)
- Consider using runtime type checking tools (mypy, pyright)
- Use type aliases for complex types
```python
from typing import Dict, List, Optional, Union

UserRecord = Dict[str, Union[str, int, bool]]

def process_user(user: UserRecord) -> Optional[str]:
    ...
```

### F-strings
- Prefer f-strings over other string formatting methods
```python
name = "World"
# Good
message = f"Hello, {name}!"
# Avoid
message = "Hello, %s!" % name
message = "Hello, {}!".format(name)
```

### Walrus Operator (Python 3.8+)
- Use assignment expressions when it improves readability
```python
# Instead of
data = get_data()
if data:
    process(data)

# Consider
if data := get_data():
    process(data)
```

### Structural Pattern Matching (Python 3.10+)
- Use pattern matching for complex conditional logic
```python
match command.split():
    case ["quit"]:
        return "Exiting"
    case ["load", filename]:
        return f"Loading {filename}"
    case ["save", filename]:
        return f"Saving {filename}"
    case _:
        return "Unknown command"
```

## Functions & Methods

### Function Design
- Follow the Single Responsibility Principle
- Keep functions focused and small (generally < 50 lines)
- Aim for functions that do one thing well
- Use default parameter values instead of conditional logic
- Return early to avoid deep nesting

### Arguments
- Limit positional arguments to improve readability
- Use keyword arguments for clarity
- Consider using `*args` and `**kwargs` for flexibility when appropriate
- Define parameter types and return types with annotations

### Error Handling
- Use exceptions rather than return codes
- Catch specific exceptions, not `Exception`
- Use context managers (`with` statement) for resource management
- Create custom exceptions for your application's error cases
- Always clean up resources in `finally` blocks or use context managers

## Data Structures & Algorithms

### Built-in Types
- Use list comprehensions instead of `map()` and `filter()` when appropriate
- Prefer generators for large datasets to save memory
- Use sets for membership testing and removing duplicates
- Use dictionaries for fast lookups
- Use named tuples or dataclasses for representing simple data objects

### Collections Module
- Use `defaultdict` for handling missing keys
- Use `Counter` for counting occurrences
- Use `deque` for efficient queue operations
- Use `ChainMap` for combining multiple dictionaries

### Iteration
- Use `enumerate()` when you need indices
- Use `zip()` to iterate over multiple sequences
- Use `itertools` for efficient iteration patterns
- Make your classes iterable when appropriate by implementing `__iter__` and `__next__`

## Testing & Quality Assurance

### Unit Testing
- Write unit tests for all non-trivial functions and methods
- Use pytest or unittest for test frameworks
- Aim for high test coverage, especially for critical paths
- Use parameterized tests for testing multiple inputs
- Write tests for edge cases and boundary conditions

### Linting & Static Analysis
- Use linters like flake8, pylint, or ruff
- Run static type checkers like mypy
- Configure pre-commit hooks to ensure quality checks before committing
- Use code formatting tools like black or yapf
- Consider code complexity metrics (cyclomatic complexity)