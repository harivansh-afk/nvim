return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "█" },
        change = { text = "█" },
        delete = { text = "▁" },
        topdelete = { text = "▔" },
        changedelete = { text = "█" },
        untracked = { text = "┃" },
      },
      -- Show colors on line numbers
      numhl = true,
      -- Optional: adds subtle highlighting to the entire line (set to true if you want)
      linehl = false,
      -- Optional: highlight the word that changed
      word_diff = false,
      -- Make the signs stand out a bit more with custom highlights
      signcolumn = true,
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
    })
  end,
}
