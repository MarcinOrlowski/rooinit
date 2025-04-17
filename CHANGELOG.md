# Changelog

* 2025-04-17
  * Added new `code-javascript` agent with mode definition and instruction files.
  * Added Git workflow guidelines (branch naming, semantic commits, PR messages) to custom mode instructions.
  * Added `04-git-workflow.md` rule files for `code`, `code-php`, `code-python`, `code-bash`, and `debug` modes.
  * Refactored `.roomodes` to remove embedded Git workflow instructions, relying on rule files instead.
  * Fixed JSON syntax errors (trailing commas) in `.roomodes` after removing instructions.
  * Updated `rooinit.sh` to automatically add `.roo` and `.roomodes` to `.gitignore` upon initialization.
