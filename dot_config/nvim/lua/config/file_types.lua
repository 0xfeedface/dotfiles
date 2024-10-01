-- vim.cmd([[
--   augroup lua
--     autocmd!
--     autocmd FileType lua setlocal ts=2 sts=2 sw=2 expandtab
--   augroup END
-- ]])

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('smallindent', { clear = true })
autocmd('FileType', {
  pattern = { 'lua', 'vim', 'template', 'html', 'css', 'json', 'sh', 'yaml', 'sql', 'xml' },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
  group = 'smallindent'
})

augroup('dashnosep', { clear = true })
autocmd('FileType', {
  pattern = { 'yaml', 'sql', 'el' },
  callback = function()
    vim.opt_local.iskeyword:append { '-' }
  end,
  group = 'dashnosep'
})

augroup('c', { clear = true })
autocmd('FileType', {
  pattern = { 'c', 'cpp' },
  callback = function()
    -- Add C++ template delimiters to match pairs
    vim.opt.matchpairs:append { '<:>' }
    -- Prevent errors in highlighting C/C++
    vim.g.c_no_curly_error = true
  end,
  group = 'c'
})

augroup('tabs', { clear = true })
autocmd('FileType', {
  pattern = { 'go' },
  callback = function()
    vim.o.expandtab = false
  end,
  group = 'tabs'
})
