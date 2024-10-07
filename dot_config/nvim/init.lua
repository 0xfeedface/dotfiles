local is_mac_result = nil
function is_mac ()
  if is_mac_result == nil then
    local macbook_hostname = 'macbook-pro'
    is_mac_result = vim.fn.hostname():sub(1, #macbook_hostname) == macbook_hostname
  end
  return is_mac_result
end

require('config.lazy')
require('config.mappings')
require('config.file_types')

-- Highlight the current line
vim.o.cursorline = true

-- Highlight the 80-th column
vim.opt.colorcolumn = { 80 }

-- Use case-insensitive search by default
vim.o.ignorecase = true

-- Don't add double spaces when joining sentences
vim.o.joinspaces = true

-- Highlight matching chars
vim.o.showmatch = true

-- Enable relative line numbers
vim.o.relativenumber = true
vim.o.number = true
vim.o.numberwidth = 5

vim.g.python3_host_prog = is_mac() and '/opt/homebrew/bin/python3' or '/usr/bin/python'
vim.g.loaded_python_provider = false
vim.g.loaded_ruby_provider = false
vim.g.loaded_perl_provider = false
vim.g.loaded_node_provider = false

-- Set default tabbing options
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Set colors
vim.o.background = 'dark'

-- Disable line-wrapping
vim.o.wrap = false

-- Number of lines of context for vertical scrolling
vim.o.scrolloff = 0

-- Number of columns of context for horizontal scrolling
vim.o.sidescrolloff = 2

-- Always yank into the system clipboard
vim.opt.clipboard:append('unnamedplus')

-- <c-t> and <c-a> round to the next shiftwidth
vim.o.shiftround = true

-- Enable modelines
vim.o.modeline = true

-- Always display a sign column of width 1
vim.o.signcolumn = 'yes:1'

-- Number formats for <c-a> and <c-x>
-- NeoVim default: bin,hex
vim.opt.nrformats = { 'alpha', 'hex' }

-- Disable folding
vim.o.foldenable = true

-- Case-sensitive search if at least one Capital letter is used
vim.o.smartcase = true

-- Disable bell
vim.o.visualbell = true

-- Reduce NeoVim's verbosity
vim.shortmess = 'I'

-- Show invisibles
vim.o.list = true
-- Use the same symbols as TextMate for tabstops and EOLs
vim.opt.listchars = { nbsp = '·', tab = '▸ ', eol = '¬' }

-- On vertical split new windows go to the right
vim.o.splitright = true

-- On horizontal split new windows go to below
vim.opt.splitbelow = true

-- Allow per-directory .nvimrc
vim.o.exrc = true
vim.o.secure = true

-- Keep backups
vim.o.backup = true

-- Store backups in one place
vim.o.backupdir = vim.fn.expand('~') .. '/.local/share/nvim/backup'

-- Store swap files in one place
vim.o.dir = vim.fn.expand('~') .. '/.local/share/nvim/swap'

-- Set completion options
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

vim.api.nvim_create_autocmd('InsertEnter', {
  pattern = '',
  command = 'set norelativenumber'
})
vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '',
  command = 'set relativenumber'
})
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = vim.fn.expand('%'),
  command = 'source ' .. vim.fn.expand('%')
})
