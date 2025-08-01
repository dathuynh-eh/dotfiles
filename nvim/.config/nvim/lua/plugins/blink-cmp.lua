return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'xzbdmw/colorful-menu.nvim',
    },
    version = '1.*',
    -- enabled = false,
    ---@module 'blink.cmp'
    ---@param opts blink.cmp.Config
    opts = function(_, opts)
      opts.completion = {
        menu = {
          draw = {
            columns = {
              { 'kind_icon', 'label' },
              { 'label_description', 'kind', gap = 1 },
            },
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local cmp_kinds = {
                    Text = '  ',
                    Method = '  ',
                    Function = '  ',
                    Constructor = '  ',
                    Field = '  ',
                    Variable = '  ',
                    Class = '  ',
                    Interface = '  ',
                    Module = '  ',
                    Property = '  ',
                    Unit = '  ',
                    Value = '  ',
                    Enum = '  ',
                    Keyword = '  ',
                    Snippet = '  ',
                    Color = '  ',
                    File = '  ',
                    Reference = '  ',
                    Folder = '  ',
                    EnumMember = '  ',
                    Constant = '  ',
                    Struct = '  ',
                    Event = '  ',
                    Operator = '  ',
                    TypeParameter = '  ',
                    Copilot = '  ',

                    -- Copilot = '  ',
                    -- Text = '󰉿  ',
                    -- Method = '󰊕  ',
                    -- Function = '󰊕  ',
                    -- Constructor = '󰒓  ',
                    -- Field = '󰜢  ',
                    -- Variable = '󰆦  ',
                    -- Property = '󰖷  ',
                    -- Module = '󰅩  ',
                    -- Class = '  ',
                    -- Interface = '  ',
                    -- Struct = '  ',
                    -- Unit = '󰪚  ',
                    -- Value = '󰦨  ',
                    -- Enum = '󰦨  ',
                    -- EnumMember = '󰦨  ',
                    -- Keyword = '󰻾  ',
                    -- Constant = '󰏿  ',
                    -- Snippet = '󱄽  ',
                    -- Color = '󰏘  ',
                    -- File = '󰈔  ',
                    -- Reference = '󰬲  ',
                    -- Folder = '󰉋  ',
                    -- Event = '󱐋  ',
                    -- Operator = '󰪚  ',
                    -- TypeParameter = '󰬛  ',
                    -- AvanteCmd = '',
                    -- AvanteMention = '',
                  }

                  return cmp_kinds[ctx.kind]
                end,
              },
              label = {
                text = function(ctx) return require('colorful-menu').blink_components_text(ctx) end,
                highlight = function(ctx) return require('colorful-menu').blink_components_highlight(ctx) end,
              },
            },
          },
        },

        list = { selection = { preselect = true, auto_insert = false } },

        documentation = { auto_show = true, auto_show_delay_ms = 200 },

        ghost_text = { enabled = true },
      }

      opts.keymap = {
        ['<cr>'] = { 'select_and_accept', 'fallback' },
        ['<C-c>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        ['<Tab>'] = { 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      }

      opts.appearance = {
        -- use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      }

      opts.signature = { enabled = true }

      --- @class blink.cmp.Source
      opts.sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        -- default = { 'snippets' },

        --- @class blink.cmp.SourceProviderConfig
        providers = {

          lsp = {
            max_items = 7, -- Maximum number of items to display in the menu
          },
        },
      }

      opts.cmdline = { completion = { ghost_text = { enabled = true } } }

      -- opts.snippets = { preset = 'luasnip' }

      opts.fuzzy = { implementation = 'prefer_rust_with_warning' }

      return opts
    end,
    opts_extend = { 'sources.default' },
  },
}
