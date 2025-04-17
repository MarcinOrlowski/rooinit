# RooInit - Easy Initialization of Roo Code projects

## Table of Contents

- [Introduction](#introduction)
- [Key Features & Behavior](#key-features--behavior)
- [Installation](#installation)
- [Usage Examples](#usage-examples)
- [Changelog](CHANGES.md)
- [License](#license)

---

## Introduction

`RooInit` is a helper script to set up custom rules and a custom agentic mode for projects where you want to use [Roo Code](https://roocode.com/). Please note this might not
be a tool for everyone out of the box. I designed it for my workflow, preferring project-specific configurations over global Roo Code rules, but your mileage may vary.

## Key Features & Behavior

The main concept is to keep all Roo Code related rules in a single centralized location for easy maintenance and editing, and then symlink to it from your project's directory.
The `RooInit` script simplifies setting up new projects for Roo Code by configuring the `.roomodes` and `.roo` directories within a specified target directory. By default,
it creates symbolic links pointing back to the original `.roomodes` and `.roo` directories located alongside the script (using absolute paths). This is useful for keeping
configurations centralized and not affecting any global Roo Code configuration. If you prefer to have a distinct copy of the configuration files in your target directory,
use the `--copy` flag. This option copies the entire `.roomodes` and `.roo` directories and their contents instead of creating symbolic links. It also sets up or updates
the `.gitignore` file to exclude Roo configurations from Git when using the default symlink mode. If you use the `--copy` option, you'll need to manage `.gitignore` entries
yourself if necessary.

## Installation

First, ensure the `rooinit.sh` script has execute bit set:

```bash
chmod +x <ROOINIT_DIR>/rooinit.sh
```

To make `RooInit` easily executable from anywhere in your terminal, you should add its containing directory (`<ROOINIT_DIR>`) to your shell's `PATH` environment variable.
You must replace `<ROOINIT_DIR>` with the actual absolute (recommended) path to the directory where you cloned or placed the `RooInit` script on your system.
Here's how to do it for common shells:

### Bash

Add the following line to your `~/.bashrc` or `~/.bash_profile` file (usually `~/.bashrc` for interactive shells):

```bash
export PATH="<ROOINIT_DIR>:$PATH"
```

### Fish

Use the `fish_add_path` command in your terminal:

```fish
fish_add_path <ROOINIT_DIR>
```

To make this change persistent across shell restarts, you can add this command to your `~/.config/fish/config.fish` file, or manage it using universal variables:

```fish
set -U fish_user_paths $fish_user_paths <ROOINIT_DIR>
```

Alternatively, you can set `$PATH` manually:

```fish
set PATH $PATH <ROOINIT_DIR>
```

### Zsh

Add the following line to your `~/.zshrc` file:

```zsh
export PATH="<ROOINIT_DIR>:$PATH"
```

**Note:** After modifying your shell configuration file, you'll need to either restart your terminal or source the configuration file (e.g., `source ~/.bashrc`, 
`source ~/.config/fish/config.fish`, or `source ~/.zshrc`) for the changes to take effect.

### Tip: Easier Invocation (Symlinking)

For easier command-line use, you can create a symlink named `rooinit` _within the script's own directory_ (`<ROOINIT_DIR>`), pointing to `rooinit.sh`. This allows
you to run `rooinit` instead of `rooinit.sh` while keeping the original file untouched for future Git updates:

```bash
cd <ROOINIT_DIR>
ln -s rooinit.sh rooinit
```

If `<ROOINIT_DIR>` is included in your shell's `$PATH` (as configured in the installation steps), you can then invoke the script simply by typing `rooinit` from anywhere. 

## Usage Examples

To set up Roo Code (using symlinks) in your current working directory:

```bash
rooinit
```

**Using the `--copy` option:**

To create a copy of the `.roomodes` and `.roo/` directories in your current working directory:

```bash
rooinit --copy
```

## License

- Written and copyrighted &copy;2025 by Marcin Orlowski <mail (#) marcinorlowski (.) com>
- RooInit is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT)
