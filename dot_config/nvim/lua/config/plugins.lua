-- vim: ft=lua
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
    'Shatur/neovim-ayu',
    priority = 1000,
    enabled = true,
    lazy = false,
    config = function()
      local use_mirage = false
      local colors = require('ayu.colors')
      colors.generate(use_mirage)
      require'ayu'.setup{
        mirage = use_mirage,
        terminal = true,
        overrides = {
          Comment = { italic = false },
          -- Statement = { fg = '#f48da4' },
          Statement = { fg = '#f795c5' },
          Statement = { fg = '#f69ad4' },
          -- Special = { fg = '#f28779' },
          Special = { fg = '#f07171' },
          LineNr = { fg = colors.comment },

          ['@lsp'] = {},
          ['@lsp.type.parameter'] = { fg = colors.fg },

          ['@type.builtin'] = { link = '@type' },

          ['@variable'] = { fg = colors.spell },
          ['@variable.builtin'] = { fg = colors.spell },
          ['@variable.member'] = { fg = colors.spell },
          ['@variable.parameter'] = { fg = colors.spell },

          ['@keyword.import'] = { fg = colors.special },
          ['@keyword.directive'] = { fg = colors.special },

          ['@function'] = { fg = colors.fg },
          ['@module'] = { fg = colors.fg },
          ['@spell'] = { fg = colors.spell },
        }
      }
      vim.cmd.colorscheme('ayu')
    end
  },
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
    'nvim-treesitter/nvim-treesitter',
    cond = not vim.g.vscode,
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local treesitter = require'nvim-treesitter'
      treesitter.setup{
        treesitter.install{ 'cpp', 'python', 'rust', 'go', 'zig', 'c_sharp' }
      }
      --   ensure_installed = { 'c', 'cpp', 'python', 'vim', 'lua', 'comment' },
      --   highlight = { enable = true },
      --   incremental_selection = { enable = true },
      --   indent = { enable = true },
      -- }
      -- opts = {
      -- }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    enabled = false,
    cond = not vim.g.vscode
  },
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    cond = not vim.g.vscode,
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzy-native.nvim',
        build = 'make'
      }
    },
    config = function()
      -- Setup
      local config = require'telescope'
      config.setup({
        defaults = {
          layout_strategy = 'vertical',
          path_display = { 'shorten' },
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

      -- TODO: move to lsp-specific initialization
      vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, { noremap = true, silent = true })
      -- vim.keymap.set('n', '<leader>gds', builtin.lsp_definitions({ jump_type = "split" }), { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations, { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>gs', vim.lsp.buf.signature_help, { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>gr', builtin.lsp_references, { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { noremap = true, silent = true })
    end,
  },
  {
    'nvim-telescope/telescope-fzy-native.nvim',
    cond = not vim.g.vscode
  },
  {
    'neovim/nvim-lspconfig',
    cond = not vim.g.vscode
  },
  {
    'mikesmithgh/kitty-scrollback.nvim',
    cond = not vim.g.vscode,
    enabled = true,
    lazy = true,
    cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth', 'KittyScrollbackGenerateCommandLineEditing' },
    event = { 'User KittyScrollbackLaunch' },
    -- version = '*', -- latest stable version, may have breaking changes if major version changed
    -- version = '^6.0.0', -- pin major version, include fixes and features that do not have breaking changes
    config = function()
      require('kitty-scrollback').setup()
    end,
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
    enalbed = false,
    cond = not vim.g.vscode
  },
  {
    'hrsh7th/nvim-cmp',
    enalbed = false,
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
  {
    'towolf/vim-helm',
    cond = not vim.g.vscode
  }
}
