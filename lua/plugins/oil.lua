return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
  },
  opts = {
    default_file_explorer = true, -- nvim . opens oil
    columns = { "icon" },
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-v>"] = "actions.select_vsplit",
      ["<C-x>"] = "actions.select_split",
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["-"] = "actions.parent",
      ["g."] = "actions.toggle_hidden",
    },
  },
}
