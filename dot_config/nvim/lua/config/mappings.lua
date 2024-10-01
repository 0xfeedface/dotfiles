function set_colemak_mapping()
  local modes = { 'n', 'x', 'o' }
  -- left
  vim.keymap.set(modes, 'm', 'h')
  vim.keymap.set(modes, 'M', 'H')
  vim.keymap.set(modes, 'h', 'e')
  vim.keymap.set(modes, 'H', 'E')
  -- down
  vim.keymap.set(modes, 'n', 'j')
  vim.keymap.set(modes, 'N', 'J')
  vim.keymap.set(modes, 'k', 'n')
  vim.keymap.set(modes, 'K', 'N')
  -- up
  vim.keymap.set(modes, 'e', 'k')
  vim.keymap.set(modes, 'E', 'K')
  vim.keymap.set(modes, 'l', 'i')
  vim.keymap.set(modes, 'L', 'I')
  -- right
  vim.keymap.set(modes, 'i', 'l')
  vim.keymap.set(modes, 'I', 'L')
end
set_colemak_mapping()

-- Toggle search term highlighting
vim.keymap.set('n', '<leader>h', '<cmd>lua vim.o.hlsearch = not vim.o.hlsearch<cr>', { noremap = true, silent = true })
