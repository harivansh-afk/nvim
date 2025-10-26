return {
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    priority = 1000,
    lazy = false,
    config = function()
      require("gruvbox").setup({
        contrast = "hard", -- can be "hard", "soft" or empty string
        transparent_mode = false,
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
      -- Auto-detect light/dark mode
      local function set_theme()
        -- Check if running in VSCode
        if vim.env.VSCODE or vim.env.TERM_PROGRAM == "vscode" then
          vim.o.termguicolors = true
          vim.o.background = "light"
          require('solarized').setup({})
          vim.cmd.colorscheme("solarized")
          return
        end
        
        -- Check COLORFGBG for other terminals
        if os.getenv("COLORFGBG") then
          local colors = vim.split(os.getenv("COLORFGBG"), ";")
          if colors[2] and tonumber(colors[2]) > 7 then
            vim.o.termguicolors = true
            vim.o.background = "light"
            require('solarized').setup({})
            vim.cmd.colorscheme("solarized")
            return
          end
        end
        
        -- Default to dark with Gruvbox
        vim.o.background = "dark"
        vim.cmd.colorscheme("gruvbox")
      end
      
      -- Set theme on startup
      set_theme()
      
      -- Add command to manually toggle
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