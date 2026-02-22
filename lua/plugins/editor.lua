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
        'barrettruth/cp.nvim',
        dependencies = { 'ibhagwan/fzf-lua' },
        init = function()
            -- Keep uv cache in-project so cp.nvim scraping works in restricted environments.
            if vim.env.UV_CACHE_DIR == nil or vim.env.UV_CACHE_DIR == '' then
                local uv_cache_dir = vim.fn.getcwd() .. '/.uv-cache'
                vim.fn.mkdir(uv_cache_dir, 'p')
                vim.env.UV_CACHE_DIR = uv_cache_dir
            end

            vim.g.cp = {
                languages = {
                    python = {
                        extension = 'py',
                        commands = {
                            run = { 'python3', '{source}' },
                            debug = { 'python3', '{source}' },
                        },
                    },
                },
                platforms = {
                    codeforces = {
                        enabled_languages = { 'python' },
                        default_language = 'python',
                    },
                    atcoder = {
                        enabled_languages = { 'python' },
                        default_language = 'python',
                    },
                    cses = {
                        enabled_languages = { 'python' },
                        default_language = 'python',
                    },
                },
                ui = {
                    picker = 'fzf-lua',
                },
            }
        end,
        config = function()
            map('n', '<leader>cr', '<cmd>CP run<cr>', { desc = 'CP run' })
            map('n', '<leader>cp', '<cmd>CP panel<cr>', { desc = 'CP panel' })
            map('n', '<leader>ce', '<cmd>CP edit<cr>', { desc = 'CP edit tests' })
            map('n', '<leader>cn', '<cmd>CP next<cr>', { desc = 'CP next problem' })
            map('n', '<leader>cN', '<cmd>CP prev<cr>', { desc = 'CP previous problem' })
            map('n', '<leader>cc', '<cmd>CP pick<cr>', { desc = 'CP contest picker' })
            map('n', '<leader>ci', '<cmd>CP interact<cr>', { desc = 'CP interact' })
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
