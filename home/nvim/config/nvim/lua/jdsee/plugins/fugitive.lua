-- https://github.com/tpope/vim-fugitive

return {
  'tpope/vim-fugitive',
  -- TODO: Consider moving all git plugins together
  config = function()
    vim.keymap.set('n', '<leader>gs', '<cmd>G<cr>')
    vim.keymap.set('n', '<leader>gl', '<cmd>vert G log<cr>')
    vim.keymap.set('n', '<leader>gL', '<cmd>0G log<cr>')
    vim.keymap.set('n', 'gd>', '<cmd>diffget //2<cr>')
    vim.keymap.set('n', 'gd<', '<cmd>diffget //3<cr>')
    vim.keymap.set('n', 'gdl', '<cmd>diffget //2<cr>')
    vim.keymap.set('n', 'gdh', '<cmd>diffget //3<cr>')
  end
}
