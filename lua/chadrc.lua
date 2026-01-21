---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "gruvbox",        -- NvChad's gruvbox theme
  transparency = false,       -- Keep your transparent mode
  -- theme_toggle = { "gruvbox", "gruvbox_light" },
}

M.ui = {
  statusline = {
    enabled = true,
    theme = "default",      -- options: default, vscode, vscode_colored, minimal
    separator_style = "round", -- default, round, block, arrow
  },
  tabufline = {
    enabled = false,
  },
}

-- Disable nvdash if you want to keep your dashboard.lua
M.nvdash = {
  load_on_startup = false,
}

return M
