vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  },
  root_markers = { '.git' },
})

vim.lsp.enable({ 'lua_ls', 'pyright' })

vim.cmd("set completeopt+=noselect")

vim.diagnostic.config({
  virtual_lines = {current_line = true},
  virtual_text = true,
  update_in_insert = true,
})

vim.keymap.set({'v', 'n'}, '<leader>dn', vim.diagnostic.goto_next, {desc="Jump to [N]ext [D]iagnostic"})
vim.keymap.set({'v', 'n'}, '<leader>dp', vim.diagnostic.goto_prev, {desc="Jump to [P]revious [D]iagnostic"})
