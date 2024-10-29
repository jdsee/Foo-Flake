return {
  'nvim-pack/nvim-spectre',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {
      '<leader>rs',
      function() require('spectre').toggle() end,
      mode = 'n',
      desc = 'Toggle Spectre',
    },
    {
      '<leader>r/',
      function() require('spectre').open_visual({ select_word = true }) end,
      mode = 'n',
      desc = 'Search current word',
    },
    {
      '<leader>r/',
      function() require('spectre').open_visual() end,
      mode = 'v',
      desc = 'Search current word',
    },
  },
}
