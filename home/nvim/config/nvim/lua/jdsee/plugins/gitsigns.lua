-- gitsigns
-- https://github.com/lewis6991/gitsigns.nvim


return {
  'lewis6991/gitsigns.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local gitsigns = require('gitsigns')
    local M = {}

    gitsigns.setup()

    function M.blame_full_line()
      gitsigns.blame_line {
        full = true,
      }
    end

    function M.diffthis_home()
      gitsigns.diffthis('~')
    end

    -- Keybindings
    vim.keymap.set('n', '<Leader>gg', ':Gitsigns<cr>')
    vim.keymap.set('n', '<Leader>g?', M.blame_full_line)
    vim.keymap.set('n', '<Leader>ga', gitsigns.stage_hunk)
    vim.keymap.set('n', '<Leader>gA', gitsigns.undo_stage_hunk)
    vim.keymap.set('n', '<Leader>gu', gitsigns.reset_hunk)
    vim.keymap.set('n', '<Leader>gd', M.diffthis_home)
    vim.keymap.set('n', '<Leader>gh', gitsigns.preview_hunk_inline)
    vim.keymap.set('n', ']c', gitsigns.next_hunk)
    vim.keymap.set('n', '[c', gitsigns.prev_hunk)
  end,
}
