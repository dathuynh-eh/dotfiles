return {
  {
    'binhtran432k/dracula.nvim',
    priority = 1000,
    config = function()
      ---@module 'dracula'
      ---@type DraculaConfig
      require('dracula').setup {
        transparent = true, -- default false
        on_colors = function(colors)
          colors.hint = colors.orange
          -- colors.error = '#ff0000'
        end,
        on_highlights = function(hl, c)
          hl.NeoTreeNormal = { bg = c.none }
        end,
      }

      -- load the colorscheme here
      vim.cmd [[colorscheme dracula]]
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      light_style = 'day', -- The theme is used when the background is set to light
      transparent = true, -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    },
    -- config = function()
    --   vim.cmd [[colorscheme tokyonight]]
    -- end,
  },
}
