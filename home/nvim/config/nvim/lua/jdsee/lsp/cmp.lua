return {
  'hrsh7th/nvim-cmp',
  enabled = false,
  dependencies = {
    'L3MON4D3/LuaSnip',
    'VonHeikemen/lsp-zero.nvim',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-path',
    'dmitmel/cmp-digraphs',
    'rafamadriz/friendly-snippets',
    'saadparwaiz1/cmp_luasnip',
    'onsails/lspkind.nvim',
    "tailwind-tools",
  },
  config = function()
    local cmp = require('cmp')
    local lsp_zero = require('lsp-zero')
    local lspkind = require('lspkind')
    local tailwind_tools = require("tailwind-tools.cmp")
    lspkind.init()

    require('luasnip.loaders.from_vscode').lazy_load()

    cmp.setup {
      preselect = 'item',

      completion = {
        completeopt = 'menu,menuone,noinsert'
      },

      sources = {
        { name = 'digraphs' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'nvim_lua' },
        { name = 'path' },
        { name = 'luasnip' },
        { name = 'treesitter' },
        { name = 'conjure' },
        { name = 'buffer',    keyword_length = 5 },
      },

      mapping = cmp.mapping.preset.insert {
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<C-Space>'] = cmp.mapping.complete(),
        -- Navigate between snippet placeholder
        ['<C-h>'] = lsp_zero.cmp_action().luasnip_jump_forward(),
        ['<C-l>'] = lsp_zero.cmp_action().luasnip_jump_backward(),
        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
      },

      formatting = {
        format = lspkind.cmp_format({
          before = tailwind_tools.lspkind_format,
          mode = 'symbol',          -- show only symbol annotations
          maxwidth = 50,            -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          show_labelDetails = true, -- show labelDetails in menu. Disabled by default
        })
      }
    }
  end

}
