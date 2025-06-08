return {
    {
        'echasnovski/mini.nvim',
        config = function()
            local statusline = require 'mini.statusline'
      require('mini.ai').setup({ n_lines = 500})
      require('mini.surround').setup()
	    require('mini.icons').setup()
	    require('mini.diff').setup()
	    require('mini.git').setup()
            statusline.setup { use_icons = true }
        end
    }
}
