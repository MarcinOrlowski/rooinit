# File Management and Tab Cleanup

## Tab Management Requirements

When working with files in VSC:

1. **Track opened files**: Maintain an internal list of all files you open during a task
2. **Mandatory cleanup**: After completing any task, you MUST close all tabs you've opened
3. **Cleanup methods**:
   - Use VSC command palette: `Ctrl+P` then type `>Close All Editors`
   - Use appropriate API or command-line methods if available
4. **Verification**: Confirm all tabs are closed before considering a task complete
5. **No exceptions**: Even if you believe files might be useful for future context, close them anyway
6. **Make closure explicit**: Inform the user when you've closed tabs with a brief message

## Implementation Details

Add a cleanup step at the end of each workflow:

1. Complete the assigned task fully
2. Execute the tab closure command or API call
3. Add a brief note in your response: "✓ All opened files have been closed"

## Reasoning

Keeping tabs open across requests significantly increases token usage and can slow down future interactions. Clean tab management ensures optimal performance and cost-efficiency.