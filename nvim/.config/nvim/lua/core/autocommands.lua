-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
-- https://github.com/pr7prashant/neovim/blob/9ee542bb95492a6c2fe2eb5ba0874a4b00f7aedd/lua/user/autocommands.lua#L48
-- https://stackoverflow.com/questions/62100785/auto-reload-file-and-in-neovim-and-auto-reload-nerbtree
vim.o.autoread = true
vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'CursorHoldI', 'FocusGained' }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { '*' },
})

-- show message when file is changed externally
vim.api.nvim_create_autocmd({ 'FileChangedShellPost' }, {
  command = 'echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None',
  pattern = { '*' },
})

-- Ruby
-- Set Fastlane to ruby filetype
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  command = 'set filetype=ruby',
  pattern = { 'Fastfile', 'Appfile', 'Matchfile', 'Gymfile' },
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
