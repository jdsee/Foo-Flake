return {
  'windwp/nvim-autopairs',
  config = function() 
    local npairs = require 'nvim-autopairs'
    local Rule = require 'nvim-autopairs.rule'
    npairs.setup {
      disable_filetype = { 'TelescopePrompt' },
    }
    npairs.add_rules {
      Rule('$$', '$$', { 'latex', 'tex' }),
    }
  end,
}

