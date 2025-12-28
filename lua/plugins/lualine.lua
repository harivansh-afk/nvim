-- Disabled: Using NvChad statusline instead
-- To re-enable lualine: set enabled = true below AND
-- in lua/chadrc.lua set M.ui.statusline.enabled = false
return {
  'nvim-lualine/lualine.nvim',
  enabled = false,  -- Disabled in favor of NvChad statusline
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'auto',
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {
        {
          function()
            local search = vim.fn.getreg('/')
            if search == '' then return '' end
            local ok, result = pcall(vim.fn.searchcount, { maxcount = 0, timeout = 100 })
            if not ok or not result or result.total == 0 then return '' end
            return string.format('[%d/%d]', result.current, result.total)
          end,
        },
        'progress'
      },
      lualine_z = {'location'}
    },
  }
}