# Git Workflow Guidelines

1.  **Branch Naming:**
    *   Use only lowercase letters, digits, and hyphens (`-`).
    *   If a ticket/issue number is associated with the work, prepend it to the branch name (e.g., `123-fix-login-bug`).

2.  **Commit Messages:**
    *   Follow the Semantic Commit Message format: `<type>(<scope>): <subject>`.
    *   `<scope>` is optional.
    *   Use the following types: `feat` (new feature), `fix` (bug fix), `docs` (documentation), `style` (formatting), `refactor` (code refactoring), `test` (adding/refactoring tests), `chore` (build/tool updates).
    *   The subject should be a concise summary in the present tense.
    *   Example: `feat(auth): implement password reset endpoint`
    *   Example: `fix: correct calculation error in totals`

3.  **Pull Request Messages:**
    *   If the work relates to a specific ticket/issue number, ensure the PR message includes text to automatically close it upon merging (e.g., `Closes #123`, `Fixes #456`).