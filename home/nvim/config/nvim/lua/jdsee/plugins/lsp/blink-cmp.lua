return {
  'saghen/blink.cmp',
  enabled = false,
  lazy = false, -- lazy loading handled internally
  dependencies = 'rafamadriz/friendly-snippets',

  -- use a release tag to download pre-built binaries
  version = 'v0.*',

  opts = {
    highlight = {
      use_nvim_cmp_as_default = true,
    },
    nerd_font_variant = 'normal',
    accept = { auto_brackets = { enabled = true } },
    trigger = { signature_help = { enabled = true } },

    keymap = {
      show = '<C-space>',
      hide = '<C-e>',
      accept = { '<C-y>', '<Tab>', '<CR>' },
      select_prev = { '<Up>', '<C-p>' },
      select_next = { '<Down>', '<C-n>' },

      show_documentation = {},
      hide_documentation = {},
      scroll_documentation_up = '<C-b>',
      scroll_documentation_down = '<C-f>',

      snippet_forward = { '<C-n>', '<Tab>' },
      snippet_backward = { '<C-p>', '<S-Tab>' },
    },
  }
}
