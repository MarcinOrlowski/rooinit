# Frameworks & Libraries

## General Principles
- Understand the core concepts and lifecycle of the specific framework/library being used (e.g., React component lifecycle, Angular change detection, Vue reactivity, Node.js event loop).
- Follow framework-specific best practices and conventions.
- Leverage built-in features and utilities provided by the framework before introducing external dependencies.
- Keep framework and library versions updated, paying attention to breaking changes and migration guides.
- Structure applications according to established patterns within the framework's ecosystem (e.g., feature folders, atomic design).

## Frontend Frameworks (React, Angular, Vue, etc.)
- **Component Design**: Create small, reusable, and well-defined components. Separate container (logic) components from presentational (UI) components where appropriate.
- **State Management**: Choose an appropriate state management solution based on application complexity (e.g., local component state, Context API, Redux, Zustand, Pinia, NgRx). Avoid prop drilling excessively.
- **Routing**: Use the framework's recommended routing library (e.g., React Router, Angular Router, Vue Router).
- **Performance**: Be mindful of rendering performance. Use techniques like memoization (React.memo, useMemo), virtual scrolling, code splitting, and lazy loading. Understand framework-specific optimization techniques.
- **Accessibility (a11y)**: Build accessible components and follow WCAG guidelines. Utilize framework features that support accessibility.

## Backend Frameworks (Node.js - Express, Koa, NestJS, etc.)
- **Middleware**: Understand and utilize middleware effectively for concerns like logging, authentication, validation, and error handling.
- **Routing**: Define clear and consistent API routes.
- **Asynchronous Operations**: Handle asynchronous operations (database queries, external API calls) efficiently using `async/await` and Promises. Avoid blocking the event loop.
- **Error Handling**: Implement centralized error handling middleware.
- **Security**: Apply security best practices relevant to backend development (input validation, output encoding, authentication/authorization, rate limiting, helmet.js or similar).
- **Database Interaction**: Use ORMs (e.g., Prisma, Sequelize, TypeORM) or query builders appropriately. Handle connections and pooling correctly.

## TypeScript Specifics
- Leverage TypeScript's static typing to improve code quality and catch errors early.
- Use interfaces and types effectively to define data structures and contracts.
- Utilize utility types (Partial, Pick, Omit, etc.) to manipulate types.
- Configure `tsconfig.json` appropriately for the project, enabling strict checks (`strict: true`).
- Understand type inference and when explicit type annotations are necessary.