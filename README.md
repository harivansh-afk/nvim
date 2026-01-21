# nvim

## Installation

**Minimal (default)** - lightweight, no LSP, no AI completion:
```bash
curl -fsSL https://raw.githubusercontent.com/harivansh-afk/nvim/main/install.sh | bash
```

**Full install** - includes LSP + supermaven AI completion:
```bash
curl -fsSL https://raw.githubusercontent.com/harivansh-afk/nvim/main/install.sh | bash -s -- --bells-and-whistles
```

Other options:
```bash
--skip-nvim           # Config only (skip nvim install)
--skip-config         # Nvim only (skip config install)
--no-path             # Don't modify shell rc files
```

## Repo tree

```text
.
├── init.lua
├── install.sh
├── lazy-lock.json
├── lua
│   ├── chadrc.lua
│   └── plugins
│       ├── arrow.lua
│       ├── autopairs.lua
│       ├── comment.lua
│       ├── dashboard.lua
│       ├── flash.lua
│       ├── git.lua
│       ├── gitsigns.lua
│       ├── gutentags.lua
│       ├── lsp.lua
│       ├── neo-tree.lua
│       ├── nvchad.lua
│       ├── supermaven.lua
│       ├── telescope.lua
│       ├── treesitter.lua
│       └── which-key.lua
└── nvim_cheatsheet.md
```

## Plugins (and why)

- `folke/lazy.nvim`: plugin manager.
- `nvchad/base46`: colors/theme engine.
- `nvchad/ui`: statusline/tabline/UI pieces.
- `nvim-telescope/telescope.nvim`: fuzzy find + grep.
- `nvim-treesitter/nvim-treesitter`: better syntax highlight/indent.
- `neovim/nvim-lspconfig` + `williamboman/mason.nvim`: LSP + install servers.
- `nvim-neo-tree/neo-tree.nvim`: file explorer.
- `nvimdev/dashboard-nvim`: startup dashboard.
- `folke/which-key.nvim`: keybind hint popup.
- `numToStr/Comment.nvim`: quick commenting.
- `windwp/nvim-autopairs`: auto-close brackets/quotes.
- `folke/flash.nvim`: fast motions/jumps.
- `lewis6991/gitsigns.nvim`: git hunks in-buffer.
- `NeogitOrg/neogit` + `sindrets/diffview.nvim`: git UI + diffs/history.
- `ludovicchabant/vim-gutentags`: ctags-based fallback navigation.
- `supermaven-inc/supermaven-nvim`: AI inline suggestions.
- `otavioschwanck/arrow.nvim`: quick file marks/jumps.
