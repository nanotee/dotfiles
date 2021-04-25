local M = {}

local fn = vim.fn
local api = vim.api

function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

function _G.reload(modname)
    package.loaded[modname] = nil
    return require(modname)
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

function M.quickfix_make_signs(make_type)
    fn.sign_define('MakeError', {text = 'x', texthl = 'DraculaError'})
    fn.sign_define('MakeWarning', {text = '!', texthl = 'DraculaOrange'})
    fn.sign_unplace('MakeErrors')
    fn.sign_unplace('MakeWarnings')
    local err_list
    if make_type == 'quickfix' then
        err_list = fn.getqflist()
    elseif make_type == 'location' then
        err_list = fn.getloclist(0)
    end
    for _, err_item in ipairs(err_list) do
        if err_item.valid == 1 then
            if err_item.type == 'E' then
                fn.sign_place(0, 'MakeErrors', 'MakeError', err_item.bufnr, {lnum = err_item.lnum, priority = 50})
            else
                fn.sign_place(0, 'MakeWarnings', 'MakeWarning', err_item.bufnr, {lnum = err_item.lnum, priority = 40})
            end
        end
    end
end

local live_server_running = false

function M.live_server(folder)
    if live_server_running then
        print('Live server already running')
        return
    end
    local job_id = fn.jobstart({'live-server', folder or '.'})
    vim.cmd('command! LiveServerStop lua require"my.utils".live_server_stop(' .. job_id .. ')')
    live_server_running = true
end

function M.live_server_stop(job_id)
    fn.jobstop(job_id)
    live_server_running = false
    vim.cmd 'delcommand LiveServerStop'
end

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
