return {
  -- TODO: Want to try:
  -- - 'nvim-pack/nvim-spectre'
  -- - Nvim ChatGpt

  'tpope/vim-repeat',     -- repeat plugin commands with .
  'tpope/vim-surround',   -- work on surrounding characters like [(
  'tpope/vim-unimpaired', -- Pairs of hande bracket mappings
  'wellle/targets.vim',   -- inner style text objects
  'gleam-lang/gleam.vim', -- Syntax Highlighting and snippets for Gleam
  -- 'dhruvasagar/vim-table-mode', -- markdown table support
  -- 'ThePrimeagen/vim-be-good',   -- game to practice vim movements
  -- 'xiyaowong/transparent.nvim', -- Simple command to make bg transparent

  {
    'jdsee/umlauts.nvim',
    config = function() require('umlauts').setup() end,
  },

  --- Comment out Code with gc[motion] ---
  {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end,
  },

  --- Better UX for marks ---
  {
    'chentoast/marks.nvim',
    config = function() require('marks').setup() end,
  },

  --- Visualize Colorcodes ---
  {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end,
  },

  {
    'karb94/neoscroll.nvim',
    config = function() require('neoscroll').setup() end,
  },

  {
    'romgrk/barbar.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' }
  },

  {
    'stevearc/dressing.nvim',
    opts = {},
  },

  --- Incremental LSP rename ---
  {
    'smjonas/inc-rename.nvim',
    config = function()
      require('inc_rename').setup {
        input_buffer_type = 'dressing',
      }
    end,
  },

  { 'aspeddro/rescript-tools.nvim' },

  { 'lepture/vim-velocity' },

  { 'ocaml-mlx/ocaml_mlx.nvim' },

}
