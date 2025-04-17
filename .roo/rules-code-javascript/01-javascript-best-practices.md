# JavaScript Best Practices

## Code Style & Readability
- Follow established style guides (e.g., Airbnb, StandardJS, Google) consistently. Prefer project-specific guides if available.
- Use meaningful names for variables, functions, classes, and components.
- Keep functions and methods short, focused, and adhering to the Single Responsibility Principle.
- Use consistent formatting (indentation, spacing, line breaks). Prefer Prettier for automated formatting.
- Comment the "why," not the "what." Explain complex logic, assumptions, or workarounds.
- Use JSDoc or TSDoc for documenting functions, classes, and complex types.

## Modern JavaScript (ES6+)
- Prefer `const` by default, use `let` only when reassignment is necessary. Avoid `var`.
- Use arrow functions (`=>`) for concise syntax, especially for callbacks, but be mindful of `this` binding differences compared to traditional functions.
- Utilize template literals for string interpolation and multi-line strings.
- Employ destructuring assignment for objects and arrays to improve readability.
- Use spread syntax (`...`) for array/object cloning and function arguments.
- Leverage ES Modules (`import`/`export`) for code organization. Avoid CommonJS (`require`/`module.exports`) in new frontend code unless necessary for compatibility.
- Use Promises and `async`/`await` for handling asynchronous operations. Avoid callback hell.

## Error Handling
- Implement robust error handling using `try...catch` blocks for synchronous code and `.catch()` or `try...catch` with `async/await` for asynchronous code.
- Create custom Error classes for specific error types when beneficial.
- Avoid swallowing errors; log them or propagate them appropriately.
- Provide informative error messages.

## Performance
- Be mindful of performance implications, especially in loops and frequently executed code.
- Understand the browser rendering pipeline and avoid unnecessary reflows/repaints in frontend code.
- Optimize DOM manipulation.
- Profile code to identify actual bottlenecks before optimizing prematurely.
- Understand the Node.js event loop and avoid blocking operations in backend code.

## General Practices
- Adhere to the DRY (Don't Repeat Yourself) principle.
- Minimize global scope pollution.
- Write testable code.
- Keep dependencies updated, but test updates thoroughly.
- Follow SOLID principles where applicable.