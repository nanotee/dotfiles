local M = {}

local fn = vim.fn

function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

-- Taken from https://github.com/norcalli/nvim_utils/blob/master/lua/nvim_utils.lua#L554-L567
function M.nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.cmd('augroup '..group_name)
        vim.cmd('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            vim.cmd(command)
        end
        vim.cmd('augroup END')
    end
end

function M.setup_keymaps(mappings)
    local default_opts = {noremap = true}
    for _, mapping in ipairs(mappings) do
        vim.api.nvim_set_keymap(mapping[1], mapping[2], mapping[3], mapping[4] or default_opts)
    end
end

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
    vim.cmd('command! LiveServerStop lua require"my.utils".live_server_stop('..job_id..')')
    live_server_running = true
end

function M.live_server_stop(job_id)
    fn.jobstop(job_id)
    live_server_running = false
    vim.cmd 'delcommand LiveServerStop'
end

function M.run(line1, line2, cmd)
    local lines = fn.getline(line1, line2)
    if cmd == '' then cmd = vim.bo.filetype end

    if cmd == 'vim' then
        print(fn.execute(lines))
    elseif cmd == 'lua' then
        assert(loadstring(table.concat(lines, '\n')))()
    else
        local filetype_cmds = {
            javascript = {'node'},
            typescript = {'deno'},
        }
        local stdout = fn.system(filetype_cmds[cmd] or cmd, lines)
        print(stdout)
    end
end

function M.extmarks_debug(extmark_group)
end

function M.extmarks_debug_stop()
end

return M