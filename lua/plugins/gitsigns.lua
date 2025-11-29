return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      -- Disable sign column indicators
      signcolumn = false,
      -- Show colors on line numbers
      numhl = true,
      -- Highlight the entire line for changed lines (Cursor-style)
      linehl = true,
      -- Highlight the word that changed within a line
      word_diff = true,
      -- Show git blame at end of current line (optional, can be distracting)
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000,
        ignore_whitespace = false,
      },
      -- Preview window configuration
      preview_config = {
        border = 'rounded',
        style = 'minimal',
      },
      on_attach = function(bufnr)
        -- Set up Cursor-style line highlights (subtle background colors)
        -- Green tint for added lines
        vim.api.nvim_set_hl(0, "GitSignsAddLn", { bg = "#2a3a2a" })
        -- Red tint for removed/changed lines
        vim.api.nvim_set_hl(0, "GitSignsChangeLn", { bg = "#3a2a2a" })
        vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { bg = "#3a2a2a" })
        vim.api.nvim_set_hl(0, "GitSignsChangedeleteLn", { bg = "#3a2a2a" })
        -- Word diff highlights (more prominent)
        vim.api.nvim_set_hl(0, "GitSignsAddLnInline", { bg = "#3d5a3d" })
        vim.api.nvim_set_hl(0, "GitSignsChangeLnInline", { bg = "#5a3d3d" })
        vim.api.nvim_set_hl(0, "GitSignsDeleteLnInline", { bg = "#5a3d3d" })
      end,
    })
  end,
}
