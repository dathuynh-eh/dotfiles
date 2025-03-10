local function show_list_pokemon()
  local list_pokemon = { 'bulbasaur', 'froakie' }
  local sleep = ';sleep .1'
  local script = ''
  local paste = 'paste '

  local function dipslay(name)
    return '<(echo "$' .. name .. '") '
  end

  local function pokemon_scripts(name)
    return name .. '=$(pokemon-colorscripts -n ' .. name .. ' --no-title);'
  end

  for _, value in ipairs(list_pokemon) do
    script = script .. pokemon_scripts(value)
    paste = paste .. dipslay(value)
  end

  return script .. paste .. sleep
end

return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      indent = {},
      git = {},
      statuscolumn = {},
      dashboard = {
        -- your dashboard configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        sections = {
          {
            section = 'header',
            padding = 5,
          },
          {
            pane = 2,
            section = 'terminal',
            cmd = show_list_pokemon(),
            indent = 4,
            height = 10,
          },
          { section = 'keys', gap = 1, padding = 1 },
          { pane = 2, icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
          { pane = 2, icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
          {
            pane = 2,
            icon = ' ',
            title = 'Git Status',
            section = 'terminal',
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = 'git status --short --branch --renames',
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          { section = 'startup' },
        },
      },
      notifier = {
        top_down = false,
      },
      input = {},
    },
  },
}
