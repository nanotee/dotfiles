local U = require'snippets.utils'
local idt = U.match_indentation

require'snippets'.snippets = {
    lua = {
        ['for'] = idt'for ${1:k}, ${2:v} in ipairs($3) do\n$0\nend',
        ['if'] = idt'if $1 then\n$0\nend',
        fn = idt'function${1|vim.trim(S.v):gsub("^%S"," %0")}(${2|vim.trim(S.v)})\n$0\nend',
        req = "local ${2:${1|S.v:match'[^.]+$'}} = require('$1')",
        ["local"] = 'local ${2:${1|S.v:match"[^.]+$"}} = ${1}',
    },
    markdown = {
        date = '${=os.date("%Y-%m-%d")}',
        datel = '${=os.date("%Y-%m-%dT%H:%M:%S+01:00")}',
        code = '```$1\n$0\n```',
    },
    c = {
        boilerplate =
        '#include <stdio.h>\n#include <stdlib.h>\n\n' ..
        'int main(int argc, char *argv[])\n' ..
        '{\n    $0\n    return EXIT_SUCCESS;\n}'
    },
}
