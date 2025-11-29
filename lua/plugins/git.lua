return {
  -- Neogit: Modern Git interface with tree view
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()
      require('neogit').setup({
        -- Neo-tree style integration
        kind = "split",
        commit_editor = {
          kind = "split",
        },
        popup = {
          kind = "split",
        },
        -- Signs for different git states
        signs = {
          -- { CLOSED, OPENED }
          hunk = { "", "" },
          item = { "", "" },
          section = { "", "" },
        },
        -- Integrations
        integrations = {
          telescope = true,
          diffview = true,
        },
      })
    end,
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Open Neogit" },
      { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Git Commit" },
      { "<leader>gp", "<cmd>Neogit push<cr>", desc = "Git Push" },
      { "<leader>gl", "<cmd>Neogit pull<cr>", desc = "Git Pull" },
    },
  },

  -- Diffview: Enhanced diff viewing
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = function()
      -- Set up diff highlights before loading diffview
      vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#2a3a2a" })
      vim.api.nvim_set_hl(0, "DiffChange", { bg = "#3a3a2a" })
      vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#3a2a2a" })
      vim.api.nvim_set_hl(0, "DiffText", { bg = "#5a3d3d" })

      require("diffview").setup({
        diff_binaries = false,    -- Show diffs for binaries
        enhanced_diff_hl = true,  -- Better word-level diff highlighting
        git_cmd = { "git" },      -- The git executable followed by default args.
        use_icons = true,         -- Requires nvim-web-devicons
        show_help_hints = true,   -- Show hints for how to open the help panel
        watch_index = true,       -- Update views and index on git index changes.
      })
    end,
    keys = {
      { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
      { "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
      { "<leader>gdh", "<cmd>DiffviewFileHistory<cr>", desc = "File History" },
    },
  },

  -- Fugitive: Additional Git commands
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'Gblame', 'Gdiff', 'Gread', 'Gwrite', 'Ggrep' },
    keys = {
      { '<leader>gb', '<cmd>Git blame<cr>', desc = 'Git Blame' },
      { '<leader>gd', '<cmd>Gdiff<cr>', desc = 'Git Diff (Fugitive)' },
    }
  },
}
