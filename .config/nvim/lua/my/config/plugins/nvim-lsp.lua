vim.cmd 'packadd nvim-lspconfig'
require'my.config.plugins.diagnostic-nvim'

local M = {}

function M.show_documentation()
    if vim.tbl_contains({'vim','help'}, vim.bo.filetype) then
        vim.cmd('help '..vim.fn.expand('<cword>'))
    else
        vim.lsp.buf.hover()
    end
end

local function custom_attach()
    require'diagnostic'.on_attach()

    local mappings = {
        -- Remap keys for gotos
        {'n', '<leader>gd', '<Cmd>lua vim.lsp.buf.definition()<CR>'},
        {'n', '<leader>gy', '<Cmd>lua vim.lsp.buf.type_definition()<CR>'},
        {'n', '<leader>gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>'},
        {'n', '<leader>gr', '<Cmd>lua vim.lsp.buf.references()<CR>'},

        -- Rename current word
        {'n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>'},

        -- Use K to show documentation in preview window
        {'n', 'K', "<Cmd>lua require'my.config.plugins.nvim-lsp'.show_documentation()<CR>"},

        -- Show diagnostics popup
        {'n', '<leader>di', "<Cmd>lua require'jumpLoc'.openLineDiagnostics()<CR>"},
    }

    require'my.utils'.setup_buf_keymaps(mappings)

    -- Stop all language servers
    vim.cmd 'command! LspStop lua vim.lsp.stop_client(vim.lsp.get_active_clients())'
    -- CodeAction
    vim.cmd 'command! CodeAction lua vim.lsp.buf.code_action()'
end

function M.init()
    local lsp = require'nvim_lsp'
    local configs = require'nvim_lsp/configs'
    local servers = {
        lsp.tsserver,
        lsp.jsonls,
        lsp.intelephense,
        lsp.html,
        lsp.cssls,
        lsp.nimls,
        lsp.pyls,
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
                on_attach = custom_attach,
            }
        }
    end
    lsp.lua_lsp.setup{}

    if not configs.sqls then
        configs.sqls = {
            default_config = {
                cmd = {'sqls'},
                filetypes = {'sql'},
                root_dir = function(fname)
                    return lsp.util.find_git_ancestor(fname) or vim.loop.os_homedir()
                end,
                on_attach = custom_attach,
            }
        }
    end
    lsp.sqls.setup{}

end

return M
