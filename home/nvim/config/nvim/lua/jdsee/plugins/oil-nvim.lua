function _G.get_oil_winbar()
  local dir = require("oil").get_current_dir()
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    return vim.api.nvim_buf_get_name(0)
  end
end

-- Opens terminal in current directory and adds 'ls -la <file>' to shell history
-- File under cursor is available for shell expansion
-- !$   filename
-- !^   filepath (absolute)
local function open_oil_dir_in_tmux()
  local oil = require("oil")
  local current_dir = oil.get_current_dir()

  if not current_dir then
    vim.notify("Not in an Oil buffer", vim.log.levels.WARN)
    return
  end

  local entry = oil.get_cursor_entry()
  local file_path = entry and (current_dir .. entry.name) or current_dir
  local filename = vim.fn.fnamemodify(file_path, ":t")
  local history_cmd = string.format("echo \"ls %s %s\" >> ~/.zsh_history; fc -R",
    vim.fn.shellescape(file_path),
    vim.fn.shellescape(filename))

  local calling_from_tmux = vim.fn.getenv("TMUX") ~= vim.NIL
  if calling_from_tmux then
    local cmd = string.format("tmux new-window -c %s '%s; exec $SHELL'",
      vim.fn.shellescape(current_dir),
      history_cmd)
    vim.fn.system(cmd)
    vim.notify("Opened " .. current_dir .. " in new tmux window")
  else
    vim.cmd(string.format("terminal cd %s && %s && $SHELL",
      vim.fn.shellescape(current_dir),
      history_cmd))
  end
end

return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'SirZenith/oil-vcs-status',
  },
  config = function()
    local oil = require('oil')
    local actions = require('oil.actions')

    local function toggle_cwd_float()
      oil.toggle_float(vim.fn.getcwd())
    end

    local detailsVisible = false

    oil.setup(
      {
        cleanup_delay_ms = false, -- prevent removal of buffers from jumplist
        delete_to_trash = true,
        view_options = {
          show_hidden = true,
        },
        columns = {
          'icon',
          -- 'permissions',
        },
        win_options = {
          signcolumn = 'number',
          winbar = "%#@attribute.builtin#%{v:lua.get_oil_winbar()}",
        },
        preview = {
          max_width = 0.9,
          min_width = 0.6,
        },
        keymaps = {
          ['H'] = actions.parent,
          ['L'] = actions.select,
          ['gp'] = actions.preview,
          ['gx'] = actions.open_terminal,
          ['go'] = open_oil_dir_in_tmux,
          ['q'] = oil.close,
          ['<leader>j'] = oil.close,
          ["gd"] = {
            desc = "Toggle file detail view",
            callback = function()
              detailsVisible = not detailsVisible
              if detailsVisible then
                oil.set_columns({ "icon", "permissions", "size", "mtime" })
              else
                oil.set_columns({ "icon" })
              end
            end,
          },
        },
      }
    )

    vim.keymap.set('n', '<leader>j', oil.open)
    vim.keymap.set('n', '<S-->', toggle_cwd_float)

    local oil_vcs = require('oil-vcs-status')
    local status_const = require "oil-vcs-status.constant.status"
    local StatusType = status_const.StatusType

    oil_vcs.setup {
      status_symbol = {
        [StatusType.Added]               = "",
        [StatusType.Copied]              = "󰆏",
        [StatusType.Deleted]             = "",
        [StatusType.Ignored]             = "",
        [StatusType.Modified]            = "",
        [StatusType.Renamed]             = "",
        [StatusType.TypeChanged]         = "󰉺",
        [StatusType.Unmodified]          = " ",
        [StatusType.Unmerged]            = "",
        [StatusType.Untracked]           = "",
        [StatusType.External]            = "",

        [StatusType.UpstreamAdded]       = "󰈞",
        [StatusType.UpstreamCopied]      = "󰈢",
        [StatusType.UpstreamDeleted]     = "",
        [StatusType.UpstreamIgnored]     = " ",
        [StatusType.UpstreamModified]    = "󰏫",
        [StatusType.UpstreamRenamed]     = "",
        [StatusType.UpstreamTypeChanged] = "󱧶",
        [StatusType.UpstreamUnmodified]  = " ",
        [StatusType.UpstreamUnmerged]    = "",
        [StatusType.UpstreamUntracked]   = " ",
        [StatusType.UpstreamExternal]    = "",
      }
    }
  end
}
