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

    local signs = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.HINT] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
    }
    vim.diagnostic.config {
      signs = { text = signs },
      virtual_text = false,
    }
  end,
}
