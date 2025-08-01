vim.o.termguicolors = true
vim.wo.number = true -- Make line numbers default
vim.o.relativenumber = true
vim.o.mouse = 'a' -- Enable mouse mode
vim.o.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim.
vim.o.breakindent = true -- Enable break indent
vim.o.numberwidth = 2 -- set number column width to 2 {default 4}
vim.o.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.o.tabstop = 2 -- insert n spaces for a tab
vim.o.softtabstop = 2 -- Number of spaces that a tab counts for while performing editing operations
vim.o.expandtab = true -- convert tabs to spaces
vim.o.autoindent = true -- copy indent from current line when starting new one
vim.o.splitbelow = true -- force all horizontal splits to go below current window
vim.o.splitright = true -- force all vertical splits to go to the right of current window
vim.o.laststatus = 3 -- hide status bar
vim.o.showmode = false -- hide mode cause already have lualine
vim.o.undofile = true -- save undo history
vim.o.hlsearch = true -- highlight search result
vim.o.termguicolors = true -- enable 24-bit RGB colors
vim.o.swapfile = false -- don't use swapfile
vim.o.fileencoding = 'utf-8' -- the encoding written to file
vim.o.scrolloff = 8
vim.o.wrap = false

-- enable undercurl for diagnostics
vim.cmd [[ let &t_Cs = "\e[4:3m]" ]]
vim.cmd [[ let &t_Ce = "\e[4:0m]" ]]

-- local colors = require('core.config').colors
--
-- vim.cmd(string.format([[highlight WinBar1 guifg=%s guibg=%s]], colors.green, colors.bg))
-- vim.cmd(string.format([[highlight WinBar2 guifg=%s guibg=%s]], colors.bg, colors.green))
-- vim.cmd(string.format([[highlight WinBar3 gui=bold guifg=%s guibg=%s ]], colors.cyan, colors.selection))
-- vim.cmd(string.format([[highlight WinBar4 guifg=%s guibg=%s ]], colors.selection, 'none'))
-- local function get_winbar_path()
--   local full_path = vim.fn.expand '%:p:h'
--   return full_path:gsub(vim.fn.expand '$HOME', '~')
-- end
-- -- Function to get the number of open buffers using the :ls command
-- local function get_buffer_count()
--   return vim.fn.len(vim.fn.getbufinfo { buflisted = 1 })
-- end
-- -- Function to update the winbar
-- local function update_winbar()
--   local home_replaced = get_winbar_path()
--   local buffer_count = get_buffer_count()
--   vim.opt.winbar = '%#WinBar1#'
--     .. '%#WinBar1#'
--     .. ''
--     .. '%#WinBar2#󰄷 '
--     .. buffer_count
--     .. ' '
--     -- this shows the filename on the left
--     .. '%#WinBar3# '
--     .. vim.fn.expand '%:t'
--     .. ' %m'
--     .. '%#WinBar4#'
--     .. ''
--     -- This shows the file path on the right
--     -- .. '%#WinBar1#'
--     .. '%*%='
--     -- .. '%#WinBar4#'
--     .. home_replaced
--   -- I don't need the hostname as I have it in lualine
--   -- .. vim.fn.systemlist("hostname")[1]
-- end
-- vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter', 'ModeChanged' }, {
--   callback = update_winbar,
-- })
