return {
  "otavioschwanck/arrow.nvim",
  enabled = true,
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
  },
  opts = {
    show_icons = true,
    leader_key = '<C-j>',
    buffer_leader_key = 'm',
  },
  config = function()
    local arrow = require 'arrow'

    arrow.setup {
      show_icons = true,
      hide_handbook = true,
      leader_key = '<TAB>',
      mappings = {
        edit = "e",
        toggle = "h",
        next_item = "n",
        prev_item = "p",
      },
      index_keys = "jkl;m,./1234567890",
    }
  end,
}
