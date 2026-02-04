return {
  -- Gruvbox Material colorscheme
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_foreground = "material"
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_enable_bold = true
      vim.g.gruvbox_material_better_performance = true
      vim.g.gruvbox_material_diagnostic_text_highlight = true
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },

  -- Dashboard
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local header_art = {
        "  ██▒   █▓ ██▓ ███▄ ▄███▓",
        "▓██░   █▒▓██▒▓██▒▀█▀ ██▒",
        " ▓██  █▒░▒██▒▓██    ▓██░",
        "  ▒██ █░░░██░▒██    ▒██ ",
        "   ▒▀█░  ░██░▒██▒   ░██▒",
        "   ░ ▐░  ░▓  ░ ▒░   ░  ░",
        "   ░ ░░   ▒ ░░  ░      ░",
        "     ░░   ▒ ░░      ░   ",
        "      ░   ░         ░   ",
        "     ░                  ",
      }
      local center_items = 6
      local content_height = #header_art + 2 + (center_items * 2)
      local win_height = vim.fn.winheight(0)
      local padding = math.max(0, math.floor((win_height - content_height) / 2))

      local header = {}
      for _ = 1, padding do
        table.insert(header, "")
      end
      for _, line in ipairs(header_art) do
        table.insert(header, line)
      end
      table.insert(header, "")
      table.insert(header, "")

      require("dashboard").setup({
        theme = "doom",
        config = {
          header = header,
          center = {
            {
              icon = "  ",
              desc = "Find File           ",
              key = "f",
              action = "Telescope find_files",
            },
            {
              icon = "  ",
              desc = "Recent Files        ",
              key = "r",
              action = "Telescope oldfiles",
            },
            {
              icon = "  ",
              desc = "Find Text           ",
              key = "g",
              action = "Telescope live_grep",
            },
            {
              icon = "  ",
              desc = "File Explorer       ",
              key = "e",
              action = "Oil",
            },
            {
              icon = "  ",
              desc = "Quit                ",
              key = "q",
              action = "quit",
            },
          },
          footer = {},
        },
      })
    end,
  },

  -- Which-key for keybinding hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      win = {
        border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
