return {
  'windwp/nvim-autopairs',
  enabled = false,
  event = "InsertEnter",
  config = function()
    local autopairs = require('nvim-autopairs')
    autopairs.setup({
      check_ts = true, -- Check treesitter
      ts_config = {
        lua = { 'string' },
        javascript = { 'template_string' },
        java = false,
      }
    })

    -- Integration with nvim-cmp
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
  end,
}
