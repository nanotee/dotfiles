local M = {}

local fn = vim.fn

local filetype_cmds = {
    javascript = {'node'},
    typescript = {'env', 'NO_COLOR=1', 'deno', 'run', '--quiet', '--allow-read', '-'},
    r = {'R', '--vanilla', '--quiet'},
    lua = function(lines)
        assert(loadstring(table.concat(lines, '\n')))()
    end,
    vim = function(lines)
        print(fn.execute(lines))
    end,
    c = function()
        print(fn.system({'c', fn.expand('%')}))
    end,
}

function M.run(line1, line2, cmd)
    local lines = fn.getline(line1, line2)
    if cmd == '' then cmd = vim.bo.filetype end

    if type(filetype_cmds[cmd]) == 'function' then
        filetype_cmds[cmd](lines)
        return
    end
    local stdout = fn.system(filetype_cmds[cmd] or cmd, lines)
    print(stdout)
end

return M
