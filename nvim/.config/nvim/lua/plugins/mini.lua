return {
    {
        'echasnovski/mini.nvim',
        config = function()
            local statusline = require 'mini.statusline'
	    require('mini.icons').setup()
	    require('mini.diff').setup()
	    require('mini.git').setup()
            statusline.setup { use_icons = true }
        end
    }
}
