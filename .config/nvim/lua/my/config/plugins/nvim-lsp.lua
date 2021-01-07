local M = {}

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
    }
)

local function bmap(mapping)
    vim.api.nvim_buf_set_keymap(0, mapping[1], mapping[2], mapping[3], {noremap = true})
end

local function custom_attach()
    -- Remap keys for gotos
    bmap{'n', '<leader>gd', '<Cmd>lua vim.lsp.buf.definition()<CR>'}
    bmap{'n', '<leader>gr', '<Cmd>lua vim.lsp.buf.references()<CR>'}
    bmap{'n', ']E', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>'}
    bmap{'n', '[E', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>'}

    -- Rename current word
    bmap{'n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>'}

    -- Use K to show documentation in preview window
    bmap{'n', 'K', "<Cmd>lua vim.lsp.buf.hover()<CR>"}

    -- Show diagnostics popup
    bmap{'n', '<leader>di', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>'}

    -- Stop all language servers
    vim.cmd 'command! LspStop lua vim.lsp.stop_client(vim.lsp.get_active_clients())'
    -- CodeAction
    vim.cmd 'command! CodeAction lua vim.lsp.buf.code_action()'
end

function M.init()
    local lsp = require'lspconfig'
    local configs = require'lspconfig/configs'
    local servers = {
        lsp.tsserver,
        lsp.jsonls,
        lsp.intelephense,
        lsp.html,
        lsp.cssls,
        lsp.pyright,
        lsp.clangd,
    }

    for _, server in ipairs(servers) do
        server.setup {
            on_attach = custom_attach
        }
    end

    if not configs.lua_lsp then
        configs.lua_lsp = {
            default_config = {
                cmd = {'lua-lsp'},
                filetypes = {'lua'},
                root_dir = function(fname)
                    return lsp.util.find_git_ancestor(fname) or vim.loop.os_homedir()
                end,
            }
        }
    end
    -- lsp.lua_lsp.setup{
    --     on_attach = custom_attach,
    -- }
    require'lspconfig'.sumneko_lua.setup {
        cmd = {
            vim.env.HOME .. '/.local/bin/lua-language-server-src/bin/Linux/lua-language-server',
            '-E',
            vim.env.HOME .. '/.local/bin/lua-language-server-src/main.lua',
        },
        on_attach = custom_attach,
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = vim.split(package.path, ';'),
                },
                diagnostics = {
                    globals = {'vim', 'reload', 'love', 'dump'},
                },
                workspace = {
                    library = {
                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                    },
                },
            },
        },
    }

    if not configs.sqls then
        configs.sqls = {
            default_config = {
                cmd = {'sqls'},
                filetypes = {'sql'},
                root_dir = function(fname)
                    return lsp.util.find_git_ancestor(fname) or vim.loop.os_homedir()
                end,
            }
        }
    end
    lsp.sqls.setup{
        on_attach = custom_attach,
    }

end

return M
