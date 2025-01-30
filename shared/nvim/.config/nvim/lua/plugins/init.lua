return {
  "folke/neodev.nvim",
  "folke/which-key.nvim",
  { "nvim-tree/nvim-web-devicons", opts = {} },
  { "folke/neoconf.nvim",          cmd = "Neoconf" },
  {
    "m4xshen/autoclose.nvim",
    init = function()
      require("autoclose").setup()
    end
  },
}
