local lsp = vim.lsp
local map = vim.api.nvim_set_keymap
map('n', ']E', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {noremap = true})
map('n', '[E', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', {noremap = true})
map('n', 'gl', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics({border = "single"})<CR>', {noremap = true})

lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(lsp.diagnostic.on_publish_diagnostics,
    {virtual_text = false})

lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover,
    {border = 'single'})

lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help,
    {border = 'single'})

local function custom_attach(client, bufnr)
    if client.name == 'sqls' then
        client.resolved_capabilities.execute_command = true
        require('sqls').setup{picker = 'fzf'}
    end

    require('lsp_basics').make_lsp_commands(client, bufnr)

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
    if cap.signature_help then
        bmap('n', 'gS', '<Cmd>lua vim.lsp.buf.signature_help()<CR>')
    end
    if cap.code_action then
        bmap('n', 'gA', '<Cmd>lua vim.lsp.buf.code_action()<CR>')
        bmap('x', 'gA', '<Esc><Cmd>lua vim.lsp.buf.range_code_action()<CR>')
    end

    require('lsp_signature').on_attach{
        bind = true,
        handler_opts = {
            border = 'single',
        },
    }
end

local capabilities = lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    }
}

local lspconfig = require('lspconfig')
lspconfig.util.default_config = vim.tbl_extend(
    'force',
    lspconfig.util.default_config,
    {capabilities = capabilities, on_attach = custom_attach})

lspconfig.tsserver.setup{}
-- lspconfig.denols.setup{init_options = {config = './tsconfig.json'}}
lspconfig.pyright.setup{}
lspconfig.clangd.setup{}
lspconfig.sqls.setup{}
-- lspconfig.phpactor.setup{}
lspconfig.intelephense.setup{init_options = {globalStoragePath = vim.env.XDG_DATA_HOME .. '/intelephense'}}
lspconfig.jsonls.setup{cmd = {'vscode-json-language-server', '--stdio'}}
lspconfig.html.setup{cmd = {'vscode-html-language-server', '--stdio'}}
lspconfig.cssls.setup{cmd = {'vscode-css-language-server', '--stdio'}}
lspconfig.zeta_note.setup{cmd = {'zeta-note'}}

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
                globals = {'vim', 'love', 'dump', 'describe', 'it'},
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
            },
            -- completion = {
            --     callSnippet = 'Replace',
            -- },
        },
    },
}

-- Lightbulb for CodeActions
vim.api.nvim_exec([[
    augroup LspLightBulb
        autocmd!
        autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
    augroup END
    ]], false)
