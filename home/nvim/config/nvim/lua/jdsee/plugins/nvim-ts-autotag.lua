return {
  'windwp/nvim-ts-autotag',
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    require('nvim-ts-autotag').setup({
      -- opts = {
      --   enable_close = true,
      --   enable_rename = true,
      --   enable_close_on_slash = false
      -- },
      -- aliases = {
      --   ['rescript'] = 'jsx',
      -- },
      -- -- Also override individual filetype configs, these take priority.
      -- -- Empty by default, useful if one of the "opts" global settings
      -- -- doesn't work well in a specific filetype
      -- per_filetype = {
      --   ["broken_filetype"] = {
      --     enable_close = false
      --   }
      -- },
      filetypes = {
        'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx',
        'rescript', 'css', 'lua', 'xml', 'php', 'markdown'
      },
    })
  end,
  lazy = true,
  event = "VeryLazy"
}
