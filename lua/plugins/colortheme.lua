return { 
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  config = function()
    require("catppuccin").setup({
      flavour = "latte",
      background = { light = "latte", dark = "mocha" },
      default_integrations = true,
    })
    vim.cmd.colorscheme("catppuccin")  
  end,
}
