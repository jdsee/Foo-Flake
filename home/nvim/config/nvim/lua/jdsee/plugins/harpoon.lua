-- harpoon
-- https://github.com/ThePrimeagen/harpoon

return {
  'ThePrimeagen/harpoon',
  enabled = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim'
  },
  config = function()
    local mark = require('harpoon.mark')
    local ui = require('harpoon.ui')
    local telescope = require('telescope')

    telescope.load_extension('harpoon')

    vim.keymap.set("n", "<leader>ha", function()
      mark.add_file()
      vim.cmd(":do User")
    end, { desc = "Harpoon: Add file" })

    vim.keymap.set('n', '<Leader>hl', ui.toggle_quick_menu)
    vim.keymap.set('n', '<Leader>hr', mark.rm_file)
    vim.keymap.set('n', '<Leader>hh', mark.toggle_file)
    vim.keymap.set('n', '<A-h>', mark.toggle_file)
    vim.keymap.set('n', '<A-y>', ui.toggle_quick_menu)
    vim.keymap.set('n', '<A-p>', ui.nav_prev)
    vim.keymap.set('n', '<A-n>', ui.nav_next)
    vim.keymap.set('n', '<A-u>', function() ui.nav_file(1) end)
    vim.keymap.set('n', '<A-i>', function() ui.nav_file(2) end)
    vim.keymap.set('n', '<A-o>', function() ui.nav_file(3) end)
    vim.keymap.set('n', '<A-;>', function() ui.nav_file(4) end)
  end
}
