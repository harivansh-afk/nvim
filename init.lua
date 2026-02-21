vim.g.mapleader = ' '
vim.g.maplocalleader = ','

function _G.map(mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('keep', opts or {}, { silent = true }))
end

function _G.bmap(mode, lhs, rhs, opts)
    _G.map(mode, lhs, rhs, vim.tbl_extend('force', opts or {}, { buffer = 0 }))
end

local disabled_plugins = {
    '2html_plugin',
    'bugreport',
    'getscript',
    'getscriptPlugin',
    'gzip',
    'logipat',
    'matchit',
    'matchparen',
    'netrw',
    'netrwFileHandlers',
    'netrwPlugin',
    'netrwSettings',
    'optwin',
    'rplugin',
    'rrhelper',
    'synmenu',
    'tar',
    'tarPlugin',
    'tohtml',
    'tutor',
    'vimball',
    'vimballPlugin',
    'zip',
    'zipPlugin',
}

for _, plugin in ipairs(disabled_plugins) do
    vim.g['loaded_' .. plugin] = 1
end

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=stable',
        'https://github.com/folke/lazy.nvim.git',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
    defaults = { lazy = false },
    change_detection = { enabled = false },
})
