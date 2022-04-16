local lsp = vim.lsp
local api = vim.api
lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover,
    {border = 'rounded'})

lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help,
    {border = 'rounded'})

local function custom_attach(client, bufnr)
    if client.name == 'sqls' then
        require('sqls').on_attach(client, bufnr)
    end

    require('lsp_basics').make_lsp_commands(client, bufnr)
    require('lsp_basics').make_lsp_mappings(client, bufnr)

    local function bmap(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, {buffer = bufnr})
    end

    local cap = client.resolved_capabilities
    if cap.goto_definition then
        bmap('n', '<C-]>', lsp.buf.definition)
    end
    if cap.hover then
        bmap('n', 'K', lsp.buf.hover)
    end
    if cap.code_action then
        bmap('n', 'gA', lsp.buf.code_action)
        bmap('x', 'gA', '<Esc><Cmd>lua vim.lsp.buf.range_code_action()<CR>')
    end
end

local lspconfig = require('lspconfig')
lspconfig.util.default_config = vim.tbl_extend(
    'force',
    lspconfig.util.default_config,
    {
        capabilities = require('cmp_nvim_lsp').update_capabilities(lsp.protocol.make_client_capabilities()),
        on_attach = custom_attach,
    })

lspconfig.denols.setup{}
lspconfig.pyright.setup{}
lspconfig.clangd.setup{}
lspconfig.sqls.setup{}
lspconfig.phpactor.setup{}
-- lspconfig.intelephense.setup{init_options = {globalStoragePath = vim.env.XDG_DATA_HOME .. '/intelephense'}}
lspconfig.jsonls.setup{
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
                {
                    fileMatch = {'.prettierrc'},
                    url = 'https://json.schemastore.org/prettierrc.json',
                },
                {
                    fileMatch = {'deno.json', 'deno.jsonc'},
                    url = 'https://deno.land/x/deno/cli/schemas/config-file.v1.json',
                },
            },
        },
    },
}
lspconfig.yamlls.setup{}
lspconfig.html.setup{}
lspconfig.cssls.setup{}
lspconfig.zeta_note.setup{cmd = {'zeta-note'}}
lspconfig.zls.setup{}

local runtime_path = vim.split(package.path, ';', true)
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.sumneko_lua.setup{
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
api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
    group = api.nvim_create_augroup('LspLightBulb', {}),
    callback = function() require('nvim-lightbulb').update_lightbulb() end,
})
