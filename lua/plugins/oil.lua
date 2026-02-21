return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'malewicz1337/oil-git.nvim' },
    config = function(_, opts)
        require('oil').setup(opts)
        require('oil-git').setup({
            show_ignored_files = false,
            show_ignored_directories = false,
            debounce_ms = 300,
        })
        vim.api.nvim_create_autocmd('BufEnter', {
            callback = function()
                if vim.bo.filetype == '' then
                    local path = vim.fn.expand('%:p')
                    if vim.fn.isdirectory(path) == 1 then
                        vim.cmd('Oil ' .. path)
                    end
                end
            end,
            group = vim.api.nvim_create_augroup('AOil', { clear = true }),
        })
        map('n', '-', '<cmd>Oil<cr>')
        map('n', '<leader>e', '<cmd>Oil<cr>')
    end,
    opts = {
        default_file_explorer = true,
        columns = { 'icon' },
        view_options = { show_hidden = true },
        keymaps = {
            ['g?'] = 'actions.show_help',
            ['<CR>'] = 'actions.select',
            ['<C-v>'] = 'actions.select_vsplit',
            ['<C-x>'] = 'actions.select_split',
            ['<C-p>'] = 'actions.preview',
            ['<C-c>'] = 'actions.close',
            ['-'] = 'actions.parent',
            ['g.'] = 'actions.toggle_hidden',
        },
    },
}
