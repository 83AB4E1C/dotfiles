local config = {}

function config.flipped()
  vim.cmd('colorscheme flipped')
end

function config.whisky()
  require('whiskyline').setup({})
end

function config.indent_blankline()
  require("indent_blankline").setup {
    show_current_context = true,
  }
end

function config.nvim_bufferline()
  require('bufferline').setup({
    options = {
      modified_icon = '✥',
      buffer_close_icon = '',
      always_show_bufferline = false,
    },
  })
end

function config.nvim_tree()
  require('nvim-tree').setup({
    disable_netrw = false,
    hijack_cursor = true,
    hijack_netrw = true,
  })
end

function config.autopairs()
  require("nvim-autopairs").setup()
end

function config.autotag()
  require('nvim-ts-autotag').setup()
end

function config.gitsigns()
  require("gitsigns").setup()
end

function config.telescope()
  require('telescope').setup({
    defaults = {
      layout_config = {
        horizontal = { prompt_position = 'top', results_width = 0.6 },
        vertical = { mirror = false },
      },
      sorting_strategy = 'ascending',
      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
    },
  })
  require('telescope').load_extension('fzy_native')
  require('telescope').load_extension('file_browser')
end

function config.nvim_treesitter()
  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'c', 'cpp', 'go', 'lua', 'rust', 'python', 'cmake', 'ninja',
      'make', 'bash', 'css', 'html', 'tsx', 'typescript', 'markdown',
      'markdown_inline',
    },
    highlight = {
      enable = true,
    },
  })
end

function config.nvim_lsp()
  local lspconfig = require("lspconfig")
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  local signs = {
    Error = ' ',
    Warn = ' ',
    Info = ' ',
    Hint = ' ',
  }

  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  vim.diagnostic.config({
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    virtual_text = {
      prefix = '🔥',
      source = true,
    },
  })

  lspconfig.lua_ls.setup({
    on_attach = function(client, _)
      client.server_capabilities.semanticTokensProvider = nil
    end,
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          enable = true,
          globals = { 'vim', 'packer_plugins' },
        },
        runtime = { version = 'LuaJIT' },
        workspace = {
          library = vim.list_extend({ [vim.fn.expand('$VIMRUNTIME/lua')] = true }, {}),
        },
      },
    },
  })

  lspconfig.clangd.setup({
    capabilities = capabilities,
    cmd = {
      'clangd',
      '--background-index',
      '--suggest-missing-includes',
      '--clang-tidy',
      '--header-insertion=iwyu',
    },
  })

  lspconfig.gopls.setup({
    cmd = { 'gopls', 'serve' },
    capabilities = capabilities,
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
    },
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  })

  lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
    settings = {
      ['rust-analyzer'] = {
        imports = {
          granularity = {
            group = 'module',
          },
          prefix = 'self',
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true,
        },
      },
    },
  })

  local servers = {
    'dockerls',
    'pyright',
    'jsonls',
    'html',
    'cssls',
    'tsserver',
    'tailwindcss',
  }

  for _, server in ipairs(servers) do
    lspconfig[server].setup({
      capabilities = capabilities,
    })
  end

  vim.lsp.handlers['workspace/diagnostic/refresh'] = function(_, _, ctx)
    local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
    local bufnr = vim.api.nvim_get_current_buf()
    vim.diagnostic.reset(ns, bufnr)
    return true
  end
end

function config.lspsaga()
  require('lspsaga').setup({})
end

function config.nvim_cmp()
  local cmp = require("cmp")
  if not cmp then return end
  cmp.setup({
    preselect = cmp.PreselectMode.Item,
    formatting = {
      fields = { "abbr", "kind", "menu" },
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<Tab>"] = cmp.mapping.confirm({ select = true }),
    }),
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
    }),
  })
end

function config.lua_snip()
  local ls = require('luasnip')
  ls.config.set_config({
    delete_check_events = 'TextChanged',
  })
  require('luasnip.loaders.from_vscode').lazy_load({
    paths = { vim.fn.stdpath('config') .. '/snippets' },
  })
end

return config
