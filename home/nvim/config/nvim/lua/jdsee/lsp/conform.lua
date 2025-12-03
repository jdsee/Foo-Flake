return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>rf',
      function()
        require('conform').format({ async = true })
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  opts = {
    formatters_by_ft = {
      javascript = { 'biome' },
      javascriptreact = { 'biome' },
      typescript = { 'biome' },
      typescriptreact = { 'biome' },
      json = { 'biome' },
      jsonc = { 'biome' },
      css = { 'biome' },
      vue = { 'biome' },
      svelte = { 'biome' },
      astro = { 'biome' },
      rescript = { 'biome' },
      lua = { 'stylua' },
      nix = { 'nixpkgs_fmt' },
      python = { 'ruff_format' },
      go = { 'gofmt' },
      elm = { 'elm_format' },
      zig = { 'zigfmt' },
      bash = { 'shfmt' },
      sh = { 'shfmt' },
      php = { 'php_cs_fixer' },
    },
    default_format_opts = {
      lsp_format = 'fallback',
    },
    format_on_save = false,
  },
}

