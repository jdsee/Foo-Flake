return {
  "mikavilpas/yazi.nvim",
  enabled = false,
  event = "VeryLazy",
  keys = {
    {
      "_",
      function()
        require("yazi").yazi()
      end,
      desc = "Open the file manager",
    },
    {
      "-",
      function()
        require("yazi").yazi(nil, vim.fn.getcwd())
      end,
      desc = "Open the file manager in nvim's working directory" ,
    },
  },
  opts = {
    open_for_directories = true,
  },
}
