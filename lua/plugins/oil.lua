return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "malewicz1337/oil-git.nvim" },
  cmd = "Oil",
  event = 'VeryLazy',
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    { "<leader>e", "<cmd>Oil<cr>", desc = "Open file explorer" },
  },
  config = function(_, opts)
    require("oil").setup(opts)
    require("oil-git").setup({
      show_ignored_files = false,
      show_ignored_directories = false,
      debounce_ms = 300,
    })
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "oil://*",
      callback = function()
        local dir = require("oil").get_current_dir()
        if dir then
          vim.cmd.lcd(dir)
        end
      end,
    })
  end,
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
