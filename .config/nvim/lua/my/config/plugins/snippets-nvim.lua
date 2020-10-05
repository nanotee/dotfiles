local U = require'snippets.utils'
local idt = U.match_indentation

local map = require('my.utils').map
map.i['<C-A-k>'] = {"<Cmd>lua require'snippets'.expand_or_advance()<CR>", 'noremap'}
map.i['<C-A-j>'] = {"<Cmd>lua require'snippets'.expand_or_advance(-1)<CR>", 'noremap'}

require'snippets'.snippets = {
    _global = {
        date = '${=os.date("%Y-%m-%d")}',
        datel = '${=os.date("%Y-%m-%dT%H:%M:%S+01:00")}',
    },
    lua = {
        ['for'] = idt'for ${1:k}, ${2:v} in ipairs($3) do\n$0\nend',
        ['if'] = idt'if $1 then\n$0\nend',
        fn = idt'function${1|vim.trim(S.v):gsub("^%S"," %0")}(${2|vim.trim(S.v)})\n$0\nend',
        req = "local ${2:${1|S.v:match'[^.]+$'}} = require('$1')",
        ["local"] = 'local ${2:${1|S.v:match"[^.]+$"}} = ${1}',
    },
    markdown = {
        cb = '```$1\n$0\n```',
    }
}
