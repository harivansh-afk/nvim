return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      signcolumn = true,
      numhl = false,
      linehl = true,
      word_diff = false,
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      signs_staged = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      signs_staged_enable = true,
      on_attach = function(bufnr)
        -- Unstaged changes - line highlighting
        vim.api.nvim_set_hl(0, "GitSignsAddLn", { bg = "#2a3a2a" })
        vim.api.nvim_set_hl(0, "GitSignsChangeLn", { bg = "#3a3a2a" })
        vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { bg = "#3a2a2a" })
        -- Staged changes - NO line highlighting (gutter only)
        vim.api.nvim_set_hl(0, "GitSignsStagedAddLn", {})
        vim.api.nvim_set_hl(0, "GitSignsStagedChangeLn", {})
        vim.api.nvim_set_hl(0, "GitSignsStagedDeleteLn", {})
      end,
    })
  end,
}
