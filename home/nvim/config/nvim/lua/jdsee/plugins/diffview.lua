return {
  'sindrets/diffview.nvim',
  config = function()
    vim.keymap.set('n', '<leader>dh', '<cmd>DiffviewFileHistory %<cr>', { desc = 'File history for current file' })
    vim.keymap.set('n', '<leader>dH', '<cmd>DiffviewFileHistory<cr>', { desc = 'File history for repo' })
    vim.keymap.set('n', '<leader>do', '<cmd>DiffviewOpen<cr>', { desc = 'Open diffview' })
    vim.keymap.set('n', '<leader>dd', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' })
  end,
}
