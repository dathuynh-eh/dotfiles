return {
  {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    ---@module 'dracula'
    ---@type DraculaConfig
    config = function()
      local dracula = require("dracula")
      dracula.setup({
        transparent_bg = true,   -- default false
      })
      -- load the colorscheme here
      vim.cmd([[colorscheme dracula]])
    end,
  },
}
