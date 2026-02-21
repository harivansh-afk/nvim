return {
    {
        'windwp/nvim-autopairs',
        config = true,
    },
    {
        'folke/flash.nvim',
        opts = {
            modes = { search = { enabled = true } },
        },
        config = function(_, opts)
            require('flash').setup(opts)
            map({ 'n', 'x', 'o' }, 's', function() require('flash').jump() end)
            map({ 'n', 'x', 'o' }, 'S', function() require('flash').treesitter() end)
            map('o', 'r', function() require('flash').remote() end)
            map({ 'o', 'x' }, 'R', function() require('flash').treesitter_search() end)
            map('c', '<c-s>', function() require('flash').toggle() end)
        end,
    },
    {
        'kylechui/nvim-surround',
        config = true,
    },
    {
        'kevinhwang91/nvim-ufo',
        dependencies = { 'kevinhwang91/promise-async' },
        opts = {
            provider_selector = function()
                return { 'treesitter', 'indent' }
            end,
        },
        config = function(_, opts)
            require('ufo').setup(opts)
            map('n', 'zR', require('ufo').openAllFolds)
            map('n', 'zM', require('ufo').closeAllFolds)
        end,
    },
    {
        'supermaven-inc/supermaven-nvim',
        opts = {
            keymaps = {
                accept_suggestion = '<Tab>',
                clear_suggestion = '<C-]>',
                accept_word = '<C-j>',
            },
            ignore_filetypes = { gitcommit = true },
            color = {
                suggestion_color = vim.api.nvim_get_hl(0, { name = 'Comment' }).fg,
                cterm = 244,
            },
        },
    },
}
