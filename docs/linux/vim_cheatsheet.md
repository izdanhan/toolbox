
# Vim Cheat Sheet & Guide

Vim is a highly configurable text editor built to include almost all features users could need for an editor. Here's a comprehensive guide to Vim commands and operations:

## Basic Navigation

| **Command** | **Action** |
|-------------|------------|
| `h` | Move left |
| `j` | Move down |
| `k` | Move up |
| `l` (or `;`) | Move right |
| `w` | Move to next word |
| `b` | Move to previous word |
| `e` | Move to end of word |
| `ge` | Move to beginning of word |
| `0` (zero) | Move to start of line |
| `$` | Move to end of line |
| `gg` | Go to first line |
| `G` | Go to last line |
| `:{number}` | Go to specific line number |

## Insert Mode Commands

Use these to start editing text:

| **Command** | **Action** |
|-------------|------------|
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `o` | Insert on new line below |
| `O` | Insert on new line above |
| `s` | Delete and insert |

Switch back to **Normal Mode** with: `Esc`

## Basic Text Editing

| **Command** | **Action** |
|-------------|------------|
| `x` | Delete single character |
| `dw` | Delete word |
| `dd` | Delete line |
| `d{motion}` | Delete text with specified motion |
| `y{motion}` | Copy text |
| `yy` | Copy current line |
| `p` | Paste after cursor |
| `P` | Paste before cursor |
| `u` | Undo |
| `Ctrl+r` | Redo |

## Visual Mode (Selecting Text)

| **Command** | **Action** |
|-------------|------------|
| `v` | Start visual mode (character-wise) |
| `V` | Start visual mode (line-wise) |
| `Ctrl-v` | Start visual mode (block-wise) |
| `y` | Copy selected text |
| `d` | Delete selected text |
| `c` | Cut (delete and enter insert mode) |
| `>` | Indent selected text |
| `<` | Outdent selected text |

## Searching and Replacing

| **Command** | **Action** |
|-------------|------------|
| `/` | Start search |
| `n` | Find next occurrence |
| `N` | Find previous occurrence |
| `*` | Find next occurrence of word under cursor |
| `:%s/old/new/g` | Replace all occurrences of "old" with "new" |

## File Operations

| **Command** | **Action** |
|-------------|------------|
| `:w` | Save file |
| `:w!` | Force save |
| `:w [filename]` | Save as different file |
| `:e [filename]` | Edit another file |
| `:q` | Quit |
| `:wq` or `:x` | Save and quit |
| `:q!` | Quit without saving |

## Other Useful Commands

| **Command** | **Action** |
|-------------|------------|
| `:set number` | Show line numbers |
| `:set nowrap` | Disable line wrapping |
| `:.!` | Force execution of a shell command |
| `:%!sort` | Sort lines (works in Normal mode) |
| `Ctrl-g` | Show current position and mode |

## Vim Cheat Sheet Reference

| **Mode** | **Commands** |
|----------|--------------|
| **Normal** | `hjkl`, `w`, `b`, `e`, `0`, `$`, `gg`, `G`, `x`, `dw`, `dd`, `y`, `p`, `/`, `n`, `N`, `u`, `Ctrl+r`, `gg`, `G`, `:w`, `:q`, `:x`, `:set` |
| **Insert** | `i`, `a`, `o`, `O`, `s` |
| **Visual** | `v`, `V`, `Ctrl-v`, `y`, `d`, `c`, `>`, `<` |

## Tips for Vim Beginners

1. **Use the colon (:)** for almost any command
2. **Esc** frequently to return to Normal mode
3. Use `Ctrl + R` to insert the result of a Vim command
4. Use `:help {command}` at any time for help (e.g., `:help i` for insert commands)
5. Consider using `:set relativenumber` for a more dynamic line numbering system

## Common Abbreviations

- `noh` - Clear search highlight
- `nmap` - Create a new mapping
- `unmap` - Remove a mapping
- `set ts=4` - Set tab size to 4 spaces
- `set sw=4` - Set shift width (indent size)

## Advanced Navigation

| **Command** | **Action** |
|-------------|------------|
| `Ctrl-o` | Jump to previous position |
| `Ctrl-i` | Jump to next position |
| `Ctrl-]` | Go to the definition of the word under cursor |
| `Ctrl-w` | Resize windows |

This guide covers the most common Vim commands and operations. Practice these regularly to become more efficient with Vim!
