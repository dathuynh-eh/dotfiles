-- prefil edit window with common scenarios to avoid repeating query and submit immediately
local prefill_edit_window = function(request)
  require('avante.api').edit()
  local code_bufnr = vim.api.nvim_get_current_buf()
  local code_winid = vim.api.nvim_get_current_win()
  if code_bufnr == nil or code_winid == nil then
    return
  end
  vim.api.nvim_buf_set_lines(code_bufnr, 0, -1, false, { request })
  -- Optionally set the cursor position to the end of the input
  vim.api.nvim_win_set_cursor(code_winid, { 1, #request + 1 })
  -- Simulate Ctrl+S keypress to submit
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-s>', true, true, true), 'v', true)
end

-- NOTE: most templates are inspired from ChatGPT.nvim -> chatgpt-actions.json
local avante_grammar_correction = 'Correct the text to standard English, but keep any code blocks inside intact.'
local avante_keywords = 'Extract the main keywords from the following text'
local avante_code_readability_analysis = [[
  You must identify any readability issues in the code snippet.
  Some readability issues to consider:
  - Unclear naming
  - Unclear purpose
  - Redundant or obvious comments
  - Lack of comments
  - Long or complex one liners
  - Too much nesting
  - Long variable names
  - Inconsistent naming and code style.
  - Code repetition
  You may identify additional problems. The user submits a small section of code from a larger file.
  Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
  If there's no issues with code respond with only: <OK>
]]
local avante_optimize_code = 'Optimize the following code'
local avante_summarize = 'Summarize the following text'
local avante_translate = 'Translate this into Chinese, but keep any code blocks inside intact'
local avante_explain_code = 'Explain the following code'
local avante_complete_code = 'Complete the following codes written in ' .. vim.bo.filetype
local avante_add_docstring = 'Add docstring to the following codes'
local avante_fix_bugs = 'Fix the bugs inside the following codes if any'
local avante_add_tests = 'Implement tests for the following code'

local prompts = {
  GrammarCorrection = {
    prompt = avante_grammar_correction,
    system_prompt = 'You are an expert English grammar checker',
    mapping = '<leader>cg',
    description = 'Correct text to standard English',
  },
  Keywords = {
    prompt = avante_keywords,
    system_prompt = 'You are an expert at keyword extraction',
    mapping = '<leader>ck',
    description = 'Extract main keywords from text',
  },
  ReadabilityAnalysis = {
    prompt = avante_code_readability_analysis,
    system_prompt = 'You are an expert code reviewer focused on readability',
    mapping = '<leader>cl',
    description = 'Analyze code readability',
  },
  OptimizeCode = {
    prompt = avante_optimize_code,
    system_prompt = 'You are an expert at code optimization',
    mapping = '<leader>co',
    description = 'Optimize code for performance and clarity',
  },
  Summarize = {
    prompt = avante_summarize,
    system_prompt = 'You are skilled at concise summarization',
    mapping = '<leader>cm',
    description = 'Summarize text content',
  },
  ExplainCode = {
    prompt = avante_explain_code,
    system_prompt = 'You are an excellent code educator',
    mapping = '<leader>cx',
    description = 'Explain code functionality',
  },
  CompleteCode = {
    prompt = avante_complete_code,
    system_prompt = 'You are an expert programmer',
    mapping = '<leader>cc',
    description = 'Complete code snippets',
  },
  AddDocstring = {
    prompt = avante_add_docstring,
    system_prompt = 'You are an expert at code documentation',
    mapping = '<leader>cd',
    description = 'Add docstrings to code',
  },
  FixBugs = {
    prompt = avante_fix_bugs,
    system_prompt = 'You are an expert debugging assistant',
    mapping = '<leader>cb',
    description = 'Fix bugs in code',
  },
  AddTests = {
    prompt = avante_add_tests,
    system_prompt = 'You are an expert in test-driven development',
    mapping = '<leader>cu',
    description = 'Generate tests for code',
  },
}

return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    enabled = true,
    dependencies = {
      { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = { file_types = { 'markdown', 'copilot-chat' } },
        ft = { 'markdown', 'copilot-chat' },
      },
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      -- Automatically enter insert mode when opening chat
      auto_insert_mode = true,
      -- Define header for user's questions in chat
      question_header = '  Dat Huynh ',
      -- Define header for AI responses in chat
      answer_header = '  Copilot ',
      -- Specify which AI model to use (Claude 3.7 Sonnet)
      -- model = 'claude-3.7-sonnet',
      model = 'claude-3.5-sonnet',
      prompts = prompts,
      -- Set chat window width to 40% of editor
      window = {
        width = 0.4,
      },
      mappings = {
        complete = {
          detail = 'Use @<Tab> or /<Tab> for options.',
          insert = '<Tab>',
        },
        -- Close the chat
        close = {
          normal = 'q', -- Press q in normal mode to close
          insert = '<C-c>', -- Press Ctrl+c in insert mode to close
        },
        -- Reset the chat buffer
        reset = {
          normal = '<C-x>', -- Press Ctrl+x in normal mode to reset
          insert = '<C-x>', -- Press Ctrl+x in insert mode to reset
        },
        -- Submit the prompt to Copilot
        submit_prompt = {
          normal = '<CR>', -- Press Enter in normal mode to submit
        },
        -- Accept the diff
        accept_diff = {
          normal = '<C-y>', -- Press Ctrl+y in normal mode to accept diff
          insert = '<C-y>', -- Press Ctrl+y in insert mode to accept diff
        },
        -- Show help
        show_help = {
          normal = 'g?', -- Press g? in normal mode to show help
        },
      },
    },

    --if you want to lazy load on them
    keys = {
      -- Open Copilot Chat interface in normal mode
      { '<leader>cn', ':CopilotChat<CR>', mode = { 'n', 'v' }, desc = 'Copilot Chat' },
    },
  },
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = '*',
    -- enabled = false,
    build = 'make',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = { file_types = { 'markdown', 'Avante' } },
        ft = { 'markdown', 'Avante' },
      },
    },
    opts = {
      provider = 'copilot',
      copilot = {
        -- model = 'claude-3.7-sonnet',
        model = 'claude-3.5-sonnet',
      },
    },
    keys = function()
      local function create_ask_keymap(key, question, description)
        return {
          key,
          function()
            require('avante.api').ask { question = question }
          end,
          desc = description,
          mode = { 'n', 'v' },
        }
      end

      local function create_prefill_keymap(key, question, description)
        return {
          key,
          function()
            prefill_edit_window(question)
          end,
          desc = description,
          mode = { 'v' },
        }
      end

      local ask_keymaps = {
        { '<leader>ag', avante_grammar_correction, 'Grammar Correction(ask)' },
        { '<leader>ak', avante_keywords, 'Keywords(ask)' },
        { '<leader>al', avante_code_readability_analysis, 'Code Readability Analysis(ask)' },
        { '<leader>ao', avante_optimize_code, 'Optimize Code(ask)' },
        { '<leader>am', avante_summarize, 'Summarize text(ask)' },
        { '<leader>an', avante_translate, 'Translate text(ask)' },
        { '<leader>ax', avante_explain_code, 'Explain Code(ask)' },
        { '<leader>ac', avante_complete_code, 'Complete Code(ask)' },
        { '<leader>ad', avante_add_docstring, 'Docstring(ask)' },
        { '<leader>ab', avante_fix_bugs, 'Fix Bugs(ask)' },
        { '<leader>au', avante_add_tests, 'Add Tests(ask)' },
      }

      local prefill_keymaps = {
        { '<leader>aG', avante_grammar_correction, 'Grammar Correction' },
        { '<leader>aK', avante_keywords, 'Keywords' },
        { '<leader>aO', avante_optimize_code, 'Optimize Code(edit)' },
        { '<leader>aC', avante_complete_code, 'Complete Code(edit)' },
        { '<leader>aD', avante_add_docstring, 'Docstring(edit)' },
        { '<leader>aB', avante_fix_bugs, 'Fix Bugs(edit)' },
        { '<leader>aU', avante_add_tests, 'Add Tests(edit)' },
      }

      local keys = {}

      for _, keymap in ipairs(ask_keymaps) do
        table.insert(keys, create_ask_keymap(unpack(keymap)))
      end

      for _, keymap in ipairs(prefill_keymaps) do
        table.insert(keys, create_prefill_keymap(unpack(keymap)))
      end

      return keys
    end,
  },
}
