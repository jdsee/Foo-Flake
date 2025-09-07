-- harpoon
-- https://github.com/ThePrimeagen/harpoon

return {
  'ThePrimeagen/harpoon',
  enabled = false,
  branch = "harpoon2",
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim'
  },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
    vim.keymap.set("n", "<leader>hd", function() harpoon:list():remove() end)
    vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<C-7>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<C-8>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<C-9>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<C-0>", function() harpoon:list():select(4) end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-K>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<C-J>", function() harpoon:list():next() end)



    -- TELESCOPE
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end

    vim.keymap.set("n", "<leader>hh", function() toggle_telescope(harpoon:list()) end,
      { desc = "Open harpoon window" })
  end
}

-- OLD KEYBINDS
-- vim.keymap.set("n", "<leader>ha", function()
--   mark.add_file()
--   vim.cmd(":do User")
-- end, { desc = "Harpoon: Add file" })
-- vim.keymap.set('n', '<Leader>hl', ui.toggle_quick_menu)
-- vim.keymap.set('n', '<Leader>hr', mark.rm_file)
-- vim.keymap.set('n', '<Leader>hh', mark.toggle_file)
-- vim.keymap.set('n', '<A-h>', mark.toggle_file)
-- vim.keymap.set('n', '<A-y>', ui.toggle_quick_menu)
-- vim.keymap.set('n', '<A-p>', ui.nav_prev)
-- vim.keymap.set('n', '<A-n>', ui.nav_next)
-- vim.keymap.set('n', '<A-u>', function() ui.nav_file(1) end)
-- vim.keymap.set('n', '<A-i>', function() ui.nav_file(2) end)
-- vim.keymap.set('n', '<A-o>', function() ui.nav_file(3) end)
-- vim.keymap.set('n', '<A-;>', function() ui.nav_file(4) end)
