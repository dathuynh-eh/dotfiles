return {
  'nvim-neotest/neotest',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-jest',
  },
  config = function()
    local neotest = require 'neotest'
    -- local neo_jest = require 'neotest-jest'
    -- local keymaps = opts.keymaps or {}

    neotest.setup {
      adapters = {
        require 'neotest-jest',
      },
      discovery = {
        enable = false,
      },
    }

    local default_des = '[T]est '

    vim.keymap.set('n', '<leader>tr', function() neotest.run.run() end, { desc = default_des .. '[R]un nearest test' })
    vim.keymap.set(
      'n',
      '<leader>tf',
      function() neotest.run.run(vim.fn.expand '%') end,
      { desc = default_des .. 'Run current [F]ile' }
    )
    vim.keymap.set(
      'n',
      '<leader>ta',
      function() neotest.run.run { suite = true } end,
      { desc = default_des .. 'Run [A]ll' }
    )
    vim.keymap.set('n', '<leader>ts', function() neotest.run.stop() end, { desc = default_des .. '[S]top test' })
    vim.keymap.set(
      'n',
      '<leader>to',
      function() neotest.output.open() end,
      { desc = default_des .. 'Show test [O]utput' }
    )
    vim.keymap.set(
      'n',
      '<leader>tp',
      function() neotest.output_panel.toggle() end,
      { desc = default_des .. 'Toggle output [P]ane' }
    )
    vim.keymap.set(
      'n',
      '<leader>ti',
      function() neotest.summary.toggle() end,
      { desc = default_des .. 'Toggle [I]nfo summary' }
    )
  end,
}
