return {
    'barrettruth/canola.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        {
            'barrettruth/oil-git.nvim',
            branch = 'fix/signcolumn-utf8-and-callback',
            opts = {
                show_ignored_files = false,
                show_ignored_directories = false,
                debounce_ms = 300,
            },
        },
    },
    init = function()
        vim.g.oil = {
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
        }
        map('n', '-', '<cmd>Oil<cr>')
        map('n', '<leader>e', '<cmd>Oil<cr>')
    end,
}
