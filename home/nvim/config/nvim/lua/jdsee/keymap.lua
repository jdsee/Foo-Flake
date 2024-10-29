-- General
vim.keymap.set('n', '<C-C>', ':noh<CR>', { nowait = true }) -- remove visual selection
vim.keymap.set('n', '<C-i>', '<C-i>')                       -- prevents implicit remap to <TAB>
vim.keymap.set('n', '<cr>', '<cr>')                         -- prevents implicit remap to <C-M>

-- Navigation
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true }) -- move up wrapped line
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true }) -- move down wrapped line

-- Text actions
vim.keymap.set('n', '<Leader>i', 'i_<Esc>r') -- insert single character
vim.keymap.set('n', '<Leader>o', 'o<Esc>')   -- insert line below in normal mode
vim.keymap.set('n', '<Leader>O', 'O<Esc>')   -- insert line above in normal mode

vim.keymap.set('x', 'J', ":m '>+1<CR>gv=gv") -- Move visual selection down
vim.keymap.set('x', 'K', ":m '<-2<CR>gv=gv") -- Move visual selection up

-- Files
vim.keymap.set('n', 'gf', ':edit <cfile><cr>') -- open non existing files with gf

-- Insert
vim.keymap.set('i', '<S-CR>', '<C-O>o')   -- Jump to new line in insert mode
vim.keymap.set('i', '<S-C-CR>', '<C-O>O') -- Jump to new line above in insert mode

-- Quickfixlist / Locationlist
vim.keymap.set('n', '<Leader>cn', '<CMD>cn<CR>') -- go to next quickfix entry
vim.keymap.set('n', '<Leader>cp', '<CMD>cp<CR>') -- go to next quickfix entry
vim.keymap.set('n', '<Leader>cN', '<CMD>cn<CR>') -- go to next quickfix entry
vim.keymap.set('n', '<Leader>cP', '<CMD>cp<CR>') -- go to next quickfix entry

-- Clipboard
local clip_reg = vim.fn.has('mac') == 1 and "*" or "+"
vim.keymap.set({ 'n', 'v' }, '<Leader>y', '"' .. clip_reg .. 'y')  -- copy to system clipboard
vim.keymap.set({ 'n', 'v' }, '<Leader>Y', '"' .. clip_reg .. 'y$') -- copy to end of line to system clipboard
vim.keymap.set({ 'n', 'v' }, '<Leader>p', '"' .. clip_reg .. 'p')  -- paste from system clipboard
vim.keymap.set({ 'n', 'v' }, '<Leader>P', '"' .. clip_reg .. 'P')  -- paste to end of line from system clipboard

-- Commandline
vim.keymap.set('c', '<c-g>', '<c-f>') -- open cmdline buffer
-- TODO: Map these only if first character
-- vim.keymap.set('c', ':', 'lua ')
-- vim.keymap.set('c', ';', '! ')

-- Refactoring
vim.keymap.set('n', '<A-S-j>', ':m .+1<CR>==')        -- move line down
vim.keymap.set('n', '<A-S-k>', ':m .-2<CR>==')        -- move line up
vim.keymap.set('i', '<A-S-j>', '<Esc>:m .+1<CR>==gi') -- move line down
vim.keymap.set('i', '<A-S-k>', ':m .+1<CR>==')        -- move line up
vim.keymap.set('v', '<A-S-j>', ":m '>+1<CR>gv=gv")    -- move line down
vim.keymap.set('v', '<A-S-k>', ":m '<-2<CR>gv=gv")    -- move line up

-- Options
vim.keymap.set('n', '<leader>ols', function()
  vim.opt.list = not vim.opt.list
end) -- move line up
