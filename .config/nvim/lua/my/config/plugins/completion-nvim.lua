local M = {}

local fn = vim.fn
local api = vim.api
local completion = require'completion'
local snippets = require'snippets'

vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
vim.g.completion_enable_auto_paren = 1
vim.g.completion_confirm_key = ''
vim.g.completion_enable_snippet = 'snippets.nvim'
vim.g.completion_auto_change_source = 1

vim.g.completion_chain_complete_list = {
    default = {
        default = {
            {complete_items = {'lsp', 'snippet'}},
            {mode = '<c-n>'},
            {mode = '<c-p>'},
        },
        ['string'] = {
            {complete_items = {'path'}},
        },
        vim = {
            {mode = 'cmd'},
        },
        sql = {
            {complete_items = {'vim-dadbod-completion'}},
        },
    }
}

local function check_back_space()
    local col = api.nvim_win_get_cursor(0)[2]
    return col == 0 or api.nvim_get_current_line():sub(col, col):match('%s')
end

local function feedkeys(str) api.nvim_feedkeys(api.nvim_replace_termcodes(str, true, true, true), 'n', true) end

function M.tab_func()
    local info = fn.complete_info()
    if info.pum_visible ~= 0 and info.selected ~= "-1" then
        completion.confirmCompletion()
        feedkeys '<C-y>'
    elseif snippets.has_active_snippet() then
        snippets.expand_or_advance(1)
    elseif check_back_space() then
        feedkeys '<Tab>'
    else
        completion.triggerCompletion()
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

map.i['<Tab>'] = {"<Cmd>lua require'my.config.plugins.completion-nvim'.tab_func()<CR>"}
map.i['<S-Tab>'] = {"<Cmd>lua require'my.config.plugins.completion-nvim'.s_tab_func()<CR>"}

local autocmds = {
    completion_nvim = {
        {'BufEnter', '*', "lua require'completion'.on_attach()"},
    }
}

require'my.utils'.nvim_create_augroups(autocmds)

return M
