local colors = require('core.config').colors
local dev_icons = require 'nvim-web-devicons'
local winbar_filetype_exclude = {
  'snacks_input',
}
vim.cmd(string.format([[highlight WinBar1 guifg=%s guibg=%s]], colors.purple, colors.bgdark))
vim.cmd(string.format([[highlight WinBar2 guifg=%s guibg=%s]], colors.bgdark, colors.purple))
vim.cmd(string.format([[highlight WinBar3 gui=bold guifg=%s guibg=%s ]], colors.fg, colors.bglighter))
vim.cmd(string.format([[highlight WinBar4 guifg=%s guibg=%s ]], colors.bglighter, 'none'))
local function get_winbar_path()
  local full_path = vim.fn.expand '%:p:h'
  return full_path:gsub(vim.fn.expand '$HOME', '~')
end
-- Function to get the number of open buffers using the :ls command
local function get_buffer_count()
  return vim.fn.len(vim.fn.getbufinfo { buflisted = 1 })
end
-- Function to update the winbar
local function update_winbar()
  local icon = ''

  if dev_icons.has_loaded() then
    icon = dev_icons.get_icon_by_filetype(vim.bo.ft, { defaut = true })
    if icon == nil then
      icon = ''
    end
  end
  local home_replaced = get_winbar_path()
  local buffer_count = get_buffer_count()
  vim.opt.winbar = '%#WinBar1#'
    .. '%#WinBar1#'
    .. ''
    .. '%#WinBar2#󰄶 '
    .. buffer_count
    .. ' '
    -- this shows the filename on the left
    .. '%#WinBar3# '
    .. icon
    .. '%#WinBar3# '
    .. vim.fn.expand '%:t'
    .. ' %m'
    .. '%#WinBar4#'
    .. ''
    -- This shows the file path on the right
    -- .. '%#WinBar1#'
    .. '%*%='
  -- .. '%#WinBar4#'
  -- .. home_replaced
  -- I don't need the hostname as I have it in lualine
  -- .. vim.fn.systemlist("hostname")[1]
end
vim.api.nvim_create_autocmd({ 'BufEnter', 'ModeChanged' }, {
  callback = update_winbar,
})
