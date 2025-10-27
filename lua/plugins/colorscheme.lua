return {
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    priority = 1000,
    lazy = false,
    config = function()
      require("gruvbox").setup({
        contrast = "hard", -- can be "hard", "soft" or empty string
        transparent_mode = true,
      })
    end,
  },
  {
    "datsfilipe/vesper.nvim",
    name = "vesper",
    priority = 1000,
    lazy = false,
  },
  {
    'maxmx03/solarized.nvim',
    lazy = false,
    priority = 1000,
    ---@type solarized.config
    opts = {},
  },
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    priority = 1000,
    lazy = false,
    config = function()
      -- Always use Gruvbox dark
      vim.o.background = "dark"
      vim.cmd.colorscheme("gruvbox")

      -- Add command to manually toggle if needed
      vim.api.nvim_create_user_command("ToggleTheme", function()
        if vim.g.colors_name == "gruvbox" then
          vim.o.termguicolors = true
          vim.o.background = "light"
          require('solarized').setup({})
          vim.cmd.colorscheme("solarized")
        else
          vim.o.background = "dark"
          vim.cmd.colorscheme("gruvbox")
        end
      end, {})
    end,
  },
}
