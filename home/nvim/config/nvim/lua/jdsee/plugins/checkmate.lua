return {
  "bngarren/checkmate.nvim",
  ft = "markdown",
  opts = {
    files = { "*.md" },
    keys = {
      ["gmt"] = {
        rhs = "<cmd>Checkmate toggle<CR>",
        desc = "Toggle todo item",
        modes = { "n", "v" },
      },
      ["gma"] = {
        rhs = "<cmd>Checkmate archive<CR>",
        desc = "Archive todos",
        modes = { "n" },
      },
    }
  },
}
