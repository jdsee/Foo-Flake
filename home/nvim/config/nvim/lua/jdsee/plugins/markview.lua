return {
  enabled = false,
  "OXY2DEV/markview.nvim",
  lazy = false,
  dependencies = { "saghen/blink.cmp" },
  config = function()
    require("markview.extras.headings").setup()
    require("markview.extras.checkboxes").setup({
      ---@type string
      default = "X",

      --- Changes how checkboxes are removed.
      ---@type
      ---| "disable" Disables the checkbox.
      ---| "checkbox" Removes the checkbox.
      ---| "list_item" Removes the list item markers too.
      remove_style = "disable",

      ---@type string[][]
      states = {
        { " ", "/", "X", "-" },
        { "<", ">" },
        { "?", "!", "*" },
        { '"' },
        { "l", "b", "i" },
        { "S", "I" },
        { "p", "c" },
        { "f", "k", "w" },
        { "u", "d" },
      }
    })

    vim.keymap.set('n', '<leader>mx', '<cmd>Checkbox toggle<cr>')
    vim.keymap.set('n', '<leader>m>', '<cmd>Heading increase<cr>')
    vim.keymap.set('n', '<leader>m<,', '<cmd>Heading decrease<cr>')
  end,
};
