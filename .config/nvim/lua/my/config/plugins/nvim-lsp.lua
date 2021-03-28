local M = {}

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
    }
)

-- Lightbulb for CodeActions
vim.api.nvim_exec([[
augroup LspLightBulb
    autocmd!
    autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
augroup END
]], false)

local function custom_attach(client, bufnr)
    if client.name == 'sqls' then
        client.resolved_capabilities.execute_command = true
        require'sqls'.setup{
            picker = 'fzf',
        }
    end

    require'my.utils.lsp'.make_lsp_commands(client, bufnr)
    require'my.utils.lsp'.make_lsp_mappings(client, bufnr)
end

function M.init()
    local lsp = require'lspconfig'
    local servers = {
        lsp.tsserver,
        lsp.pyright,
        lsp.clangd,
        lsp.sqls,
    }

    for _, server in ipairs(servers) do
        server.setup {
            on_attach = custom_attach,
        }
    end

    lsp.jsonls.setup {
        cmd = {'vscode-json-language-server', '--stdio'},
        on_attach = custom_attach,
    }

    lsp.html.setup {
        cmd = {'vscode-html-language-server', '--stdio'},
        on_attach = custom_attach,
    }

    lsp.cssls.setup {
        cmd = {'vscode-css-language-server', '--stdio'},
        on_attach = custom_attach,
    }

    lsp.intelephense.setup {
        on_attach = custom_attach,
        init_options = {
            globalStoragePath = vim.env.XDG_DATA_HOME .. '/intelephense'
        }
    }

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
