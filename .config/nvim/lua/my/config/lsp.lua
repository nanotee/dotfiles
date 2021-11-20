local lsp = vim.lsp
lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover,
    {border = 'rounded'})

lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help,
    {border = 'rounded'})

local function custom_attach(client, bufnr)
    if client.name == 'sqls' then
        client.resolved_capabilities.execute_command = true
        client.commands = require('sqls').commands
        require('sqls').setup{}
    end

    require('lsp_basics').make_lsp_commands(client, bufnr)
    require('lsp_basics').make_lsp_mappings(client, bufnr)

    local function bmap(mode, lhs, rhs)
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, {noremap = true})
    end

    local cap = client.resolved_capabilities
    if cap.goto_definition then
        bmap('n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>')
    end
    if cap.hover then
        bmap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
    end
    if cap.code_action then
        bmap('n', 'gA', '<Cmd>lua vim.lsp.buf.code_action()<CR>')
        bmap('x', 'gA', '<Esc><Cmd>lua vim.lsp.buf.range_code_action()<CR>')
    end

    require('lsp_signature').on_attach{
        bind = true,
        handler_opts = {
            border = 'rounded',
        },
    }
end

local lspconfig = require('lspconfig')
lspconfig.util.default_config = vim.tbl_extend(
    'force',
    lspconfig.util.default_config,
    {
        capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = custom_attach,
        flags = { debounce_text_changes = 150 },
    })

-- lspconfig.tsserver.setup{}
lspconfig.denols.setup{init_options = {config = './tsconfig.json'}}
lspconfig.pyright.setup{}
lspconfig.clangd.setup{}
lspconfig.sqls.setup{}
lspconfig.phpactor.setup{}
-- lspconfig.intelephense.setup{init_options = {globalStoragePath = vim.env.XDG_DATA_HOME .. '/intelephense'}}
lspconfig.jsonls.setup{
    cmd = {'vscode-json-language-server', '--stdio'},
    filetypes = {'json', 'jsonc'},
    settings = {
        json = {
            schemas = {
                {
                    fileMatch = {'composer.json'},
                    url = 'https://raw.githubusercontent.com/composer/composer/master/res/composer-schema.json',
                },
                {
                    fileMatch = {'package.json'},
                    url = 'https://json.schemastore.org/package.json',
                },
                {
                    fileMatch = {'tsconfig.json'},
                    url = 'https://json.schemastore.org/tsconfig.json',
                },
                {
                    fileMatch = {'compile_commands.json'},
                    url = 'https://json.schemastore.org/compile-commands.json',
                },
            },
        },
    },
}
lspconfig.yamlls.setup{}
lspconfig.html.setup{cmd = {'vscode-html-language-server', '--stdio'}}
lspconfig.cssls.setup{cmd = {'vscode-css-language-server', '--stdio'}}
lspconfig.zeta_note.setup{cmd = {'zeta-note'}}
lspconfig.zls.setup{}

local runtime_path = vim.split(package.path, ';', true)
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.sumneko_lua.setup{
    cmd = {'lua-language-server'},
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = runtime_path,
            },
            diagnostics = {
                globals = {'vim', 'love', 'put', 'describe', 'it'},
            },
            workspace = {
                preloadFileSize = 150,
                library = {
                    vim.fn.stdpath('data') .. '/site/pack/packer/start/lua-dev.nvim',
                },
            },
            completion = {
                callSnippet = 'Replace',
                showWord = 'Disable',
            },
        },
    },
}

-- Lightbulb for CodeActions
vim.cmd [[
augroup LspLightBulb
    autocmd!
    autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()
augroup END
]]
