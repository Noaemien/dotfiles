return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      -- require("telescope").setup {
      --   extensions = {
      --     fzf = {}
      --   }
      -- }
      -- require("telescope").load_extension('fzf')
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Telescope old files' })
    end
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    init = function()
      vim.keymap.set('n', '<leader>bc', ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
        { desc = 'Telescope browse current buf' })
      vim.keymap.set('n', '<leader>br', ":Telescope file_browser<CR>", { desc = 'Telescope browse' })
    end
  }
}
