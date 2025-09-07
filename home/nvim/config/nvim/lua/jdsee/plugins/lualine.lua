-- lualine
-- https://github.com/nvim-lualine/lualine.nvim

local function winbar_filename()
  local filename = vim.fn.expand('%f')
  if filename == '' then
    return '[No Name]'

  elseif vim.bo.modified then
    return '%#DiagnosticError# ● ' .. filename .. '%*'
  elseif vim.bo.readonly then
    return '%#DiagnosticWarn# [RO] ' .. filename .. '%*'
  else
    return filename
  end
end

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
      },
      sections = {
        lualine_c = { 'filename' }
      },
      winbar = {
        lualine_z = { winbar_filename }
      },
      inactive_winbar = {
        lualine_z = { winbar_filename }
      }
    }
  end,
}
