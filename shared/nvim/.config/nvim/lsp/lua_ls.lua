local blink = require("blink.cmp")

return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua', },
  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
  settings = {
    Lua = {
      diagnostics = {
        disable = { "missing-fields" },
        globals = {
          "vim",
        },
      },
      hint = {
        enable = true,
        setType = false,
        paramType = true,
        paramName = "Disable",
        semicolon = "Disable",
        arrayIndex = "Disable",
      },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "4",
          max_line_length = "60",
        }
      },
    },
  },
  capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    blink.get_lsp_capabilities(),
    {
      fileOperations = {
        didRename = true,
        willRename = true,
      },
    }
  ),
}
