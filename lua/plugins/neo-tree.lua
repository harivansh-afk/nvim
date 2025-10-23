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
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      window = {
        width = 30,
      },
      filesystem = {
        filtered_items = {
          visible = true, -- Show filtered items (hidden files)
          hide_dotfiles = false, -- Show dotfiles
          hide_gitignored = false, -- Show git ignored files
          hide_hidden = false, -- Show hidden files on Windows
        },
      },
    })
  end,
}