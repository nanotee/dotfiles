local M = {}

local api = vim.api
local fn = vim.fn
local compe = require('compe')
local snippets = require('snippets')

compe.setup{
    enabled = true,
    preselect = 'always',
    source = {
        path = true,
        buffer = true,
        nvim_lsp = true,
        nvim_lua = true,
        snippets_nvim = true,
    }
}

local function feedkeys(str) api.nvim_feedkeys(api.nvim_replace_termcodes(str, true, true, true), 'n', true) end

function M.tab_func()
    if snippets.has_active_snippet() then
        snippets.expand_or_advance(1)
    else
        fn['compe#confirm']('\t')
    end
end

function M.s_tab_func()
    if snippets.has_active_snippet() then
        snippets.expand_or_advance(-1)
    else
        feedkeys '<S-Tab>'
    end
end

local map = require'my.utils'.map

map.i['<Tab>'] = {"<Cmd>lua require'my.config.plugins.nvim-compe'.tab_func()<CR>"}
map.i['<S-Tab>'] = {"<Cmd>lua require'my.config.plugins.nvim-compe'.s_tab_func()<CR>"}

return M
