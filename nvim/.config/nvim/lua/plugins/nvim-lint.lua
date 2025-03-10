return {
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        javascriptreact = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
      },
      events = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
    },
    config = function(_, opts)
      local lint = require 'lint'

      lint.linters_by_ft = opts.linters_by_ft

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })

      --     vim.keymap.set("n", "<leader>ll", function()
      --       lint.try_lint()
      --     end, { desc = "Trigger linting for current file" })
      --
    end,
  },
}
