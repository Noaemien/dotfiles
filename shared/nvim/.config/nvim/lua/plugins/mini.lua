return {
  {
    'echasnovski/mini.nvim',
    config = function()
      local statusline = require 'mini.statusline'
      require('mini.surround').setup()
      require('mini.icons').setup()
      statusline.setup { use_icons = true }
    end
  }
}
