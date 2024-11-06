-- treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter

return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',
    'rescript-lang/tree-sitter-rescript',
  },
  build = ':TSUpdate',
  lazy = false,
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'vim', 'vimdoc', 'lua', 'luadoc',
        'html', 'javascript', 'typescript', 'svelte', 'vue', 'tsx', 'rescript', 'css', 'xml', 'php', 'markdown'
      },
      highlight = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          }
        },
        swap = {
          enable = true,
          swap_next = {
            ['g>>'] = '@parameter.inner',
            ['g>f'] = '@function.inner',
          },
          swap_previous = {
            ['g<<'] = '@parameter.outer',
            ['g<f'] = '@function.outer',
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']m'] = '@function.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
          },
          --
          -- You can use regex matching (i.e. lua pattern) and/or pass a list in a 'query' key to group multiple queires.
          [']o'] = '@loop.*',
        },
      },
    }
  end,

  opts = function(_, opts) -- this is needed so you won't override your default nvim-treesitter configuration
    -- vim.list_extend(opts.ensure_installed, {
    --   'rescript',
    -- })

    local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
    parser_config.rescript = {
      install_info = {
        url = 'https://github.com/rescript-lang/tree-sitter-rescript',
        branch = 'main',
        files = { 'src/scanner.c' },
        generate_requires_npm = false,
        requires_generate_from_grammar = true,
        use_makefile = true, -- macOS specific instruction
      },
    }
  end,
}
