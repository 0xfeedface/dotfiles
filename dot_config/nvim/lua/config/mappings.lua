-- Toggle search term highlighting
vim.keymap.set('n', '<leader>h', '<cmd>lua vim.o.hlsearch = not vim.o.hlsearch<cr>', { noremap = true, silent = true })
