return {
  'saghen/blink.cmp',
  dependencies = {
    { 'rafamadriz/friendly-snippets' },
    { 'archie-judd/blink-cmp-words' },
    -- { 'marcoSven/blink-cmp-yanky', },
  },
  version = '1.6',
  opts = {
    keymap = {
      preset      = 'default',
      ['<CR>']    = { 'select_and_accept', 'fallback' },
      ['<C-u>']   = { 'scroll_signature_up', 'fallback' },
      ['<C-d>']   = { 'scroll_signature_down', 'fallback' },
      ['<Tab>']   = { 'snippet_forward', 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
      ['<C-k>']   = { 'fallback' },
    },

    appearance = {
      nerd_font_variant = 'mono'
    },

    completion = { documentation = { auto_show = false } },
    signature = { enabled = true },

    sources = {
      default = {
        'lsp',
        'path',
        'snippets',
        'omni',
        'buffer',
      },
    },

    per_filetype = {
      text = { 'dictionary' },
      markdown = { 'buffer', 'dictionary', 'thesaurus' },
    },

    providers = {
      snippets = {
        opts = {
          friendly_snippets = true,
          -- frameworks: https://github.com/rafamadriz/friendly-snippets/tree/main/snippets/frameworks
          -- languages: https://github.com/rafamadriz/friendly-snippets/blob/main/package.json
          extended_filetypes = {
            sh = { 'shelldoc' },
          },
        }
      },

      -- yank = {
      --   name = 'yank',
      --   module = 'blink-yanky',
      --   opts = {
      --     minLength = 5,
      --     onlyCurrentFiletype = true,
      --     trigger_characters = { '"' },
      --     kind_icon = '󰅍',
      --   },
      -- },
      --
      thesaurus = {
        name = 'blink-cmp-words',
        module = 'blink-cmp-words.thesaurus',
      },

      dictionary = {
        name = 'blink-cmp-words',
        module = 'blink-cmp-words.dictionary',
        opts = {
          -- The number of characters required to trigger completion.
          -- Set this higher if completion is slow, 3 is default.
          dictionary_search_threshold = 3,
        },
      },
    },
  }
}
