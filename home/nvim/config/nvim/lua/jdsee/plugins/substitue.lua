return {
  'gbprod/substitute.nvim',
  dependencies = {
    'gbprod/yanky.nvim',
  },
  config = function()
    local substitute = require('substitute')

    substitute.setup {
      on_substitute = require('yanky.integration').substitute(),
      range = {
        prefix = 'gs',
      },
      highlight_substituted_text = {
        enabled = true,
        timer = 500,
      },
    }

    vim.keymap.set('n', 'gs', substitute.operator, { noremap = true })
    vim.keymap.set('n', 'gss', substitute.line, { noremap = true })
    vim.keymap.set('x', 'gs', substitute.visual, { noremap = true })
    vim.keymap.set('n', 'S', substitute.eol, { noremap = true })

    vim.keymap.set("n", "gx", require('substitute.exchange').operator, { noremap = true })
    vim.keymap.set("n", "gxx", require('substitute.exchange').line, { noremap = true })
    vim.keymap.set("x", "X", require('substitute.exchange').visual, { noremap = true })
  end
}
