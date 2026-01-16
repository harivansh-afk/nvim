return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
    { "<BS>", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
    { "<leader>gs", "<cmd>Neotree git_status left<cr>", desc = "Focus git status" },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      window = {
        width = 30,
      },
      -- Source selector (tabs) to switch between files/git
      source_selector = {
        winbar = true,
        content_layout = "center",
        tabs_layout = "equal",
        sources = {
          { source = "filesystem", display_name = " Files" },
          { source = "git_status", display_name = " Git" },
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true, -- Highlight and auto-expand to current file
          leave_dirs_open = false, -- Close dirs when navigating away
        },
        filtered_items = {
          visible = true, -- Show filtered items (hidden files)
          hide_dotfiles = false, -- Show dotfiles
          hide_gitignored = false, -- Show git ignored files
          hide_hidden = false, -- Show hidden files on Windows
        },
      },
      git_status = {
        follow_current_file = {
          enabled = true,
        },
      },
    })
  end,
}