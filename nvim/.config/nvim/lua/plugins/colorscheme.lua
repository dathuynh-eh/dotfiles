return {
  {
    'Mofiqul/dracula.nvim',
    priority = 1000,
    ---@module 'dracula'
    ---@type DraculaConfig
    opts = {
      transparent_bg = true,
      colors = {
        bg = '#282A36',
        fg = '#F8F8F2',
        selection = '#44475A',
        comment = '#6272A4',
        red = '#FF5555',
        orange = '#FFB86C',
        yellow = '#F1FA8C',
        green = '#50fa7b',
        purple = '#BD93F9',
        cyan = '#8BE9FD',
        pink = '#FF79C6',
        bright_red = '#FF6E6E',
        bright_green = '#69FF94',
        bright_yellow = '#FFFFA5',
        bright_blue = '#D6ACFF',
        bright_magenta = '#FF92DF',
        bright_cyan = '#A4FFFF',
        bright_white = '#FFFFFF',
        menu = '#21222C',
        visual = '#3E4452',
        gutter_fg = '#4B5263',
        nontext = '#3B4048',
        white = '#ABB2BF',
        black = '#191A21',
      },
      -- &BG        '#282A36'
      -- &FG        '#F8F8F2'
      -- &SELECTION '#44475A'
      -- &COMMENT   '#6272A4'
      -- &CYAN      '#8BE9FD'
      -- &GREEN     '#50FA7B'
      -- &ORANGE    '#FFB86C'
      -- &PINK      '#FF79C6'
      -- &PURPLE    '#BD93F9'
      -- &RED       '#FF5555'
      -- &YELLOW    '#F1FA8C'
      -- &COLOR0        '#21222C'
      -- &COLOR1        '#FF5555'
      -- &COLOR2        '#50FA7B'
      -- &COLOR3        '#F1FA8C'
      -- &COLOR4        '#BD93F9'
      -- &COLOR5        '#FF79C6'
      -- &COLOR6        '#8BE9FD'
      -- &COLOR7        '#F8F8F2'
      -- &COLOR8        '#6272A4'
      -- &COLOR9        '#FF6E6E'
      -- &COLOR10       '#69FF94'
      -- &COLOR11       '#FFFFA5'
      -- &COLOR12       '#D6ACFF'
      -- &COLOR13       '#FF92DF'
      -- &COLOR14       '#A4FFFF'
      -- &COLOR15       '#FFFFFF
      overrides = function(c)
        return {
          BlinkCmpGhostText = { fg = c.visual, bg = 'none' },
          TelescopeNormal = { bg = 'none' },
          TelescopeBorder = { bg = 'none' },
          TelescopePromptTitle = { bg = 'none' },
          TelescopePromptBorder = { bg = 'none' },
          TelescopePreviewTitle = { bg = 'none' },
          TelescopeResultsTitle = { bg = 'none' },
        }
      end,
    },
    init = function()
      -- load the colorscheme here
      vim.cmd [[colorscheme dracula]]
    end,
  },
}
