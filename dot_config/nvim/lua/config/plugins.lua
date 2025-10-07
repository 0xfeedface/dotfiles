local set_lsp_mappings = function(client, bufnr)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n' , 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { noremap=true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n' , 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', { noremap=true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n' , 'gds', '<cmd>lua require("telescope.builtin").lsp_definitions({jump_type="split"})<cr>', { noremap=true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n' , 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { noremap=true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n' , 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', { noremap=true })
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n' , 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { noremap=true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n' , 'gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>', { noremap=true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n' , 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { noremap=true })
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n' , 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', { noremap=true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n' , 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<cr>', { noremap=true })

  if client.server_capabilities.typeDefinitionProvider == true then
    vim.api.nvim_buf_set_keymap(bufnr, 'n' , 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { noremap=true })
  end

  vim.api.nvim_buf_set_keymap(bufnr, 'n' , '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', { noremap=true })

  if client.server_capabilities.documentFormattingProvider == true then
    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
    vim.api.nvim_buf_set_keymap(bufnr, 'n' , 'gQ', '<cmd>lua vim.lsp.buf.format()<cr>', { noremap=true })
  end

  if client.server_capabilities.callHierarchyProvider == true then
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gh', '<cmd>lua require"telescope.builtin".lsp_incoming_calls()<cr>', { noremap=true})
    -- TODO: not implemented in clangd yet
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'xxx', '<cmd>lua require"telescope.builtin".lsp_outgoing_calls()<cr>', { noremap=true})
  end
end

return {
  {
    'Tsuzat/NeoSolarized.nvim',
    enabled = false,
    cond = not vim.g.vscode,
    lazy = false,
    priority = 1000,
    config = function()
      require'NeoSolarized'.setup{
        transparent = false,
        enable_italics = false,
        styles = {
          -- Style to be applied to different syntax groups
          comments = { italic = false },
          keywords = { italic = false },
          functions = { bold = false },
          variables = {},
          string = { italic = false },
          underline = false, -- global underline
          undercurl = false, -- global undercurl
        },
        on_highlights = function(highlights, colors)
          highlights.Constant.fg = colors.violet
          -- highlights.String
          highlights.Character.link = 'Constant'
          highlights.Number.link = 'Constant'
          highlights.Boolean.link = 'Constant'
          highlights.Float.link = 'Constant'
          highlights.Identifier.fg = colors.aqua
          highlights.Function.link = 'Identifier'
          highlights.Statement.fg = colors.purple
          highlights.Conditional.link = 'Statement'
          highlights.Repeat.link = 'Statement'
          highlights.Label.link = 'Statement'
          highlights.Operator.link = 'Statement'
          highlights.Keyword.link = 'Statement'
          highlights.Exception.link = 'Statement'
          highlights.PreProc.fg = colors.yellow
          highlights.PreCondit.link = 'PreProc'
          highlights.Include.link = 'PreProc'
          highlights.Define.link = 'PreProc'
          highlights.Macro.link = 'PreProc'
          highlights.Type.fg = colors.blue
          highlights.StorageClass.fg = colors.blue
          highlights.Structure.fg = colors.blue
          highlights.Typedef.fg = colors.blue
          highlights.Special.fg = colors.orange
          highlights.SpecialChar.link = 'Special'
          highlights.Tag.link = 'Special'
          highlights.Delimiter.link = 'Operator'
          highlights.SpecialComment.link = 'Special'
          highlights.Debug.link = 'Special'
          highlights.Whitespace.fg = colors.fg0
          -- highlights.Underlined = { underline = true }
          -- highlights.Bold = { bold = true }
          -- highlights.Italic = { italic = true }
          -- ('Ignore', below, may be invisible...)
          -- Ignore
          -- highlights.Error
          -- highlights.Todo
          -- highlights.qfLineNr
          -- highlights.qfFileName
          -- Diagnostic
          -- RedSign
          -- highlights.YellowSign
          -- highlights.GreenSign
          -- highlights.BlueSign
          -- highlights.VirtualTextWarning
          highlights.VirtualTextError.italic = true
          -- highlights.VirtualTextInfo
          -- highlights.VirtualTextHint
          -- highlights.ErrorFloat
          -- highlights.WarningFloat
          -- highlights.InfoFloat
          -- highlights.HintFloat
          highlights.TSAnnotation = nil
          highlights.TSAttribute = nil
          highlights.TSBoolean = nil
          highlights.TSCharacter = nil
          highlights.TSComment = nil
          highlights.TSConditional = nil
          highlights.TSConstBuiltin = { fg = colors.purple }
          highlights['@constant.builtin'] = { link = 'Operator' }
          highlights['@keyword.import'] = { link = 'PreProc' }
          highlights.TSConstMacro = nil
          highlights.TSConstant = nil
          highlights.TSConstructor = nil
          highlights.TSException = nil
          highlights.TSField = nil
          highlights.TSFloat = nil
          highlights.TSFuncBuiltin = nil
          highlights.TSFuncMacro = nil
          highlights.TSFunction = nil
          highlights.TSInclude = nil
          highlights.TSKeyword = nil
          highlights.TSKeywordFunction = nil
          highlights.TSKeywordOperator = nil
          highlights.TSLabel = nil
          highlights.TSMethod = nil
          highlights.TSNamespace = nil
          highlights.TSNone = nil
          highlights.TSNumber = nil
          highlights.TSOperator = nil
          highlights.TSParameter = nil
          highlights.TSParameterReference = nil
          highlights.TSProperty = { link = 'Normal' }
          highlights.TSPunctBracket = nil
          highlights.TSPunctDelimiter = { link = 'Operator' }
          highlights.TSPunctSpecial = nil
          highlights.TSRepeat = nil
          highlights.TSStorageClass = nil
          highlights.TSString = nil
          highlights.TSStringEscape = nil
          highlights.TSStringRegex = nil
          highlights.TSSymbol = nil
          highlights.TSTag = nil
          highlights.TSTagDelimiter = nil
          highlights.TSText = nil
          highlights.TSStrike = nil
          highlights.TSMath = nil
          highlights.TSType = nil
          highlights.TSTypeBuiltin = nil
          highlights.TSURI = nil
          highlights.TSVariable = nil
          highlights.TSVariableBuiltin = nil
        end
      }
      vim.cmd[[colorscheme NeoSolarized]]
    end
  },
  {
    dir = (is_mac() and '~/Code/' or '~/other/') .. 'NeoSolarized',
    enabled = true,
    cond = not vim.g.vscode,
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.neosolarized_contrast = 'high'
      vim.g.neosolarized_visibility = 'low'
      vim.g.neosolarized_bold = 0
      vim.g.neosolarized_italic = 1
    end,
    config = function()
      vim.cmd[[colorscheme NeoSolarized]]
    end,
  },
  {
    'morhetz/gruvbox',
    cond = not vim.g.vscode,
    enabled = false,
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.gruvbox_contrast_dark = 'medium'
      vim.g.gruvbox_italicize_comments = 0
      vim.g.gruvbox_bold = 0
    end,
    config = function()
      vim.cmd[[colorscheme gruvbox]]
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    cond = not vim.g.vscode,
    build = ':TSUpdate',
    config = function()
      local configs = require('nvim-treesitter.configs')
      configs.setup{
        ensure_installed = { 'c', 'cpp', 'python', 'vim', 'lua', 'comment' },
        highlight = { enable = true },
        incremental_selection = { enable = true },
        indent = { enable = true },
        textobjects = {
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']d'] = '@function.outer',
              [']c'] = '@class.outer',
            },
            goto_next_end = {
              [']D'] = '@function.outer',
              [']C'] = '@class.outer',
            },
            goto_previous_start = {
              ['[d'] = '@function.outer',
              ['[c'] = '@class.outer',
            },
            goto_previous_end = {
              ['[D'] = '@function.outer',
              ['[C'] = '@class.outer',
            },
          },
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
            },
          },
          lsp_interop = {
            enable = true,
            border = 'none',
            peek_definition_code = {
              ["<leader>df"] = "@function.outer",
              ["<leader>dF"] = "@class.outer",
            },
          },
        },
      }
      opts = {
      }
    end,
  },
  {
    'nvim-treesitter/playground',
    cond = not vim.g.vscode
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    cond = not vim.g.vscode
  },
  {
    'nvim-telescope/telescope.nvim',
    cond = not vim.g.vscode,
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      -- Setup
      local config = require'telescope'
      config.setup({
        defaults = {
          layout_strategy = 'vertical',
          mappings = {
            i = {
              ["<C-e>"] = "move_selection_previous",
            },
            n = {
              ["n"] = "move_selection_next",
              ["e"] = "move_selection_previous",
            },
          },
          -- preview = false,
        },
        extensions = {
          fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
          }
        }
      })
      require'telescope'.load_extension('fzy_native')
      -- Mappings
      local builtin = require'telescope.builtin'
      vim.keymap.set('n', '<leader>tf', builtin.find_files, { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>tg', builtin.live_grep, { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>tb', builtin.buffers, { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>th', builtin.help_tags, { noremap = true, silent = true })
    end,
  },
  {
    'nvim-telescope/telescope-fzy-native.nvim',
    cond = not vim.g.vscode
  },
  {
    'neovim/nvim-lspconfig',
    cond = not vim.g.vscode,
    config = function()
      local lspconfig = require'lspconfig'
      local util = lspconfig.util
      lspconfig.clangd.setup{
        flags = {
          debounce_text_changes = 500
        },
        root_dir = util.root_pattern('compile_commands.json'),
        cmd = { 'clangd', '--cross-file-rename', },
        capabilities = {
          textDocument = {
            semanticHighLightingCapabilities = {
              semanticHighLighting = false
            }
          }
        },
        on_attach = function (client, bufnr)
          -- Set clang-specific mapping
          vim.api.nvim_buf_set_keymap(bufnr, 'n' , '<leader>o', '<cmd>ClangdSwitchSourceHeader<cr>', { noremap=true })
          set_lsp_mappings(client, bufnr)
          -- require'semantic_tokens'.on_attach(client, buffer)
        end
      }
      lspconfig.pyright.setup{
        -- root_dir = util.root_pattern('.'),
        python = {
          pythonPath = '/usr/bin/python'
        },
        on_attach = function (client, bufnr)
          set_lsp_mappings(client, bufnr)
        end
      }
      lspconfig.gopls.setup{
        cmd = {'/usr/bin/gopls', 'serve'},
        settings = {
          gopls = {
            analyses = {
              unusedparams = true
            },
            staticcheck = true,
            linksInHover = false,
            codelenses = {
              generate = true,
              gc_details = true,
              regenerate_cgo = true,
              tidy = true,
              upgrade_depdendency = true,
              vendor = true,
            },
            usePlaceholders = true,
          }
        },
        on_attach = function (client, bufnr)
          set_lsp_mappings(client, bufnr)
        end
      }
    end
  },
  {
    'numToStr/Comment.nvim',
    opts = {
      -- https://github.com/numToStr/Comment.nvim/wiki/Extended-Keybinding
      -- extended = true
    }
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    cond = not vim.g.vscode
  },
  {
    'hrsh7th/nvim-cmp',
    cond = not vim.g.vscode,
    config = function()
      local cmp = require'cmp'
      cmp.setup({
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'buffer' },
      }),
      mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-e>'] = cmp.mapping.select_prev_item(),
        ['<C-y>'] = cmp.mapping.confirm(),
        -- ['<C-e>'] = cmp.mapping.abort(),
      }),
      experimental = { }
    })
    end
  },
  {
    'mhartington/formatter.nvim',
    config = function()
      local util = require'formatter.util'
      require'formatter'.setup{
        -- TODO: jq
        lua = {
          require'formatter.filetypes.lua'.stylua
        },
        python = {
          require'formatter.filetypes.python'.yapf
        }
      }
    end
  },
  {
    'bkad/CamelCaseMotion',
    config = function()
      vim.api.nvim_call_function('camelcasemotion#CreateMotionMappings', { ',' })
    end
  },
  {
    'tibabit/vim-templates',
    init = function()
      vim.g.tmpl_search_paths = { '~/.local/share/nvim/templates' }
    end
  },
  {
    'ziglang/zig.vim',
    cond = not vim.g.vscode
  },
  {
    'vim-airline/vim-airline',
    cond = not vim.g.vscode,
    dependencies = { 'vim-airline/vim-airline-themes' },
    init = function()
      vim.g.airline_powerline_fonts = 1
      vim.g['airline#extensions#whitespace#mixed_indent_algo'] = 1
    end
  },
  { 'junegunn/vim-easy-align' },
  { 'tpope/vim-endwise' },
  { 'tpope/vim-eunuch' },
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', 'gb', '<cmd>:Git blame<cr>', { noremap = true, silent = true })
    end
  },
  { 'tpope/vim-scriptease' },
  { 'tpope/vim-surround' },
  {
    'glench/vim-jinja2-syntax',
    enabled = not is_mac(),
    cond = not vim.g.vscode,
  },
  {
    'aklt/plantuml-syntax',
    enabled = not is_mac(),
    cond = not vim.g.vscode,
  },
}
