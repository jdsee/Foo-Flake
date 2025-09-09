local function toggle_virtual_text()
  vim.diagnostic.config {
    virtual_text = not vim.diagnostic.config().virtual_text
  }
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'saghen/blink.cmp' },
    { 'j-hui/fidget.nvim' },
  },
  opts = {
    keymaps = {
      { 'n', 'gD',         vim.lsp.buf.declaration },
      { 'n', 'gd',         vim.lsp.buf.definition },
      { 'n', 'gi',         vim.lsp.buf.implementation },
      { 'n', '<leader>a',  vim.lsp.buf.code_action },
      { 'n', '<Leader>rr', vim.lsp.buf.rename },
      { 'n', '<Leader>rn', vim.lsp.buf.rename },
      { 'n', '<Leader>rf', vim.lsp.buf.format },
      { 'n', 'gh',         vim.diagnostic.open_float },
      { 'n', '<leader>ov', toggle_virtual_text },
      { 'i', '<C-o>',      vim.lsp.buf.signature_help },
    },
    servers = {
      bashls = {},                          -- bash
      cssls = {},                           -- css
      elmls = {},                           -- elm
      gleam = {},                           -- gleam
      jsonls = {},                          -- json
      lemminx = {},                         -- xml
      phpactor = {},                        -- php
      -- ts_ls = {},                           -- typescript/javascript
      vue_ls = {},                          -- vue
      ocamllsp = {},                        -- ocaml
      postgres_lsp = {},                    -- postgresql
      sqls = {},                            -- sql
      roc_ls = {},                          -- roc
      terraformls = {},                     -- terraform
      pyright = {},                         -- python
      ruff = {},                            -- python (linter/formatter)
      rescriptls = {},                      -- rescript
      nushell = {},                         -- nushell
      metals = {},                          -- scala
      kotlin_language_server = {},          -- kotlin (inofficial)
      kotlin_lsp = {},                      -- kotlin (official, pre alpha)
      docker_compose_language_service = {}, -- docker-compose
      dockerls = {},                        -- dockerfile
      helm_ls = {},                         -- helm
      zls = {},                             -- zig
      gopls = {},                           -- go
      templ = {},                           -- templ (go)
      nextls = {                            -- elixir
        cmd = { "nextls", "--stdio" },
        init_options = {
          extensions = {
            credo = { enable = true }
          },
          experimental = {
            completions = { enable = true }
          }
        }
      },
      biome = { -- javascript/typescript (formatter/linter)
        filetypes = {
          "javascript", "javascriptreact", "json", "jsonc",
          "typescript", "typescript.tsx", "typescriptreact",
          "astro", "svelte", "vue", "css",
          "rescript",
        },
      },
      lua_ls = { -- lua
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      },
      nil_ls = { -- nix
        settings = {
          ['nil'] = {
            formatting = {
              command = { "nixpkgs-fmt" },
            },
          },
        },
      }
    },
  },
  config = function(_, opts)
    local blink = require('blink.cmp')
    local capabilities = blink.get_lsp_capabilities()

    for server_name, config in pairs(opts.servers) do
      local server_config = vim.tbl_deep_extend("force", { capabilities = capabilities }, config)
      vim.lsp.config(server_name, server_config)
      vim.lsp.enable(server_name)
    end

    -- SIGNS
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "✘",
          [vim.diagnostic.severity.WARN] = "▲",
          [vim.diagnostic.severity.HINT] = "⚑",
          [vim.diagnostic.severity.INFO] = "»",
        }
      },
    })

    -- HANDLE ATTACH
    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(event)
        local bufnr = event.buf
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if not client then
          return
        end

        -- KEYBINDS
        local lsp_opts = { buffer = bufnr, silent = true }
        for _, keymap in ipairs(opts.keymaps) do
          local mode, lhs, rhs = unpack(keymap)
          vim.keymap.set(mode, lhs, rhs, lsp_opts)
        end
      end
    })
  end
}
