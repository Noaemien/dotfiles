-- yank highligh autocmd

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = "Highligh when copying text",
  group = vim.api.nvim_create_augroup('nvim-highlight', {clear = true}),
  callback = function ()
    vim.highlight.on_yank()
  end
})

