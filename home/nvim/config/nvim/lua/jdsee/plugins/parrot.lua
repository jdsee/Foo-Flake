local function decrypt(input_file)
  local handle = io.popen("gpg --quiet --decrypt " .. input_file)
  if handle then
    local output = handle:read("*a")
    handle:close()
    return output
  end
end

return {
  "frankroeder/parrot.nvim",
  tag = "v0.7.0",
  dependencies = { 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim' },
  -- optionally include "rcarriga/nvim-notify" for beautiful notifications
  lazy = true,
  config = function()
    local openai_api_key = decrypt(vim.fn.expand("$HOME") .. "/api_keys/openai.api.key.gpg")
    require("parrot").setup {
      providers = {
        openai = {
          api_key = openai_api_key,
        },
        -- pplx = {
        --   api_key = os.getenv "PERPLEXITY_API_KEY",
        -- },
        -- anthropic = {
        --   api_key = os.getenv "ANTHROPIC_API_KEY",
        -- },
        -- mistral = {
        --   api_key = os.getenv "MISTRAL_API_KEY",
        -- },
        -- gemini = {
        --   api_key = os.getenv "GEMINI_API_KEY",
        -- },
        -- groq = {
        --   api_key = os.getenv "GROQ_API_KEY",
        -- },
        -- ollama = {} -- provide an empty list to make provider available
      },
    }
  end,
}
