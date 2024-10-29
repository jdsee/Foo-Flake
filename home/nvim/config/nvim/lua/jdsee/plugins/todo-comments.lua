return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local todo = require('todo-comments')
    todo.setup()
    vim.keymap.set('n', ']t', todo.jump_next, { desc = 'Next todo comment' })
    vim.keymap.set('n', '[t', todo.jump_prev, { desc = 'Previous todo comment' })
    vim.keymap.set('n', '[t', todo.jump_prev, { desc = 'Previous todo comment' })
    vim.keymap.set('n', '<leader>xt', ':TodoTrouble<cr>', { desc = 'Open Todos in Trouble' })
    vim.keymap.set('n', '<leader>ft', ':TodoTelescope<cr>', { desc = 'Open Todos in Trouble' })
  end
}
