return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  lazy = false,
  keys = {
    { '<Tab>', '<Cmd>BufferLineCycleNext<CR>', desc = 'Next buffer' },
    { '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', desc = 'Prev buffer' },
    { '<leader>x', '<Cmd>bdelete<CR>', desc = 'Close buffer' },
    { '<leader>bp', '<Cmd>BufferLinePick<CR>', desc = 'Pick buffer' },
    { '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', desc = 'Close other buffers' },
  },
  opts = {
    options = {
      diagnostics = 'nvim_lsp',
      always_show_bufferline = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
    }
  }
}
