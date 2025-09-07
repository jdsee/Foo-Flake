return {
  "luckasRanarison/tailwind-tools.nvim",
  name = "tailwind-tools",
  enabled = false,
  build = ":UpdateRemotePlugins",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
    "neovim/nvim-lspconfig",
    "VonHeikemen/lsp-zero.nvim",
  },
  opts = {
    -- on_attach = require('jdsee.plugins.lsp.config').on_attach,
  },
}
