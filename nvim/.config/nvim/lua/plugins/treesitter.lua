return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  opts = {
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },

    ensure_installed = {
      'c',
      'lua',
      'javascript',
      'typescript',
      'vimdoc',
      'vim',
      'regex',
      'toml',
      'json',
      'gitignore',
      'yaml',
      'query',
      'bash',
      'tsx',
      'css',
      'html',
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)

    vim.treesitter.language.register('objc', 'objective-cpp')
    vim.treesitter.language.register('objc', 'objective-c')
  end,
}
