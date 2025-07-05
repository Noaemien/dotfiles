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

vim.lsp.enable({ 'lua_ls', 'pyright', 'ruff', 'intelephense' }) --

vim.cmd("set completeopt+=noselect")

vim.diagnostic.config({
  virtual_lines = { current_line = true },
  virtual_text = true,
  update_in_insert = true,
})

vim.keymap.set({ 'v', 'n' }, '<leader>dn',
  vim.diagnostic.goto_next,
  { desc = "Jump to [N]ext [D]iagnostic" })
vim.keymap.set({ 'v', 'n' }, '<leader>dp',
  vim.diagnostic.goto_prev,
  { desc = "Jump to [P]revious [D]iagnostic" })

-- I can just manually do gq to have controll on when to do it

-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('my.lsp', {}),
--   callback = function(args)
--     local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--     print(args.data.client_id)
--     -- Auto-format ("lint") on save.
--     -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
--     if not client:supports_method('textDocument/willSaveWaitUntil')
--         and client:supports_method('textDocument/formatting') then
--       vim.api.nvim_create_autocmd('BufWritePre', {
--         group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
--         buffer = args.buf,
--         callback = function()
--           vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
--         end,
--       })
--     end
--   end,
-- })
