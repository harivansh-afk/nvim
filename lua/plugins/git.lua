local function current_file_location()
  local root = vim.trim(vim.fn.system("git rev-parse --show-toplevel"))
  if vim.v.shell_error ~= 0 or root == "" then
    return nil
  end

  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    return nil
  end

  local prefix = root .. "/"
  if path:sub(1, #prefix) ~= prefix then
    return nil
  end

  local rel = path:sub(#prefix + 1)
  return ("%s:%d"):format(rel, vim.fn.line("."))
end

local function gh_browse()
  if vim.fn.executable("gh") ~= 1 then
    vim.notify("gh CLI not found", vim.log.levels.WARN)
    return
  end

  local loc = current_file_location()
  if loc then
    vim.system({ "gh", "browse", loc })
    return
  end
  vim.system({ "gh", "browse" })
end

return {
  -- Fugitive: The gold standard for Git in Vim
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gread", "Gwrite", "Gdiffsplit", "Gvdiffsplit", "Gblame" },
    keys = {
      { "<leader>gg", "<cmd>Git<cr><cmd>only<cr>", desc = "Git status (fullscreen)" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
      { "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
      { "<leader>gl", "<cmd>Git pull<cr>", desc = "Git pull" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
      { "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "Git diff vertical" },
      { "<leader>gr", "<cmd>Gread<cr>", desc = "Git checkout file" },
      { "<leader>gw", "<cmd>Gwrite<cr>", desc = "Git add file" },
      { "<leader>go", gh_browse, desc = "Open in GitHub" },
    },
  },

  -- Gitsigns: Git info in the gutter
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "██" },
        change = { text = "██" },
        delete = { text = "▄▄" },
        topdelete = { text = "▀▀" },
        changedelete = { text = "██" },
      },
      signs_staged = {
        add = { text = "▓▓" },
        change = { text = "▓▓" },
        delete = { text = "▄▄" },
        topdelete = { text = "▀▀" },
        changedelete = { text = "▓▓" },
      },
      signs_staged_enable = true,
      signcolumn = true,
      numhl = false,
      linehl = false,  -- disabled - let colorscheme handle
      word_diff = false,
      current_line_blame = false,
      current_line_blame_opts = {
        delay = 500,
      },
    },
    keys = {
      { "]g", "<cmd>Gitsigns next_hunk<cr>", desc = "Next hunk" },
      { "[g", "<cmd>Gitsigns prev_hunk<cr>", desc = "Prev hunk" },
      { "<leader>ghs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage hunk" },
      { "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset hunk" },
      { "<leader>ghp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
      { "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle line blame" },
    },
  },

  -- Diffs.nvim: Better diff highlighting
  {
    "barrettruth/diffs.nvim",
    lazy = false,
    init = function()
      vim.g.diffs = {
        fugitive = {
        enabled = true,
          horizontal = false,
          vertical = false,
        },
        hide_prefix = true,
        highlights = {
          gutter = true,
          blend_alpha = 0.4,
          intra = {
            enabled = true,
          },
        },
      }
    end,
  },
}
