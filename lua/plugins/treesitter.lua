return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "vim", "vimdoc", "query", "javascript", "typescript", "python", "html", "css", "json", "yaml", "markdown" },
      auto_install = true,
      highlight = {
        enable = false,
      },
      indent = {
        enable = true,
      },
    })
  end,
}
