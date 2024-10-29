return {
  {
    'Olical/conjure',
    config = function() 
      vim.g['conjure#mapping#doc_word'] = false
      vim.g['g:sexp_enable_insert_mode_mappings'] = false
      vim.keymap.set('n', '<LocalLeader>tt', '<cmd>ConjureCljRunCurrentTest<cr>')
      vim.keymap.set('n', '<LocalLeader>tn', '<cmd>ConjureCljRunCurrentNsTests<cr>')
      vim.keymap.set('n', '<LocalLeader>ta', '<cmd>ConjureCljRunAllTests<cr>')
    end
  },
  {
    'clojure-vim/vim-jack-in',
    dependencies = {
      'tpope/vim-dispatch',
      'radenling/vim-dispatch-neovim',
    }
  },
  {
    'tpope/vim-sexp-mappings-for-regular-people',
    dependencies = 'guns/vim-sexp'
  },
}
