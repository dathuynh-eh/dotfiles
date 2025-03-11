return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'fang2hou/blink-copilot',
      'L3MON4D3/LuaSnip',
      'giuxtaposition/blink-cmp-copilot',
      'Kaiser-Yang/blink-cmp-avante',
    },
    version = '*',
    -- enabled = false,
    ---@module 'blink.cmp'
    ---@param opts blink.cmp.Config
    opts = function(_, opts)
      opts.enabled = function()
        local buftype = vim.bo.buftype
        local filetype = vim.bo.filetype

        local unsuported_filetypes = {
          -- 'AvanteInput',
          'copilot-chat',
        }

        local unsuported_buftypes = {
          'prompt',
        }

        return not vim.tbl_contains(unsuported_filetypes, filetype) and not vim.tbl_contains(unsuported_buftypes, buftype)
      end

      opts.completion = {
        menu = {
          draw = {
            columns = {
              { 'kind_icon', 'label' },
              {
                'label_description',
                'kind',
                gap = 1,
              },
            },
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local cmp_kinds = {
                    -- Text = '  ',
                    -- Method = '  ',
                    -- Function = '  ',
                    -- Constructor = '  ',
                    -- Field = '  ',
                    -- Variable = '  ',
                    -- Class = '  ',
                    -- Interface = '  ',
                    -- Module = '  ',
                    -- Property = '  ',
                    -- Unit = '  ',
                    -- Value = '  ',
                    -- Enum = '  ',
                    -- Keyword = '  ',
                    -- Snippet = '  ',
                    -- Color = '  ',
                    -- File = '  ',
                    -- Reference = '  ',
                    -- Folder = '  ',
                    -- EnumMember = '  ',
                    -- Constant = '  ',
                    -- Struct = '  ',
                    -- Event = '  ',
                    -- Operator = '  ',
                    -- TypeParameter = '  ',
                    -- Copilot = '  ',

                    Copilot = '  ',
                    Text = '󰉿  ',
                    Method = '󰊕  ',
                    Function = '󰊕  ',
                    Constructor = '󰒓  ',
                    Field = '󰜢  ',
                    Variable = '󰆦  ',
                    Property = '󰖷  ',
                    Module = '󰅩  ',
                    Class = '  ',
                    Interface = '  ',
                    Struct = '  ',
                    Unit = '󰪚  ',
                    Value = '󰦨  ',
                    Enum = '󰦨  ',
                    EnumMember = '󰦨  ',
                    Keyword = '󰻾  ',
                    Constant = '󰏿  ',
                    Snippet = '󱄽  ',
                    Color = '󰏘  ',
                    File = '󰈔  ',
                    Reference = '󰬲  ',
                    Folder = '󰉋  ',
                    Event = '󱐋  ',
                    Operator = '󰪚  ',
                    TypeParameter = '󰬛  ',
                    AvanteCmd = '',
                    AvanteMention = '',
                  }

                  return cmp_kinds[ctx.kind]
                end,
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
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      }

      ---@type blink.cmp.SourceConfig
      opts.sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot', 'avante' },

        providers = {

          copilot = {
            name = 'Copilot',
            module = 'blink-cmp-copilot',
            score_offset = 4,
            async = true,
            max_items = 2,
          },

          avante = {
            module = 'blink-cmp-avante',
            name = 'Avante',
          },
        },
      }

      opts.cmdline = { completion = { ghost_text = { enabled = true } } }

      opts.snippets = { preset = 'luasnip' }

      opts.fuzzy = { implementation = 'prefer_rust_with_warning' }

      return opts
    end,
    opts_extend = { 'sources.default' },
  },
}
