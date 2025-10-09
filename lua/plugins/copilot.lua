return {
  "github/copilot.vim",
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_filetypes = {
      ['*'] = false, -- Отключить Copilot для всех типов файлов
    }
    vim.api.nvim_set_keymap("i", "<C-J>", "copilot#accept_word()", { silent = true, expr = true })
  end,
}
