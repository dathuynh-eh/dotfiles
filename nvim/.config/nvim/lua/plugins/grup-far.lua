return {
  {
    'MagicDuck/grug-far.nvim',
    config = function()
      local grugFar = require 'grug-far'

      grugFar.setup {
        -- options, see Configuration section below
        -- there are no required options atm
        -- engine = 'ripgrep' is default, but 'astgrep' can be specified
      }
      --
      -- vim.keymap.set('n', 'fw', function()
      --   grugFar.open {
      --     prefills = {
      --       paths = vim.uv.cwd(),
      --     },
      --   }
      -- end, { desc = 'grug-far: Search on current file' })

      local gfInstance
      vim.keymap.set('n', 'ff', function()
        if not gfInstance then
          gfInstance = grugFar.open {
            transient = true,
            prefills = {
              paths = vim.fn.expand '%',
            },
          }
        else
          grugFar.close_instance(gfInstance)
          gfInstance = nil
        end
      end, { desc = 'grug-far: Search on current file' })
    end,
  },
}
