return {
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
    },
    config = function()
      vim.o.foldcolumn = '0' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      -- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

      local ufo = require 'ufo'

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      ufo.setup {
        provider_selector = function()
          return { 'lsp', 'indent' }
        end,
      }

      vim.cmd [[hi Folded guifg=#4b5263 guibg=#2b303b gui=italic ctermfg=8 ctermbg=0 cterm=italic]]

      vim.keymap.set('n', 'zR', ufo.openAllFolds)
      vim.keymap.set('n', 'zM', ufo.closeAllFolds)
      vim.keymap.set('n', 'zn', ufo.goNextClosedFold)
      vim.keymap.set('n', 'zN', ufo.goPreviousClosedFold)
    end,
  },
}
