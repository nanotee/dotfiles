local M = {}

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
    }
)

local function bmap(mode, lhs, rhs)
    vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, {noremap = true})
end

local function custom_attach(client)
    if client.config.flags then
        client.config.flags.allow_incremental_sync = true
    end
    if client.name == 'sqls' then
        client.resolved_capabilities.execute_command = true
        require'sqls'.setup{
            picker = 'fzf',
        }
    end

    -- Remap keys for gotos
    bmap('n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>')
    bmap('n', ']E', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
    bmap('n', '[E', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')

    -- Use K to show documentation in preview window
    bmap('n', 'K', "<Cmd>lua vim.lsp.buf.hover()<CR>")

    -- Show diagnostics popup
    bmap('n', '<leader>di', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')

    -- CodeAction
    bmap('n', 'gA', '<Cmd>lua vim.lsp.buf.code_action()<CR>')
    bmap('x', 'gA', '<Cmd>lua vim.lsp.buf.range_code_action()<CR>')
    -- Lightbulb for CodeActions
    vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

    -- Stop all language servers
    vim.cmd 'command! -buffer LspStop lua vim.lsp.stop_client(vim.lsp.get_active_clients())'
    -- Rename current word
    vim.cmd 'command! -nargs=? -buffer LspRename lua vim.lsp.buf.rename("<args>" ~= "" and "<args>" or nil)'
    -- References
    vim.cmd 'command! -buffer LspReferences lua vim.lsp.buf.references()'
    -- Formatting
    vim.cmd 'command! -buffer LspFormat lua vim.lsp.buf.formatting_sync()'
end

function M.init()
    local lsp = require'lspconfig'
    local servers = {
        lsp.tsserver,
        lsp.jsonls,
        lsp.intelephense,
        lsp.html,
        lsp.cssls,
        lsp.pyright,
        lsp.clangd,
        lsp.sqls,
    }

    for _, server in ipairs(servers) do
        server.setup {
            on_attach = custom_attach,
        }
    end

    lsp.sumneko_lua.setup {
        cmd = {'lua-language-server'},
        on_attach = custom_attach,
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = vim.split(package.path, ';'),
                },
                diagnostics = {
                    globals = {'vim', 'love', 'dump', 'describe', 'it'},
                },
                workspace = {
                    library = {
                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    },
                },
            },
        },
    }
end

return M
