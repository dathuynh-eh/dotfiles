local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local make_entry = require 'telescope.make_entry'
local conf = require('telescope.config').values

local M = {}

local live_multigrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.loop.cwd() -- Current working directory

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == '' then
        return nil
      end

      -- Split the prompt into search pattern and file glob
      local pieces = vim.split(prompt, '%s+', { trimempty = true })
      local search_pattern = pieces[1] or '' -- First part: search pattern
      local file_glob = pieces[2] or '*'     -- Second part: file glob, defaults to '*'

      -- Build the ripgrep command
      local args = { 'rg' }
      if search_pattern ~= '' then
        table.insert(args, '-e')
        table.insert(args, search_pattern)
      end
      if file_glob ~= '' then
        table.insert(args, '-g')
        table.insert(args, file_glob)
      end

      -- Add common ripgrep options
      return vim.tbl_flatten {
        args,
        { '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' },
      }
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }

  pickers
      .new(opts, {
        debounce = 100,
        prompt_title = 'Search Pattern [space] File Glob (e.g., TODO *.lua)',
        finder = finder,
        previewer = conf.grep_previewer(opts),
        sorter = require('telescope.sorters').empty(),
      })
      :find()
end

M.setup = function()
  -- Map the function to <leader>fg with a descriptive label
  vim.keymap.set('n', '<leader>fg', live_multigrep, { desc = 'Search with pattern and file glob' })
end

return M
