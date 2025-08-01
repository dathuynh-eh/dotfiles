local prefix = '<leader>gn'
local prefix_diffview = '<leader>gc'
local function toggle_diffview(cmd)
  if next(require('diffview.lib').views) == nil then
    vim.cmd(cmd)
  else
    vim.cmd 'DiffviewClose'
  end
end

return {
  {
    'NeogitOrg/neogit',
    opts = {
      signs = {
        section = { '', '' },
        item = { '', '' },
        hunk = { '', '' },
      },
      integrations = {
        diffview = true,
      },
    },
    keys = {
      { prefix .. 'n', '<cmd>Neogit<cr>', desc = 'Neogit (Root Dir)' },
      { prefix .. 'c', '<cmd>Neogit commit<cr>', desc = 'Commit' },
      { prefix .. 'p', '<cmd>Neogit pull<cr>', desc = 'Pull' },
      { prefix .. 'P', '<cmd>Neogit push<cr>', desc = 'Push' },
      { prefix .. 'f', '<cmd>Neogit fetch<cr>', desc = 'Fetch' },
    },
  },
  {
    'sindrets/diffview.nvim',
    -- stylua: ignore
    keys = {
      { "<leader>gD", function() toggle_diffview("DiffviewFileHistory") end, desc = "Diff Repo" },
      { "<leader>gd", function() toggle_diffview("DiffviewOpen") end, desc = "Diff View" },
      { "<leader>gF", function() toggle_diffview("DiffviewFileHistory %") end, desc = "Diff Current File" },
    },
    opts = function(_, opts)
      local actions = require 'diffview.actions'

      opts.enhanced_diff_hl = true
      opts.view = {
        default = { winbar_info = true },
        file_history = { winbar_info = true },
      }
      opts.hooks = {
        diff_buf_read = function(bufnr) vim.b[bufnr].view_activated = false end,
      }

      opts.keymaps = {
        --stylua: ignore
        view = {
          { "n", prefix_diffview .. "o",  actions.conflict_choose("ours"),        { desc = "Choose the OURS version of a conflict" } },
          { "n", prefix_diffview .. "t",  actions.conflict_choose("theirs"),      { desc = "Choose the THEIRS version of a conflict" } },
          { "n", prefix_diffview .. "b",  actions.conflict_choose("base"),        { desc = "Choose the BASE version of a conflict" } },
          { "n", prefix_diffview .. "a",  actions.conflict_choose("all"),         { desc = "Choose all the versions of a conflict" } },
          { "n", prefix_diffview .. "x",  actions.conflict_choose("none"),        { desc = "Delete the conflict region" } },
          { "n", prefix_diffview .. "O",  actions.conflict_choose_all("ours"),    { desc = "Choose the OURS version of a conflict for the whole file" } },
          { "n", prefix_diffview .. "T",  actions.conflict_choose_all("theirs"),  { desc = "Choose the THEIRS version of a conflict for the whole file" } },
          { "n", prefix_diffview .. "B",  actions.conflict_choose_all("base"),    { desc = "Choose the BASE version of a conflict for the whole file" } },
          { "n", prefix_diffview .. "A",  actions.conflict_choose_all("all"),     { desc = "Choose all the versions of a conflict for the whole file" } },
          { "n", prefix_diffview .. "X",  actions.conflict_choose_all("none"),    { desc = "Delete the conflict region for the whole file" } },
        },
        --stylua: ignore
        file_panel = {
          { "n", prefix_diffview .. "O",  actions.conflict_choose_all("ours"),    { desc = "Choose the OURS version of a conflict for the whole file" } },
          { "n", prefix_diffview .. "T",  actions.conflict_choose_all("theirs"),  { desc = "Choose the THEIRS version of a conflict for the whole file" } },
          { "n", prefix_diffview .. "B",  actions.conflict_choose_all("base"),    { desc = "Choose the BASE version of a conflict for the whole file" } },
          { "n", prefix_diffview .. "A",  actions.conflict_choose_all("all"),     { desc = "Choose all the versions of a conflict for the whole file" } },
          { "n", prefix_diffview .. "X",  actions.conflict_choose_all("none"),    { desc = "Delete the conflict region for the whole file" } },
        },
      }
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'ruifm/gitlinker.nvim',
      'nvim-lua/plenary.nvim',
    },
    opts = {
      signs = {
        add = { text = ' ' },
        change = { text = ' ' },
        delete = { text = ' ' },
        topdelete = { text = ' ' },
        changedelete = { text = ' ' },
        untracked = { text = ' ' },
      },
      signs_staged = {
        add = { text = '' },
        change = { text = '' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '' },
        untracked = { text = '' },
      },
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 500,
        ignore_whitespace = false,
      },
    },
    config = function(_, opts)
      local gitsigns = require 'gitsigns'
      local gitlinker = require 'gitlinker'

      gitsigns.setup(opts)
      gitlinker.setup {
        mappings = '<leader>gy',
      }

      local function open_commit_on_github()
        local file = vim.fn.expand '%:p'
        local line = vim.fn.line '.'
        print('[DEBUG] File: ' .. file .. ', Line: ' .. line)

        -- Run git blame
        local blame_cmd = string.format(
          "git blame -L %d,%d --porcelain -- %s | grep '^commit ' | head -n1 | cut -d' ' -f2",
          line,
          line,
          file
        )
        print('[DEBUG] Blame CMD: ' .. blame_cmd)

        local sha = vim.fn.systemlist(blame_cmd)[1]
        print('[DEBUG] Commit SHA: ' .. tostring(sha))

        if not sha or #sha == 0 then
          vim.notify('Commit SHA not found', vim.log.levels.WARN)
          return
        end

        local url_cmd = string.format('gh browse --no-browser --commit %s', sha)
        print('[DEBUG] URL CMD: ' .. url_cmd)

        local url = vim.fn.systemlist(url_cmd)[1]
        print('[DEBUG] Commit URL: ' .. tostring(url))

        if url and #url > 0 then
          local open_cmd = vim.fn.has 'mac' == 1 and 'open' or 'xdg-open'
          print('[DEBUG] Running: ' .. open_cmd .. ' ' .. url)
          vim.fn.jobstart({ open_cmd, url }, { detach = true })
        else
          vim.notify('Failed to generate GitHub URL for commit', vim.log.levels.ERROR)
        end
      end

      vim.api.nvim_create_user_command('OpenCommitOnGithub', open_commit_on_github, {})
      vim.keymap.set('n', '<leader>gc', ':OpenCommitOnGithub<CR>', { desc = 'Open commit on GitHub' })
      vim.keymap.set('n', '<leader>gb', gitsigns.toggle_current_line_blame, { desc = 'Toggle Git Blame' })
    end,
  },
}
