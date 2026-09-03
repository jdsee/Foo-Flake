-- treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter (main branch)
--
-- Migrated from the frozen `master` branch, which does not support Neovim 0.12.
-- The `main` branch drops `nvim-treesitter.configs`: parsers are installed via
-- `require('nvim-treesitter').install(...)` and highlighting is opt-in through
-- `vim.treesitter.start()` (left off here, matching the old `highlight.enable = false`).

local ensure_installed = {
  'vim', 'vimdoc', 'lua', 'luadoc', 'query',
  'html', 'javascript', 'typescript', 'svelte', 'vue', 'tsx',
  'rescript', 'css', 'xml', 'php', 'markdown', 'markdown_inline',
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
      'rescript-lang/tree-sitter-rescript',
    },
    build = ':TSUpdate',
    lazy = false,
    config = function()
      require('nvim-treesitter').setup()
      require('nvim-treesitter').install(ensure_installed)
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'VeryLazy',
    config = function()
      require('nvim-treesitter-textobjects').setup {
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      }

      local select = require 'nvim-treesitter-textobjects.select'
      local swap = require 'nvim-treesitter-textobjects.swap'
      local move = require 'nvim-treesitter-textobjects.move'

      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { desc = desc, silent = true })
      end

      -- select
      for _, m in ipairs { 'x', 'o' } do
        map(m, 'aa', function() select.select_textobject('@parameter.outer', 'textobjects') end, 'parameter outer')
        map(m, 'ia', function() select.select_textobject('@parameter.inner', 'textobjects') end, 'parameter inner')
        map(m, 'af', function() select.select_textobject('@function.outer', 'textobjects') end, 'function outer')
        map(m, 'if', function() select.select_textobject('@function.inner', 'textobjects') end, 'function inner')
        map(m, 'ac', function() select.select_textobject('@class.outer', 'textobjects') end, 'class outer')
        map(m, 'ic', function() select.select_textobject('@class.inner', 'textobjects') end, 'class inner')
        map(m, 'aP', function() select.select_textobject('@pipeline.outer', 'textobjects') end, 'pipeline outer')
        map(m, 'iP', function() select.select_textobject('@pipeline.inner', 'textobjects') end, 'pipeline inner')
      end

      -- swap
      map('n', 'g>>', function() swap.swap_next('@parameter.inner') end, 'swap next parameter')
      map('n', 'g>f', function() swap.swap_next('@function.inner') end, 'swap next function')
      map('n', 'g<<', function() swap.swap_previous('@parameter.outer') end, 'swap prev parameter')
      map('n', 'g<f', function() swap.swap_previous('@function.outer') end, 'swap prev function')

      -- move
      map({ 'n', 'x', 'o' }, ']m', function() move.goto_next_start('@function.outer', 'textobjects') end, 'next function start')
      map({ 'n', 'x', 'o' }, ']M', function() move.goto_next_end('@function.outer', 'textobjects') end, 'next function end')
      map({ 'n', 'x', 'o' }, '[m', function() move.goto_previous_start('@function.outer', 'textobjects') end, 'prev function start')
      map({ 'n', 'x', 'o' }, '[M', function() move.goto_previous_end('@function.outer', 'textobjects') end, 'prev function end')
      -- was a stray `[']o'] = '@loop.*'` under `move` on master (a no-op there);
      -- wire it to loop start, which is the apparent intent.
      map({ 'n', 'x', 'o' }, ']o', function() move.goto_next_start({ '@loop.inner', '@loop.outer' }, 'textobjects') end, 'next loop start')
    end,
  },
}
