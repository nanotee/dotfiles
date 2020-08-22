vim.cmd 'packadd snippets.nvim'
vim.cmd 'autocmd VimEnter * lua require"my.config.plugins.snippets-nvim".init()'

local M = {}

function M.init()
    local U = require'snippets.utils'
    local idt = U.match_indentation

    require'my.utils'.setup_keymaps{
        {
            'i',
            '<C-A-k>',
            "<Cmd>lua return require'snippets'.expand_or_advance()<CR>",
        },
    }
    require'snippets'.snippets = {
        _global = {
            date = '${=os.date("%Y-%m-%d")}',
            datel = '${=os.date("%Y-%m-%dT%H:%M:%S+01:00")}',
        },
        lua = {
            ['for'] = idt'for ${1:k}, ${2:v} in ipairs(${3:}) do\n$0\nend',
            ['if'] = idt'if ${1:} then\n$0\nend',
            fn = idt'function${1|vim.trim(S.v):gsub("^%S"," %0")}(${2|vim.trim(S.v)})\n$0\nend',
            req = 'local ${2:${1|S.v:match"[^.]+$"}} = require("$1")',
            ["local"] = 'local ${2:${1|S.v:match"[^.]+$"}} = ${1}',
        },
    }
end

return M
