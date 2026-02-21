return {
    {
        'ellisonleao/gruvbox.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('gruvbox').setup({
                contrast = 'hard',
                transparent_mode = true,
                italic = { comments = true },
                overrides = {
                    MatchParen = { bold = true, underline = true, bg = '' },
                },
            })
            vim.cmd.colorscheme('gruvbox')
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                theme = 'gruvbox',
                icons_enabled = false,
                component_separators = '',
                section_separators = '',
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff' },
                lualine_c = { { 'filename', path = 1 } },
                lualine_x = { 'diagnostics' },
                lualine_y = { 'filetype' },
                lualine_z = { 'location' },
            },
        },
    },
    {
        'barrettruth/nonicons.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
}
