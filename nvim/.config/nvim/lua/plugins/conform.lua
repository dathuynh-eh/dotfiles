return {
  'stevearc/conform.nvim',
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      json = { 'prettierd' },
    },
    ---@type  fun(brfnr:integer): conform.FormatOpts|nil
    format_on_save = function(brfnr)
      if vim.g.disable_autoformat or vim.b[brfnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500 }
    end,
  },

  init = function()
    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
      -- print 'Disable auto format on save'
    end, {
      desc = 'Disable auto format on save',
      bang = true,
    })

    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
      -- print 'Re-enable auto format on save'
    end, {
      desc = 'Re-enable auto format on save',
    })

    vim.keymap.set({ 'n', 'v' }, '<leader>k<leader>f', function()
      require('conform').format()
    end, { desc = '[F]ormat Code' })
  end,
}
