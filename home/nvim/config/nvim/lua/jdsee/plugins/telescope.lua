return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'AckslD/nvim-neoclip.lua',
    'jvgrootveld/telescope-zoxide',
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
    'nvim-telescope/telescope-bibtex.nvim',
    'nvim-telescope/telescope-frecency.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    'tami5/sqlite.lua',
    'ThePrimeagen/git-worktree.nvim',
    'folke/trouble.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    },
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      version = "^1.0.0",
    },
  },
  config = function()
    local telescope = require 'telescope'
    local builtin = require 'telescope.builtin'
    local themes = require 'telescope.themes'
    local lga_actions = require 'telescope-live-grep-args.actions'

    telescope.setup {
      defaults = {
        prompt_prefix = ' ',
        defaults = {},
        mappings = {
          i = {
            ["<C-h>"] = "which_key",
            ["<c-t>"] = function() require('trouble.sources.telescope').open() end,
            ["<c-a>"] = function() require('trouble.sources.telescope').add() end,
          },
          n = {
            ["<c-t>"] = function() require('trouble.sources.telescope').open() end,
            ["<c-a>"] = function() require('trouble.sources.telescope').add() end,
          },
        },
      },
      pickers = {},
      extensions = {
        ['ui-select'] = {
          themes.get_dropdown(),
        },
        zoxide = {
          mappings = {
            ['<CR>'] = {
              keepinsert = true,
              action = function(selection)
                vim.cmd("cd " .. selection.path)
                vim.cmd("!cd " .. selection.path)
                builtin.find_files { cwd = selection.path }
              end,
            },
            ['<C-j>'] = {
              keepinsert = true,
              action = function(selection)
                builtin.find_files { cwd = selection.path }
              end,
            },
          }
        },
        bibtex = {
          context = true,
          context_fallback = false,
          custom_formats = {
            { id = 'typst', cite_marker = '@%s', pattern = '*.typ' },
          },
          global_files = {
            '~/.local/share/zotero/biblatex/bib/refs.bib',
          },
        },
        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              ['<C-k>'] = lga_actions.quote_prompt(),
              ['<C-i>'] = lga_actions.quote_prompt { postfix = ' --iglob ' },
            },
          },
        },
      }
    }

    local extensions = {
      'fzf',
      'ui-select',
      'zoxide',
      'bibtex',
      'git_worktree',
      'live_grep_args',
    }

    for _, extension in pairs(extensions) do
      telescope.load_extension(extension)
    end

    local function current_buffer_fuzzy_find()
      builtin.current_buffer_fuzzy_find(themes.get_dropdown())
    end

    local function buffers()
      builtin.buffers {
        sort_lastused = true,
      }
    end

    local function lsp_code_actions()
      builtin.lsp_code_actions(themes.get_cursor())
    end

    local function lsp_find_references()
      builtin.lsp_references({ trim_text = true }, themes.get_cursor())
    end

    local function find_all_files()
      builtin.find_files {
        hidden = true,
        follow = true,
      }
    end

    local function find_git_or_all_files()
      vim.cmd [[ silent! !git rev-parse --is-inside-work-tree ]]
      if vim.v.shell_error == 0
      then
        builtin.git_files()
      else
        find_all_files()
      end
    end

    local function find_nvim_files()
      builtin.find_files {
        opt = { cwd = "$XDG_HOME/neovim" },
        hidden = true
      }
    end

    local function spell_suggestions()
      builtin.spell_suggest(themes.get_cursor())
    end

    vim.keymap.set('n', '<C-S-A>', builtin.builtin)                       -- search telescope actions
    vim.keymap.set('n', '<Leader>ff', find_git_or_all_files)              -- git_files if git repo, else all files
    vim.keymap.set('n', '<Leader>fj', telescope.extensions.zoxide.list)   -- search autojump list
    vim.keymap.set('n', '<Leader>fa', find_all_files)                     -- search all files
    vim.keymap.set('n', '<Leader>fn', find_nvim_files)                    -- search files in neovim config
    vim.keymap.set('n', '<Leader>fg', builtin.live_grep)                  -- grep everywhere
    vim.keymap.set('n', '<Leader>f*', builtin.grep_string)                -- grep string under cursor
    vim.keymap.set('n', '<Leader>fh', builtin.help_tags)                  -- search help tags
    vim.keymap.set('n', '<Leader>fc', builtin.commands)                   -- search command history
    vim.keymap.set('n', '<Leader>s', builtin.treesitter)                  -- search treesitter structure
    vim.keymap.set('n', '<Leader>/', current_buffer_fuzzy_find)           -- grep current buffer
    vim.keymap.set('n', '<Leader>:', builtin.command_history)             -- search command history
    vim.keymap.set('n', '<Leader>fd', builtin.diagnostics)                -- search errors from lsp
    vim.keymap.set('n', '<Leader>a', lsp_code_actions)                    -- search code actions in telescope
    vim.keymap.set('n', '<Leader>fl', telescope.extensions.bibtex.bibtex) -- search errors from lsp
    -- vim.keymap.set('n', '<Tab>', buffers)                                 -- search buffers << disabled since mapping tab in newer tmux versions is still a pain
    vim.keymap.set('n', '<Leader>n', buffers)                             -- search buffers
    vim.keymap.set('n', 'z=', spell_suggestions)                          -- search spell suggestions
    vim.keymap.set('n', 'gR', lsp_find_references)                        -- find references with lsp (using Trouble.nvim vor now)
    vim.keymap.set('n', '<Leader>gw', telescope.extensions.git_worktree.git_worktrees)
    vim.keymap.set('n', '<Leader>gb', builtin.git_branches)               -- search git branches
    vim.keymap.set('n', '<Leader>gf', builtin.git_files)                  -- search git files
    vim.keymap.set('n', '<Leader>gc', builtin.git_commits)                -- search git commits
    vim.keymap.set('n', '<Leader>sft', builtin.filetypes)                 -- find and set filetype
  end,
}


