return {
  {

    -- 'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    -- tag = '0.1.8',
    -- dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("telescope").setup {
        extensions = {
          fzf = {}
        }
      }
      require("telescope").load_extension('fzf')
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Telescope old files' })
      vim.keymap.set('n', '<leader>fc', builtin.git_commits, { desc = 'Telescope git commits' })
      vim.keymap.set('n', '<leader>fs', builtin.git_status, { desc = 'Telescope git status' })
    end
  },
}
