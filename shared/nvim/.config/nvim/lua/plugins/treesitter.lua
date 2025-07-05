return {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      indent = { enable = true },
      highlight = {
        enable = true,
        -- disable for large files
        disable = function(lang, buf)
          local max_filesize = 100 * 1024   -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,

        additional_vim_regex_highlighting = false, -- Check if true is needed
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = ",i",
          node_incremental = "+",
          scope_incremental = "grc",
          node_decremental = "_",
        },
      },
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobjects, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = { query = "@function.outer", desc = "around a function" },
            ["if"] = { query = "@function.inner", desc = "inner part of a function" },
            ["ac"] = { query = "@class.outer", desc = "around a class" },
            ["ic"] = { query = "@class.inner", desc = "inner part of a class" },
            ["ai"] = { query = "@conditional.outer", desc = "around an if statement" },
            ["ii"] = { query = "@conditional.inner", desc = "inner part of an if statement" },
            ["al"] = { query = "@loop.outer", desc = "around a loop" },
            ["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
            ["ap"] = { query = "@parameter.outer", desc = "around parameter" },
            ["ip"] = { query = "@parameter.inner", desc = "inside a parameter" },
          },
          -- You can choose the select mode (default is charwise 'v')
          selection_modes = {
            ['@parameter.outer'] = 'v',                   -- charwise
            ['@parameter.inner'] = 'v',                   -- charwise
            ["@function.outer"] = "V",                    -- linewise
            ["@conditional.outer"] = "V",                 -- linewise
            ["@loop.outer"] = "V",                        -- linewise
            ['@class.outer'] = '<c-v>',                   -- blockwise
          },
        },
      move = {
        enable = true,
        set_jumps = true,                 -- whether to set jumps in the jumplist
        goto_previous_start = {
          ["gpf"] = { query = "@function.outer", desc = "Previous function" },
          ["gpl"] = { query = "@loop.outer", desc = "Previous loop" },
          ["gpi"] = { query = "@conditional.outer", desc = "Previous if" },
          ["gpc"] = { query = "@class.outer", desc = "Previous class" },
          ["gpp"] = { query = "@parameter.inner", desc = "Previous parameter" },
        },
        goto_next_start = {
          ["gnf"] = { query = "@function.outer", desc = "Next function" },
          ["gnl"] = { query = "@loop.outer", desc = "Previous loop" },
          ["gni"] = { query = "@conditional.outer", desc = "Previous if" },
          ["gnc"] = { query = "@class.outer", desc = "Next class" },
          ["gnp"] = { query = "@parameter.inner", desc = "Next parameter" },
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>u"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>U"] = "@parameter.inner",
        },
      },
      },
    })
  end,
}
