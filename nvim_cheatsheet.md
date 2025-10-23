# Neovim Configuration Cheat Sheet

## Leader Keys
- **Leader**: `Space`
- **Local Leader**: `,`

## Basic Vim Shortcuts

### Navigation
- `h j k l` - Move left, down, up, right
- `w` - Move forward by word
- `b` - Move backward by word
- `0` - Move to beginning of line
- `$` - Move to end of line
- `gg` - Go to top of file
- `G` - Go to bottom of file
- `Ctrl+u` - Scroll up half page
- `Ctrl+d` - Scroll down half page
- `Ctrl+o` - Jump back to previous location
- `Ctrl+i` - Jump forward to next location

### Editing
- `i` - Insert mode before cursor
- `a` - Insert mode after cursor
- `o` - Insert new line below and enter insert mode
- `O` - Insert new line above and enter insert mode
- `dd` - Delete current line
- `yy` - Yank (copy) current line
- `p` - Paste after cursor
- `P` - Paste before cursor
- `u` - Undo
- `Ctrl+r` - Redo
- `x` - Delete character under cursor
- `r` - Replace character under cursor

### Visual Mode
- `v` - Visual mode (character selection)
- `V` - Visual line mode
- `Ctrl+v` - Visual block mode
- `y` - Yank selection
- `d` - Delete selection

### Search & Replace
- `/` - Search forward
- `?` - Search backward
- `n` - Next search result
- `N` - Previous search result
- `:%s/old/new/g` - Replace all occurrences

## Plugin Shortcuts

### Telescope (File Navigation)
- `<leader>ff` - Find files
- `<leader>fg` - Live grep (search in files)
- `<leader>fb` - Browse buffers
- `<leader>fh` - Help tags

### Neo-tree (File Explorer)
- `<leader>e` - Toggle file explorer

### Comment.nvim (Code Commenting)
- `gcc` - Toggle comment on current line
- `gc` - Toggle comment (linewise)
- `gbc` - Toggle block comment on current line
- `gb` - Toggle block comment

### LSP (Language Server Protocol)
- `gD` - Go to declaration
- `gd` - Go to definition
- `K` - Show hover information
- `gi` - Go to implementation
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions
- `gr` - Find references
- `<leader>f` - Format code

### Window Management
- `Ctrl+w h` - Move to left window
- `Ctrl+w j` - Move to bottom window
- `Ctrl+w k` - Move to top window
- `Ctrl+w l` - Move to right window
- `Ctrl+w v` - Split window vertically
- `Ctrl+w s` - Split window horizontally
- `Ctrl+w q` - Close current window

### Buffer Management
- `:bnext` or `:bn` - Next buffer
- `:bprev` or `:bp` - Previous buffer
- `:bd` - Delete/close buffer
- `:ls` - List all buffers

## Features Enabled

### Auto-completion & Pairs
- Automatic bracket, quote, and parentheses pairing
- Smart indentation

### Git Integration (Gitsigns)
- Git change indicators in the gutter
- Visual indicators for added (`│`), changed (`│`), deleted (`_`) lines

### Syntax Highlighting (Treesitter)
- Enhanced syntax highlighting for:
  - Lua, Vim, JavaScript, TypeScript
  - Python, HTML, CSS, JSON, YAML, Markdown

### Language Servers (LSP)
- **Lua**: lua_ls
- **Python**: pyright  
- **JavaScript/TypeScript**: tsserver
- Automatic installation via Mason

### Theme
- **Vesper** colorscheme with true color support

## Configuration Details

### Editor Settings
- Line numbers with relative numbering
- 2-space indentation
- No swap files, persistent undo
- Case-insensitive search (smart case)
- Clipboard integration with system
- 80-character color column
- Mouse support enabled
- Auto-split below and right

### Performance Optimizations
- Lazy loading for most plugins
- Disabled unused vim plugins (gzip, netrw, etc.)
- Fast updatetime (50ms)

## Quick Tips
- Use `<leader>ff` to quickly find files
- Use `<leader>fg` to search within files
- Press `K` on any function/variable for documentation
- Use `<leader>e` to toggle the file tree
- Comment code quickly with `gcc`
- Format code with `<leader>f`