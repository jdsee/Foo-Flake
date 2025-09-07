return {
  'saghen/blink.cmp',
  dependencies = {
    { 'rafamadriz/friendly-snippets' },
    { 'archie-judd/blink-cmp-words' },
    -- { 'marcoSven/blink-cmp-yanky', },
  },
  version = '1.6',
  opts = {
    keymap = { preset = 'default' },
    appearance = {
      nerd_font_variant = 'mono'
    },
    completion = { documentation = { auto_show = false } },

    sources = {
      default = {
        'lsp',
        'path',
        'snippets',
        'buffer',
        'omni',
      },
    },

    per_filetype = {
      text = { 'dictionary' },
      markdown = { 'buffer', 'dictionary', 'thesaurus' },
    },

    providers = {
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
