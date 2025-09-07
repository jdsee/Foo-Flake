return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  opts = {
    focus = true,
    auto_close = true,
    modes = {
      lsp_document_symbols = {
        win = {
          type = "float",
          size = { width = 0.8, height = 0.5 },
          border = "rounded",
        },
        keys = {
          ["<cr>"] = "jump_close",
        },
      },
    },
  },
  keys = {
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    -- {
    --   'grr',
    --   function() require('trouble').toggle('lsp_references') end,
    --   desc = 'Buffer Diagnostics (Trouble)',
    -- },
    {
      'go',
      '<cmd>Trouble symbols toggle focus<cr>',
      desc = 'Document Symbols (Trouble)',
    },
    {
      '<leader>cl',
      '<cmd>Trouble lsp toggle focus=true win.position=right<cr>',
      desc = 'LSP Definitions / references / ... (Trouble)',
    },
    {
      '<leader>xl',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List (Trouble)',
    },
    {
      '<leader>q',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List (Trouble)',
    },
  },
}
