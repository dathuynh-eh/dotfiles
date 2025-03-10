return {
  'David-Kunz/jester',
  config = function()
    local jester = require 'jester'

    jester.setup {
      path_to_jest_run = 'node_modules/.bin/jest', -- used to run tests
    }

    vim.keymap.set('n', '<leader>tf', jester.run_file, { desc = '[R]un Selected Test [F]ile' })
    vim.keymap.set('n', '<leader>tc', jester.run, { desc = '[R]un Selected Test [C]ase' })
    -- vim.keymap.set('n', '<leader>tdc', jester.debug, { desc = '[D]ebug Select Test [C]ase' })
  end,
}
