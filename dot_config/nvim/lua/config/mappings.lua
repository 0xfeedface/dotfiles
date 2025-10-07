-- Toggle search term highlighting
vim.keymap.set('n', '<leader>h', '<cmd>lua vim.o.hlsearch = not vim.o.hlsearch<cr>', { noremap = true, silent = true })

if vim.g.vscode then
  -- goto definition is built-in
  vim.keymap.set('n', 'gpd', "<cmd>lua require'vscode'.action('editor.action.peekDefinition')<cr>", { noremap = true, silent = true })
  vim.keymap.set('n', 'gps', "<cmd>lua require'vscode'.action('editor.action.revealDefinitionAside')<cr>", { noremap = true, silent = true })
  vim.keymap.set('n', 'K', "<cmd>lua require'vscode'.action('editor.action.showDefinitionPreviewHover')<cr>", { noremap = true, silent = true })

  vim.keymap.set('n', 'gi', "<cmd>lua require'vscode'.action('editor.action.goToImplementation')<cr>", { noremap = true, silent = true })
  vim.keymap.set('n', 'gpi', "<cmd>lua require'vscode'.action('editor.action.peekImplementation')<cr>", { noremap = true, silent = true })

  vim.keymap.set('n', 'gr', "<cmd>lua require'vscode'.action('editor.action.referenceSearch.trigger')<cr>", { noremap = true, silent = true })
  vim.keymap.set('n', 'gpr', "<cmd>lua require'vscode'.action('editor.action.referenceSearch.peek')<cr>", { noremap = true, silent = true })

  vim.keymap.set('n', 'gt', "<cmd>lua require'vscode'.action('editor.action.goToTypeDefinition')<cr>", { noremap = true, silent = true })
  vim.keymap.set('n', 'gpt', "<cmd>lua require'vscode'.action('editor.action.peekTypeDefinition')<cr>", { noremap = true, silent = true })

  vim.keymap.set('n', 'gq', "<cmd>lua require'vscode'.action('editor.action.quickFix')<cr>", { noremap = true, silent = true })

  vim.keymap.set('n', 'rn', "<cmd>lua require'vscode'.action('editor.action.rename')<cr>", { noremap = true, silent = true })
end
