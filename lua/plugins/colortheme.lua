return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    -- For dark theme, the default is already dark.
    -- You can also explicitly set it:
    -- vim.g.gruvbox_palette = "dark"
    vim.cmd.colorscheme("gruvbox")
  end,
}
