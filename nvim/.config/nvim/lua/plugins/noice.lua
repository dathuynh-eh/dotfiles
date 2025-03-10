return {
  'folke/noice.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  opts = {
    routes = {
      {
        filter = {
          event = 'lsp',
          kind = 'progress',
          cond = function(message)
            local client = vim.tbl_get(message.opts, 'progress', 'client')

            local function contains(table, item)
              for _, value in ipairs(table) do
                if value == item then
                  return true
                end
              end
              return false
            end

            return contains({ 'lua_ls', 'ts_ls' }, client)
          end,
        },
        opts = { skip = true },
      },
    },
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    -- you can enable a preset for easier configuration
    -- presets = {
    --   bottom_search = true, -- use a classic bottom cmdline for search
    --   command_palette = true, -- position the cmdline and popupmenu together
    --   long_message_to_split = true, -- long messages will be sent to a split
    -- },
  },
}
