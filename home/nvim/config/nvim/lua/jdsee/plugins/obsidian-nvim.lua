return {
  'epwalsh/obsidian.nvim',
  enabled = false,
  -- version = '*',
  lazy = true,
  ft = 'markdown',

  dependencies = {
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
  },

  config = function()
    local obsidian = require('obsidian')
    obsidian.setup {
      event = {
        "BufReadPre /home/jdsee/mynotes/**.md",
        "BufNewFile /home/jdsee/mynotes/**.md",
      },

      workspaces = {
        {
          name = 'mynotes',
          path = '~/mynotes',
        },
      },

      daily_notes = {
        folder = '05 - Daily Notes',
        date_format = '%Y-%m-%d',
        template = nil,
      },

      templates = {
        subdir = "04 - Templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        substitutions = {},
      },

      mappings = {
        ['gd'] = {
          action = obsidian.util.gf_passthrough,
          opts = { noremap = false, expr = true, buffer = true },
        },
        ['gf'] = {
          action = obsidian.util.gf_passthrough,
          opts = { noremap = false, expr = true, buffer = true },
        },
        ['<leader>ox'] = {
          action = obsidian.util.toggle_checkbox,
          opts = { buffer = true },
        },
        ['<leader>ot'] = {
          action = obsidian.commands.template,
          opts = { buffer = true },
        },
      },

      note_id_func = function(title)
        -- 'My new note' will be given an ID that looks like '1657296016-my-new-note'
        local suffix = ""
        if title ~= nil then
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. "-" .. suffix
      end,
    }
  end,
}
