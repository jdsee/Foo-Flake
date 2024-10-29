-- lualine
-- https://github.com/nvim-lualine/lualine.nvim

return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup {
      options = {
        theme = 'auto',
        globalstatus = true,
        section_separators = {
          left = '',
          right = ''
        },
      }
    }
  end,
}
