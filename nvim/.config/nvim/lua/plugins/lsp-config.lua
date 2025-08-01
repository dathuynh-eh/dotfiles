return { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    'saghen/blink.cmp',
    'b0o/SchemaStore.nvim',
    'pmizio/typescript-tools.nvim',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      -- Create a function that lets us more easily define mappings specific LSP related items.
      -- It sets the mode, buffer and description for us each time.
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-T>.
        map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')

        -- Find references for the word under your cursor.
        map('gr', function() Snacks.picker.lsp_references() end, '[G]oto [R]eferences')
        -- map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

        -- Fuzzy find all the symbols in your current workspace
        --  Similar to document symbols, except searches over your whole project.
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- Rename the variable under your cursor
        --  Most Language Servers support renaming across files, etc.
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap
        map('K', vim.lsp.buf.hover, 'Hover Documentation')

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        map('<leader>rs', ':LspRestart<CR>', 'Restart LSP') -- mapping to restart lsp if necessary

        map('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        map('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        map(
          '<leader>wl',
          function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
          '[W]orkspace [L]ist Folders'
        ) -- The following two autocommands are used to highlight references of the

        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        -- local client = vim.lsp.get_client_by_id(event.data.client_id)
        -- if client and client.server_capabilities.documentHighlightProvider then
        --   vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        --     buffer = event.buf,
        --     callback = vim.lsp.buf.document_highlight,
        --   })
        --
        --   vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        --     buffer = event.buf,
        --     callback = vim.lsp.buf.clear_references,
        --   })
        -- end
      end,
    })

    local lspconfig = require 'lspconfig'
    local capabilities = require('blink.cmp').get_lsp_capabilities() -- Import capabilities from blink.cmp
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    -- Configure lua_ls
    lspconfig.lua_ls.setup {
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          workspace = {
            checkThirdParty = false,
            -- Tells lua_ls where to find all the Lua files that you have loaded
            -- for your neovim configuration.
            library = {
              '${3rd}/luv/library',
              unpack(vim.api.nvim_get_runtime_file('', true)),
            },
            -- If lua_ls is really slow on your computer, you can try this instead:
            -- library = { vim.env.VIMRUNTIME },
          },
          completion = {
            callSnippet = 'Replace',
          },
          telemetry = { enable = false },
          diagnostics = { disable = { 'missing-fields' } },
        },
      },
    }

    -- Configure tsserver (TypeScript and JavaScript)
    lspconfig.ts_ls.setup {
      capabilities = capabilities,
      settings = {},
    }

    -- Configure yamlls
    lspconfig.yamlls.setup {
      capabilities = capabilities,
    }

    -- Configure jsonls
    lspconfig.jsonls.setup {
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require('schemastore').json.schemas {
            select = {
              'package.json',
              'Expo SDK',
              'EAS config',
              'prettierrc.json',
            },
          },
          -- schemas = {
          --   {
          --     fileMatch = { 'package.json' },
          --     url = 'https://json.schemastore.org/package.json',
          --   },
          --   {
          --     fileMatch = { 'tsconfig*.json' },
          --     url = 'https://json.schemastore.org/tsconfig.json',
          --   },
          --   {
          --     fileMatch = { '.prettierrc', '.prettierrc.json', 'prettier.config.json' },
          --     url = 'https://json.schemastore.org/prettierrc.json',
          --   },
          --   {
          --     fileMatch = { '.eslintrc', '.eslintrc.json' },
          --     url = 'https://json.schemastore.org/eslintrc.json',
          --   },
          --   {
          --     fileMatch = { '.babelrc', '.babelrc.json', 'babel.config.json' },
          --     url = 'https://json.schemastore.org/babelrc.json',
          --   },
          --   {
          --     fileMatch = { 'app.json' },
          --     url = 'https://www.schemastore.org/expo-52.0.0.json',
          --   },
          -- },
        },
      },
    }
  end,
}
