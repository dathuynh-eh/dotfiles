return {
  {
    'echasnovski/mini.pairs',
    version = '*',
    -- No need to copy this inside `setup()`. Will be used automatically.
    opts = {
      -- In which modes mappings from this `config` should be created
      modes = { insert = true, command = false, terminal = false },

      -- Global mappings. Each right hand side should be a pair information, a
      -- table with at least these fields (see more in |MiniPairs.map|):
      -- - <action> - one of 'open', 'close', 'closeopen'.
      -- - <pair> - two character string for pair to be used.
      -- By default pair is not inserted after `\`, quotes are not recognized by
      -- `<CR>`, `'` does not insert pair after a letter.
      -- Only parts of tables can be tweaked (others will use these defaults).
      mappings = {
        ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
        ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
        ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },

        [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
        [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
        ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

        ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
        ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
        ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
      },
    },
    config = function(_, opts) require('mini.pairs').setup(opts) end,
  },
  {
    'echasnovski/mini.files',
    version = '*',
    config = function()
      local mini_files = require 'mini.files'
      mini_files.setup()
      vim.keymap.set('n', '<leader>ee', '<cmd>lua MiniFiles.open()<CR>', { desc = 'Toggle mini file explorer' }) -- toggle file explorer
      vim.keymap.set('n', '<leader>ef', function()
        mini_files.open(vim.api.nvim_buf_get_name(0), false)
        mini_files.reveal_cwd()
      end, { desc = 'Toggle into currently opened file' })
    end,
  },
  { 'numToStr/Comment.nvim' },
  -- {
  --   'echasnovski/mini.comment',
  --   version = false,
  --   dependencies = {
  --     'JoosepAlviste/nvim-ts-context-commentstring',
  --   },
  --   config = function()
  --     -- disable the autocommand from ts-context-commentstring
  --     require('ts_context_commentstring').setup {
  --       enable_autocmd = false,
  --     }
  --
  --     require('mini.comment').setup {
  --       -- tsx, jsx, html , svelte comment support
  --       options = {
  --         custom_commentstring = function()
  --           return require('ts_context_commentstring.internal').calculate_commentstring { key = 'commentstring' }
  --             or vim.bo.commentstring
  --         end,
  --       },
  --     }
  --   end,
  -- },
}
