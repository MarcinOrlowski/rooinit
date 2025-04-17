# Custom Modes for Roo - Developer Guide

This document provides comprehensive guidance on creating and updating custom modes for Roo. It covers file structure, configuration options, best practices, and examples based on our work with custom specialized agents.

## Table of Contents

1. [Introduction to Custom Modes](#introduction-to-custom-modes)
2. [File Structure & Organization](#file-structure--organization)
3. [Creating Custom Modes](#creating-custom-modes)
4. [Mode Configuration Fields](#mode-configuration-fields)
5. [Style Guidelines & Best Practices](#style-guidelines--best-practices)
6. [Creating Language-Specific Coding Agents](#creating-language-specific-coding-agents)
7. [Using Agents for Documentation](#using-agents-for-documentation)
8. [Updating Existing Modes](#updating-existing-modes)
9. [Common Pitfalls & Solutions](#common-pitfalls--solutions)
10. [Reference Examples](#reference-examples)

## Introduction to Custom Modes

Custom modes in Roo allow you to create specialized AI assistants with specific expertise, permissions, and behaviors. Each mode can have:

- A defined role and personality
- Specific file access permissions
- Detailed behavioral instructions
- Tool access permissions

Custom modes can be global (available across all projects) or project-specific (defined within a single project).

## File Structure & Organization

### Project-Specific Mode Configuration

Project-specific custom modes are defined in the `.roomodes` file in the project root:

```
/project_root/
├── .roomodes                  # JSON file containing mode definitions
├── .roo/                      # Directory for mode-specific instructions
│   ├── rules-mode-slug1/      # Directory for instructions for mode-slug1
│   │   ├── 01-basics.md
│   │   ├── 02-advanced.md
│   │   └── ...
│   ├── rules-mode-slug2/      # Directory for instructions for mode-slug2
│   │   └── ...
│   └── ...
└── ...
```

### Global Mode Configuration

Global custom modes are defined in the `custom_modes.json` file:

```
/.roo/
├── custom_modes.json          # JSON file containing global mode definitions
└── rules-mode-slug/           # Directory for global mode instructions
    ├── 01-basics.md
    ├── 02-advanced.md
    └── ...
```

### Mode-Specific Instructions

Instructions for each mode can be provided in a dedicated directory:

- `.roo/rules-{mode-slug}/` - Contains multiple instruction files that are loaded alphabetically
- Files can use any extension, but `.md` is recommended for readability
- Content is loaded recursively from all subdirectories

## Creating Custom Modes

### Basic Mode Creation Process

1. **Identify the purpose** of the custom mode (e.g., language-specific coding, specialized role)
2. **Add the mode definition** to `.roomodes` (project-specific) or `custom_modes.json` (global)
3. **Create mode-specific instruction files** in the corresponding rules directory
4. **Test the mode** to ensure it behaves as expected

### Minimal Mode Example

```json
{
  "customModes": [
    {
      "slug": "mode-slug",
      "name": "Display Name",
      "roleDefinition": "Concise definition of the mode's role and expertise",
      "groups": ["read", "edit"],
      "customInstructions": "Detailed behavioral guidelines for the mode"
    }
  ]
}
```

## Mode Configuration Fields

### Required Fields

- **slug**: Unique identifier for the mode (use lowercase with hyphens)
- **name**: Display name shown in the UI
- **roleDefinition**: Detailed description of the mode's role and expertise
- **groups**: Array of allowed tool groups (read, edit, command, browser, mcp)

### Optional Fields

- **customInstructions**: Detailed behavioral guidelines for the mode
- File restrictions for the "edit" group:
  ```json
  ["edit", {
    "fileRegex": "\\.md$",
    "description": "Markdown files only"
  }]
  ```

### File Restrictions

The `fileRegex` property uses regular expressions to control which files a mode can edit:
- `\\.md$` - Match files ending in ".md"
- `\\.(test|spec)\\.(js|ts)$` - Match test files (e.g., "component.test.js")
- `\\.(js|ts)$` - Match JavaScript and TypeScript files

## Style Guidelines & Best Practices

### Mode Definition Best Practices

1. **Clearly defined role**: The `roleDefinition` should clearly communicate the mode's expertise, personality, and scope
2. **Comprehensive instructions**: The `customInstructions` should provide specific guidelines for the mode's behavior
3. **Appropriate permissions**: Limit file access to only what's necessary for the mode's function
4. **Consistent naming**: Use descriptive, consistent names for modes and slugs

### Instruction Files Best Practices

1. **Organized structure**: Use numbered files (01-topic.md, 02-topic.md) for clear loading order
2. **Modular content**: Divide instructions into logical sections by topic
3. **Detailed examples**: Include concrete examples of desired behavior
4. **Specific guidance**: Provide explicit instructions rather than general guidelines

## Creating Language-Specific Coding Agents

Language-specific coding agents follow a specific naming pattern:

- **Slug**: `code-{language}` (e.g., `code-php`, `code-python`, `code-bash`)
- **Name**: `Code ({Language})` (e.g., `Code (PHP)`, `Code (Python)`, `Code (Bash)`)

### Key Components of a Language-Specific Agent

1. **Role Definition**: Emphasize expertise in the specific language, frameworks, and best practices
2. **File Restrictions**: Limit to file extensions for that language
3. **Custom Instructions**: Include language-specific style guidelines, best practices, and conventions
4. **Detailed Instruction Files**: Provide comprehensive guidance organized by topic

### Example Structure for Language-Specific Agents

```
/project_root/
├── .roomodes                            # Contains the agent definition
└── .roo/
    └── rules-code-{language}/           # Instructions directory
        ├── 01-{language}-best-practices.md
        ├── 02-frameworks-libraries.md
        ├── 03-{language}-security.md
        └── ...
```

## Using Agents for Documentation

### Selecting the Right Agent for Documentation Tasks

When creating technical documentation, it's important to use the appropriate agent to ensure accuracy and adherence to language-specific conventions:

1. **Language-Specific Documentation**: Use language-specific coding agents for documentation related to that language
   * Use `Code (Bash)` for shell script documentation
   * Use `Code (PHP)` for PHP framework documentation
   * Use `Code (Python)` for Python library documentation
   * This prevents technical inaccuracies in language-specific documentation

2. **When to Use Language-Specific Agents**:
   * README.md files for language-specific projects
   * API documentation for libraries or frameworks
   * Installation and usage guides for specific technologies
   * Code examples and usage patterns documentation
   * Technical specifications that require deep language knowledge

3. **When to Use Generic Agents**:
   * General project documentation not specific to any language
   * User-facing documentation without technical code details
   * Process or workflow documentation
   * Multi-language project documentation with balanced coverage

### Configuring Boomerang Mode for Documentation

Boomerang Mode should be configured to delegate documentation tasks appropriately:

```json
"Apply the same principle for technical documentation tasks. When documentation is related to a specific programming language or technology, delegate to the corresponding language-specific coding agent rather than the generic `Code` mode.
* Use language-specific agents for creating README.md files, API documentation, installation guides, and other technical documentation related to that language
* This is especially important for avoiding technical inaccuracies in documentation that requires deep language-specific knowledge
* For example, delegate Bash script documentation to `Code (Bash)`, PHP framework documentation to `Code (PHP)`, etc.
* Language-specific agents have the necessary expertise to accurately document idioms, best practices, and technical details specific to their domain
* Generic documentation without language-specific requirements can still be delegated to the `Architect` mode or general `Code` mode"
```

### Documentation Guidelines for Language-Specific Agents

Each language-specific agent should include documentation-related instructions:

1. **Documentation Standards**: Include language-specific documentation conventions
2. **Code Examples**: Guidelines for providing idiomatic examples
3. **API Documentation**: Formats and standards for API documentation
4. **README Structure**: Recommended README structure for projects in that language

### Example: Documentation Task Delegation

When a user asks to create a README for a Bash project, Boomerang Mode should:

1. Recognize this as a language-specific documentation task
2. Delegate to `Code (Bash)` instead of generic `Code` mode:
   ```
   new_task(
     mode="Code (Bash)",
     message="Create a comprehensive README.md for a Bash utility script project that [details]... 
     The README should follow standard Bash project documentation conventions and include proper 
     code examples with correct Bash syntax."
   )
   ```

## Updating Existing Modes

When updating existing modes:

1. **Read the current configuration** to understand the mode's current behavior
2. **Make incremental changes** to avoid breaking existing functionality
3. **Maintain consistent style** with the existing configuration
4. **Test changes** to ensure the mode behaves as expected
5. **Update all related files** (both the mode definition and instruction files)

### Example: Updating a Mode

```json
// Original mode definition
{
  "slug": "code",
  "name": "Code",
  "roleDefinition": "Basic role definition",
  "groups": ["read", "edit"],
  "customInstructions": "Basic instructions"
}

// Updated mode definition
{
  "slug": "code",
  "name": "Code",
  "roleDefinition": "Enhanced role definition with more specific expertise",
  "groups": ["read", "edit", "command"],
  "customInstructions": "Enhanced instructions with more detailed guidelines"
}
```

## Common Pitfalls & Solutions

### File Path Issues

**Problem**: Incorrect file paths for mode-specific instructions
**Solution**: Follow the exact directory structure: `.roo/rules-{mode-slug}/`

### Regular Expression Syntax

**Problem**: Incorrect regex syntax in file restrictions
**Solution**: Remember to escape backslashes in JSON: `"\\.js$"` not `"\.js$"`

### Missing Required Fields

**Problem**: Omitting required fields in mode definition
**Solution**: Always include all required fields (slug, name, roleDefinition, groups)

### Inconsistent Naming

**Problem**: Inconsistent naming between slug and instructions directory
**Solution**: Ensure the slug and directory name match exactly: `code-python` → `rules-code-python`

### Overlapping File Restrictions

**Problem**: Overlapping file restrictions between modes
**Solution**: Design file restrictions carefully to avoid conflicts

### Documentation Technical Inaccuracies

**Problem**: Generic Code agent creating documentation with technical mistakes
**Solution**: Use language-specific coding agents for technical documentation related to that language

## Reference Examples

### Complete Mode Definition Example (PHP Agent)

```json
{
  "slug": "code-php",
  "name": "Code (PHP)",
  "roleDefinition": "You are an advanced PHP developer with deep expertise in modern PHP practices, frameworks, and performance optimization. You specialize in writing clean, maintainable, and secure PHP code while following industry best practices. Your knowledge spans PHP 7.x and 8.x features, popular frameworks like Laravel and Symfony, Composer package management, and database interactions.",
  "groups": [
    "read",
    ["edit", {
      "fileRegex": "\\.(php|phtml)$",
      "description": "PHP files only"
    }],
    "command"
  ],
  "customInstructions": "When working with PHP code, focus on:\n\n1. Writing clean, efficient, and well-documented code that follows PSR standards\n2. Implementing proper error handling and security practices (preventing SQL injection, XSS, CSRF)\n3. Using type declarations and docblocks for improved code reliability\n4. Applying SOLID principles and design patterns where appropriate\n5. Suggesting modern PHP features and approaches to improve legacy code\n6. Optimizing database queries and performance bottlenecks\n7. Providing clear explanations for complex PHP concepts\n8. Testing code suggestions with built-in test capabilities or PHPUnit when appropriate\n9. Managing dependencies efficiently with Composer\n10. Refactoring code for improved maintainability\n\nWhen analyzing PHP code:\n- Identify potential security vulnerabilities\n- Point out performance bottlenecks\n- Suggest appropriate framework features when applicable\n- Recommend modern PHP alternatives to deprecated functions\n\nWhen generating new PHP code:\n- Use the latest PHP syntax appropriate for the project\n- Include detailed comments explaining complex logic\n- Structure code for testability and maintenance\n- Consider compatibility with the existing codebase"
}
```

### File-Specific Style Requirements Example (Bash Agent)

```json
{
  "slug": "code-bash",
  "name": "Code (Bash)",
  "roleDefinition": "You are an advanced shell script developer with deep expertise in Bash, shell utilities, and system administration. You excel at creating robust, efficient, and secure shell scripts for automation, system configuration, and maintenance tasks. Your knowledge spans POSIX compliance, performance optimization, error handling, and modern Bash features.",
  "groups": [
    "read",
    ["edit", {
      "fileRegex": "\\.(sh|bash|ksh|zsh)$",
      "description": "Shell script files only"
    }],
    "command"
  ],
  "customInstructions": "When writing or reviewing Bash code, adhere to these specific style requirements and best practices:\n\n1. Script Structure & Safety\n   * Always begin scripts with an appropriate shebang (#!/bin/bash)\n   * Use `set -euo pipefail` at the beginning of scripts to fail early and on errors\n   * Include clear usage information and help text\n   * Add descriptive header comments explaining purpose, inputs, and outputs\n   * Structure scripts with logical sections and clear flow\n\n2. Variable Usage & Declaration\n   * Always use `${variable}` syntax for variable references, not $variable\n   * Declare function-local variables with `local` and make them read-only when possible using `readonly`\n   * Make variables read-only as soon as their values are set and won't change\n   * Use uppercase for constants and environment variables\n   * Use lowercase for local variables and function names\n   * Quote variable expansions to prevent word splitting and globbing: \"${variable}\"\n\n[... additional instructions ...]"
}
```

### Boomerang Mode Documentation Delegation Example

```json
"customInstructions": "Your role is to coordinate complex workflows by delegating tasks to specialized modes. As an orchestrator, you should:\n\n...\n\nWhen delegating documentation tasks:\n* Use language-specific coding agents (like `Code (Bash)`, `Code (PHP)`) for creating technical documentation related to those languages\n* This ensures documentation contains accurate code examples, idioms, and best practices specific to that language\n* For example, delegate Bash script documentation to `Code (Bash)`, PHP framework documentation to `Code (PHP)`, etc.\n* Only use the generic `Code` mode for documentation that covers multiple languages or isn't language-specific\n* Be explicit about documentation standards and expectations in your delegation message\n..."
```

---

This guide covers the fundamentals of creating and managing custom modes for Roo. For more detailed information, refer to the official documentation at [https://docs.roocode.com/features/custom-modes/](https://docs.roocode.com/features/custom-modes/).