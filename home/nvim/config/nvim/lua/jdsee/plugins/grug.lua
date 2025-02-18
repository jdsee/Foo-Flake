local function find_curr_word()
  require('grug-far').open({ prefills = { search = vim.fn.expand("<cword>") } })
end

return {
  'MagicDuck/grug-far.nvim',
  config = function()
    local grug = require('grug-far')
    grug.setup();
    vim.keymap.set('v', '<leader>rj', grug.with_visual_selection)
    vim.keymap.set('n', '<leader>rj', find_curr_word)
    vim.keymap.set('n', '<leader>rs', find_curr_word)
    -- TODO: Toggling requires specification of instance
    -- vim.keymap.set('n', '<leader>rs', grug.toggle_instance)
  end
}
