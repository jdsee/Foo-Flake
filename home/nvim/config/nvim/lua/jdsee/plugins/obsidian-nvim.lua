return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = false,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "notes",
        path = "~/vaults/notes",
      },
    },

    daily_notes = {
      folder = "daily",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      template = "daily-template.md"
    },

    templates = {
      folder = "templates",
    },

    completion = {
      nvim_cmp = false,
      blink = true,
      min_chars = 2,
    },

    legacy_commands = false,
  },
}
