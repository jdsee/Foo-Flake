-- indent-blankline
-- https://github.com/lukas-reineke/indent-blankline.nvim

return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  config = function()
    require('ibl').setup()
    vim.opt.list = true
    vim.opt.listchars:append('trail:-')
    vim.opt.listchars:append('tab:>>>')
    -- vim.opt.listchars:append('eol:%')
  end,
}
