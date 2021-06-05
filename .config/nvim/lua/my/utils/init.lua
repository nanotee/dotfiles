local M = {}

local fn = vim.fn
local api = vim.api
local luv = vim.loop

function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
    return ...
end

function _G.reload(modname)
    package.loaded[modname] = nil
    return require(modname)
end

function _G.benchmark(fun, name)
    local start = luv.hrtime()
    fun()
    local total = (luv.hrtime() - start) / 1e6
    print(total, 'ms', name and '--- ' .. name or '')
end

M.map = setmetatable({}, {
        __index = function(_, mode)
            return setmetatable({}, {
                    __newindex = function(_, lhs, tbl)
                        if tbl == nil then api.nvim_del_keymap(mode, lhs); return end
                        local rhs = table.remove(tbl, 1)
                        local opts = {}
                        for _, v in ipairs(tbl) do
                            opts[v] = true
                        end
                        api.nvim_set_keymap(mode, lhs, rhs, opts)
                    end
                })
        end
    })

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
