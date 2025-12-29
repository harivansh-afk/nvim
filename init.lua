-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Basic settings
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- NvChad base46 cache path (must be before lazy setup)
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

-- Essential vim options
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.colorcolumn = ""
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.showmode = false  -- Disable built-in mode display
vim.opt.shortmess:append("S")  -- Disable native search count display
vim.opt.ruler = false  -- Disable native ruler (NvChad statusline shows position)
vim.opt.cmdheight = 0  -- Hide command line when not in use
vim.opt.laststatus = 3  -- Global statusline at the very bottom

-- Enable cursor blinking
vim.opt.guicursor = "n-v-c:block-blinkwait700-blinkoff400-blinkon250,i-ci-ve:ver25-blinkwait700-blinkoff400-blinkon250,r-cr:hor20-blinkwait700-blinkoff400-blinkon250"

-- Keymaps
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- NvChad tabufline keymaps (buffer/tab navigation)
vim.keymap.set("n", "<Tab>", function() require("nvchad.tabufline").next() end, { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", function() require("nvchad.tabufline").prev() end, { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>x", function() require("nvchad.tabufline").close_buffer() end, { desc = "Close buffer" })
vim.keymap.set("n", "<leader>b", "<cmd>enew<CR>", { desc = "New buffer" })

-- Load plugins
require("lazy").setup("plugins", {
  defaults = { lazy = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
})

-- Load NvChad base46 highlights (safe load)
local cache = vim.g.base46_cache
if vim.uv.fs_stat(cache) then
  for _, v in ipairs(vim.fn.readdir(cache)) do
    dofile(cache .. v)
  end
end