local M = {}

vim.diagnostic.config {
  virtual_text = false
}

local function toggle_virtual_text()
  vim.diagnostic.config {
    virtual_text = not vim.diagnostic.config().virtual_text
  }
end

function M.on_attach(client, bufnr)
  vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })
  vim.api.nvim_create_user_command("Format", vim.lsp.buf.format, {})
  client.server_capabilities.semanticTokensProvider = nil -- FIXME: Figure out why this fails in OCaml Project

  local opts = { buffer = bufnr, silent = true }

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<C-K>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<Leader>rr', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<Leader>rf', vim.lsp.buf.format, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', 'gh', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<leader>s', require('nvim-navbuddy').open)
  vim.keymap.set('n', '<leader>ovt', toggle_virtual_text)

  -- TODO: map function to gd that first tries to goto_definition
  -------- and uses find_references else.

  -- if client.server_capabilities.documentHighlightProvider and client.name ~= 'kotlin_language_server' then
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup('LspDocumentHighlight', { clear = true })
    vim.api.nvim_clear_autocmds { buffer = bufnr, group = 'LspDocumentHighlight' }
    vim.api.nvim_create_autocmd('CursorHold', {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = 'LspDocumentHighlight',
      desc = 'Document Highlight',
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = 'LspDocumentHighlight',
      desc = 'Clear All the References',
    })

    -- local group = vim.api.nvim_create_augroup("LSPDocumentHighlight", {})
    -- vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    --   buffer = bufnr,
    --   group = group,
    --   callback = vim.lsp.buf.document_highlight,
    -- })
    -- vim.api.nvim_create_autocmd({ "CursorMoved" }, {
    --   buffer = bufnr,
    --   group = group,
    --   callback = vim.lsp.buf.clear_references,
    -- })
  end
end

return M
