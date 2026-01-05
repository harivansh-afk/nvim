return {
  "nvim-lua/plenary.nvim",

  {
    "nvchad/base46",
    lazy = false,
    priority = 1000,
    build = function()
      require("base46").load_all_highlights()
    end,
    config = function()
      -- Generate cache on first load if it doesn't exist
      local cache_path = vim.g.base46_cache
      if not vim.uv.fs_stat(cache_path) then
        vim.fn.mkdir(cache_path, "p")
        require("base46").load_all_highlights()
      end
    end,
  },

  {
    "nvchad/ui",
    lazy = false,
    priority = 999,
    config = function()
      require("nvchad")
    end,
  },


}
