return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy',
  priority = 1000,
  config = function()
    require('tiny-inline-diagnostic').setup {
      -- preset = 'minimal',
      hi = {
        background = 'none',
      },
    }

    vim.diagnostic.config { virtual_text = false }
  end,
}
