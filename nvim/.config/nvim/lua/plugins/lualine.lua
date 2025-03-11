-- S swet lualine as statusline
local colors = {
  blue = '#80a0ff',
  cyan = '#79dac8',
  black = '#080808',
  white = '#c6c6c6',
  red = '#ff5189',
  violet = '#d183e8',
  grey = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
  },
}
return {
  'nvim-lualine/lualine.nvim',
  opts = function()
    local hide_in_width = function()
      return vim.fn.winwidth(0) > 100
    end

    local diagnostics = {
      'diagnostics',
      sections = { 'error', 'warn' },
      symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      update_in_insert = false,
      always_visible = false,
      cond = hide_in_width,
    }

    local diff = {
      'diff',
      -- colored = false,
      symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
      cond = hide_in_width,
    }

    return {
      options = {
        theme = bubbles_theme,
        component_separators = '',
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'snacks_dashboard', 'neo-tree', 'Avante', 'AvanteSelectedFiles', 'AvanteInput', 'grug-far' },
      },
      sections = {
        lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
        lualine_b = { 'filename', diagnostics },
        lualine_c = {
          '%=', --[[ add your center compoentnts here in place of this comment ]]
        },
        lualine_x = {},
        lualine_y = { diff, 'branch', 'filetype', 'progress' },
        lualine_z = {
          { 'location', separator = { right = '' }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
      tabline = {},
      extensions = {},
    }
  end,
  -- config = function()
  --   require('lualine').setup(opts)
  -- end,
  -- opts = function(_, opts)
  --   local trouble = require 'trouble'
  --   local symbols = trouble.statusline {
  --     mode = 'lsp_document_symbols',
  --     groups = {},
  --     title = false,
  --     filter = { range = true },
  --     format = '{kind_icon}{symbol.name:Normal}',
  --     -- The following line is needed to fix the background color
  --     -- Set it to the lualine section you want to use
  --     hl_group = 'lualine_c_normal',
  --   }
  --   table.insert(opts.sections.lualine_c, {
  --     symbols.get,
  --     cond = symbols.has,
  --   })
  -- end,
  -- config = function()
  --   -- Import color theme based on environment variable NVIM_THEME
  --   local env_var_nvim_theme = os.getenv 'NVIM_THEME' or 'dracula'
  --
  --   -- Define a table of themes
  --   local themes = {
  --     dracula = 'dracula',
  --   }
  --
  --   local mode = {
  --     'mode',
  --     fmt = function(str)
  --       -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
  --       return ' ' .. str
  --     end,
  --   }
  --
  --   local filename = {
  --     'filename',
  --     file_status = true, -- displays file status (readonly status, modified status)
  --     path = 0,           -- 0 = just filename, 1 = relative path, 2 = absolute path
  --   }
  --
  --   local hide_in_width = function()
  --     return vim.fn.winwidth(0) > 100
  --   end
  --
  --   local diagnostics = {
  --     'diagnostics',
  --     sources = { 'nvim_diagnostic' },
  --     sections = { 'error', 'warn' },
  --     symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
  --     colored = false,
  --     update_in_insert = false,
  --     always_visible = false,
  --     cond = hide_in_width,
  --   }
  --
  --   local diff = {
  --     'diff',
  --     colored = false,
  --     symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
  --     cond = hide_in_width,
  --   }
  --
  --   require('lualine').setup {
  --     options = {
  --       icons_enabled = true,
  --       theme = themes[env_var_nvim_theme], -- Set theme based on environment variable
  --       -- Some useful glyphs:
  --       -- https://www.nerdfonts.com/cheat-sheet
  --       --        
  --       section_separators = { left = '', right = '' },
  --       component_separators = { left = '', right = '' },
  --       disabled_filetypes = { 'alpha', 'neo-tree', 'Avante' },
  --       always_divide_middle = true,
  --     },
  --     sections = {
  --       lualine_a = { mode },
  --       lualine_b = { 'branch' },
  --       lualine_c = { filename },
  --       lualine_x = { diagnostics, diff, { 'encoding', cond = hide_in_width }, { 'filetype', cond = hide_in_width } },
  --       lualine_y = { 'location' },
  --       lualine_z = { 'progress' },
  --     },
  --     inactive_sections = {
  --       lualine_a = {},
  --       lualine_b = {},
  --       lualine_c = { { 'filename', path = 1 } },
  --       lualine_x = { { 'location', padding = 0 } },
  --       lualine_y = {},
  --       lualine_z = {},
  --     },
  --     tabline = {},
  --     extensions = { 'fugitive' },
  --   }
  -- end,
}
