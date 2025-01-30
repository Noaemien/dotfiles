return {
  {
    "williamboman/mason.nvim",

    config = function()
      require("mason").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      -- {
      --   "gpanders/editorconfig.nvim",
      -- },
      {
        "hrsh7th/nvim-cmp",
        dependencies = {
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-cmdline",
          -- "L3MON4D3/LuaSnip",
          -- "saadparwaiz1/cmp_luasnip",
        },
        config = function()
          local cmp = require("cmp")
          cmp.setup({
            -- snippet = {
            --   expand = function(args)
            --     require("luasnip").lsp_expand(args.body)
            --   end,
            -- },
            mapping = cmp.mapping.preset.insert({
              ["<C-b>"] = cmp.mapping.scroll_docs(-4),
              ["<C-f>"] = cmp.mapping.scroll_docs(4),
              ["<C-Space>"] = cmp.mapping.complete(),
              ["<C-e>"] = cmp.mapping.abort(),
              ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
              {
                name = "nvim_lsp",
                entry_filter = function(entry, ctx)
                  return require("cmp").lsp.CompletionItemKind.Text ~= entry:get_kind()
                end
              },
              -- { name = "luasnip" },
              -- { name = "buffer" },
              { name = "path" },
            }),
          })
        end,
      },
    },
    config = function()
      require("lspconfig").lua_ls.setup {}
      require("lspconfig").pyright.setup {}
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      require("lspconfig").html.setup {
        capabilities = capabilities,
        filetypes = { "html", "blade" },
        init_options = {
          configurationSection = { "html", "css", "javascript" },
          embeddedLanguages = {
            css = true,
            javascript = true
          },
          provideFormatter = true
        }
      };
      require("lspconfig").texlab.setup {}
      require("lspconfig").zls.setup {}
      require("lspconfig").marksman.setup {}
      require("lspconfig").clangd.setup {}
      require("lspconfig").bashls.setup {}
      require("lspconfig").denols.setup {}
      require("lspconfig").cssls.setup {}
      require("lspconfig").jsonls.setup {}
      require("lspconfig").phpactor.setup {}


      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local c = vim.lsp.get_client_by_id(args.data.client_id)
          if not c then return end
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
            end,
          })
        end,
      })

      vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
      vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
      vim.keymap.set('n', 'grr', vim.lsp.buf.references)
    end,
  }
}
