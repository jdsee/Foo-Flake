local function setup_zero()
  local lsp_zero = require('lsp-zero')
  lsp_zero.extend_lspconfig()
  lsp_zero.on_attach(require('jdsee.plugins.lsp.config').on_attach)
  lsp_zero.format_on_save({
    format_opts = {
      async = false,
      timeout_ms = 10000,
    },
    servers = {
      -- ['ts_ls'] = { 'javascript', 'typescript' },
      ['rust_analyzer'] = { 'rust' },
      ['lua-ls'] = { 'lua' },
    }
  })
  lsp_zero.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»'
  })
end

local function setup_servers()
  local lspconfig = require('lspconfig')
  local lsp_zero = require('lsp-zero')

  lspconfig.bashls.setup({})
  lspconfig.cssls.setup({})
  lspconfig.elmls.setup({})
  lspconfig.gleam.setup({})
  lspconfig.jsonls.setup({})
  lspconfig.lemminx.setup({})
  lspconfig.phpactor.setup({})
  lspconfig.ts_ls.setup({})
  lspconfig.volar.setup({})
  lspconfig.ocamllsp.setup({})
  lspconfig.postgres_lsp.setup({})
  lspconfig.sqls.setup({}) -- TODO: Replace with sqlls when found on Nix
  lspconfig.roc_ls.setup({})
  lspconfig.terraformls.setup({})
  lspconfig.ruff.setup({})
  lspconfig.pyright.setup({})
  lspconfig.rescriptls.setup({})
  lspconfig.nushell.setup({})
  lspconfig.kotlin_language_server.setup({})

  lspconfig.nextls.setup({
    cmd = { "nextls", "--stdio" },
    init_options = {
      extensions = {
        credo = { enable = true }
      },
      experimental = {
        completions = { enable = true }
      }
    }
  })

  lspconfig.biome.setup({
    filetypes = {
      "javascript", "javascriptreact", "json", "jsonc",
      "typescript", "typescript.tsx", "typescriptreact",
      "astro", "svelte", "vue", "css",
      "rescript",
    },
  })

  lspconfig.tailwindcss.setup({
    filetypes = {
      'aspnetcorerazor', 'astro', 'astro-markdown', 'blade', 'clojure', 'django-html', 'htmldjango', 'edge', 'eelixir',
      'elixir', 'ejs', 'erb', 'eruby', 'gohtml', 'gohtmltmpl', 'haml', 'handlebars', 'hbs', 'html', 'html-eex', 'heex',
      'jade', 'leaf', 'liquid', 'markdown', 'mdx', 'mustache', 'njk', 'nunjucks', 'php', 'razor', 'slim', 'twig', 'css',
      'less', 'postcss', 'sass', 'scss', 'stylus', 'sugarss', 'javascript', 'javascriptreact', 'reason', 'rescript',
      'typescript', 'typescriptreact', 'vue', 'svelte', 'templ', 'ocaml'
    },
  })

  lspconfig.lua_ls.setup {
    on_attach = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      lspconfig.lua_ls.setup(lua_opts)
    end
  }

  lspconfig.nil_ls.setup {
    autostart = true,
    settings = {
      ['nil'] = {
        formatting = {
          command = { "nixpkgs-fmt" },
        },
      },
    },
  }
end

local function setup_mason()
  local lsp_zero = require('lsp-zero')

  require('mason').setup()
  require('mason-lspconfig').setup {
    handlers = {
      lsp_zero.default_setup,
      rust_analyzer = lsp_zero.noop,
      lua_ls = function()
        local lua_opts = lsp_zero.nvim_lua_ls()
        require('lspconfig').lua_ls.setup(lua_opts)
      end,
      ts_ls = function()
        require 'lspconfig'.ts_ls.setup {
          init_options = {
            plugins = {
              {
                name = "@vue/typescript-plugin",
                location = "node_modules/@vue/typescript-plugin",
                languages = { "javascript", "typescript", "vue" },
              },
            },
          },
          filetypes = {
            "javascript",
            "typescript",
            "vue",
          },
        }
      end
    },
  }
end

return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason-lspconfig.nvim',
      'williamboman/mason.nvim',
      'pmizio/typescript-tools.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      {
        'SmiteshP/nvim-navbuddy',
        dependencies = {
          'SmiteshP/nvim-navic',
          'MunifTanjim/nui.nvim'
        },
        opts = {
          lsp = { auto_attach = true, }
        }
      }
    },
    config = function()
      setup_zero()
      setup_servers()
      setup_mason()
    end,
  }
}
