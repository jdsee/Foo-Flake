-- NVIM AUTOCOMMANDS

-- Open help in vertical split
vim.cmd [[
  au FileType help wincmd L
]]

-- Terminal Defaults
vim.cmd [[
  augroup Terminal
      au!
      au TermEnter * startinsert                     "" start terminal in insert mode
      au TermOpen * :set nonumber norelativenumber   "" disable linenumbers in terminal
      au TermOpen * nnoremap <buffer> <C-c> i<C-c>   "" use Ctrl-c in terminal
  augroup END
]]

-- TODO: Try to delay saving the file or otherwise typst recompiling to prevent zathura from crashing
vim.api.nvim_create_autocmd(
  { 'InsertLeave', --[['TextChanged', 'TextChangedI']] }, {
    pattern = { '*.typ' },
    command = 'silent write',
  })

local text_filetypes = { '*.md', '*.adoc', '*.tex', '*.txt', '*.typ' }

-- Set insert mappings for German umlauts in text files
vim.api.nvim_create_autocmd(
  { 'BufEnter' }, {
    group = vim.api.nvim_create_augroup('TextFileSettings', { clear = true }),
    pattern = text_filetypes,
    command = "setlocal spell wrap",
  })

-- Set rustfmt as format expression in rust files. See ':help gq'
vim.api.nvim_create_autocmd(
  { 'BufEnter' }, {
    pattern = { '*.rs' },
    command = 'set fp=rustfmt',
  })

-- Set mappings only for quickfix windows
-- TODO: make this work
-- vim.cmd [[
--   augroup QuickFix
--     au FileType qf <buffer> nnoremap o <CMD>.cc<CR>
--     au FileType qf <buffer> nnoremap <CR> <CMD>.cc<CR>
--   augroup END
-- ]]

-- Prevent creation of insecure copies of gopass files
vim.cmd [[
  au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile
]]

-- Make macro indicator visible with cmdheight=0
vim.api.nvim_create_autocmd(
  'RecordingEnter', {
    pattern = '*',
    command = 'set cmdheight=1',
  })
vim.api.nvim_create_autocmd(
  'RecordingLeave', {
    pattern = '*',
    command = 'set cmdheight=0',
  })

-- Turn off cursorline on inactive buffers (stolen from TJ)
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
  vim.api.nvim_create_autocmd(event, {
    group = group,
    pattern = pattern,
    callback = function()
      vim.opt_local.cursorline = value
    end,
  })
end
set_cursorline('WinLeave', false)
set_cursorline('WinEnter', true)
set_cursorline('FileType', false, 'TelescopePrompt')

-- HACK:
-- nvim-ts-autotag doesn't work on rescript files for some reason.
-- Setting the filetype again after opening the buffer seems to fix it.
vim.api.nvim_create_autocmd(
  { 'BufEnter' }, {
    group = vim.api.nvim_create_augroup('RescriptFiletypeHack', { clear = true }),
    pattern = "*.res",
    command = "call timer_start(200, { tid -> execute('set filetype=rescript')})",
  })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.gitlab-ci*.{yml,yaml}",
  callback = function()
    vim.bo.filetype = "yaml.gitlab"
  end,
})

-- Highlight on yank - defer until colorscheme is loaded
local function setup_yank_highlight()
  local yank_clip_hl_base = vim.api.nvim_get_hl(0, { name = 'Search' })
  vim.api.nvim_set_hl(0, "YankClipboard", { bg = yank_clip_hl_base.fg, fg = '#020202', bold = true })
  vim.api.nvim_set_hl(0, "YankNormal", { link = 'IncSearch' })
  vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    callback = function()
      local reg = vim.v.event.regname
      local hl_group = 'YankNormal'
      if reg == '*' or reg == '+' then
        hl_group = 'YankClipboard'
      end
      vim.hl.on_yank { timeout = 100, higroup = hl_group }
    end
  })
end

-- Flash on tmux focus (responds to focus events from tmux)
local tmux_flash_state = {}
local function setup_tmux_focus_flash()
  vim.api.nvim_create_autocmd({ 'FocusGained' }, {
    group = vim.api.nvim_create_augroup("TmuxFocusFlash", { clear = true }),
    callback = function()
      local current_win = vim.api.nvim_get_current_win()

      -- Clean up any existing flash for this window
      if tmux_flash_state[current_win] then
        vim.fn.timer_stop(tmux_flash_state[current_win].timer)
        if vim.api.nvim_win_is_valid(current_win) then
          vim.wo[current_win].winhighlight = tmux_flash_state[current_win].original_hl
        end
      end

      -- Store original state
      local original_hl = vim.wo[current_win].winhighlight
      tmux_flash_state[current_win] = {
        original_hl = original_hl,
        timer = nil
      }

      vim.api.nvim_set_hl(0, "TmuxFlash", { bg = '#ffdf87' })

      -- Apply flash
      vim.wo[current_win].winhighlight = 'Normal:TmuxFlash'

      -- Schedule revert with safer timing
      tmux_flash_state[current_win].timer = vim.fn.timer_start(150, function()
        if vim.api.nvim_win_is_valid(current_win) and tmux_flash_state[current_win] then
          vim.wo[current_win].winhighlight = tmux_flash_state[current_win].original_hl
          tmux_flash_state[current_win] = nil
        end
      end)
    end
  })

  -- Clean up on window close
  vim.api.nvim_create_autocmd({ 'WinClosed' }, {
    group = vim.api.nvim_create_augroup("TmuxFocusFlashCleanup", { clear = true }),
    callback = function(event)
      local win = tonumber(event.match)
      if tmux_flash_state[win] then
        vim.fn.timer_stop(tmux_flash_state[win].timer)
        tmux_flash_state[win] = nil
      end
    end
  })

  -- Emergency reset keymap
  vim.keymap.set('n', '<leader>tf', function()
    for win, state in pairs(tmux_flash_state) do
      if state.timer then
        vim.fn.timer_stop(state.timer)
      end
      if vim.api.nvim_win_is_valid(win) then
        vim.wo[win].winhighlight = state.original_hl
      end
    end
    tmux_flash_state = {}
    print("Tmux flash reset")
  end, { desc = "Reset tmux flash highlighting" })
end

-- Setup theme-dependent autocommands after colorscheme loads
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  group = vim.api.nvim_create_augroup("SetupThemingAutocommands", { clear = true }),
  callback = function()
    setup_tmux_focus_flash()
    setup_yank_highlight()
  end,
  once = true
})
