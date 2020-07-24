local M = {}

local fn = vim.fn

function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

-- Visual Mode */# from Scrooloose
function M.VSetSearch()
    local temp = fn.getreg('@')
    vim.cmd [[norm! gvy]]
    local search_string =
        [[\V]]..fn.substitute(fn.escape(fn.getreg('@'), [[\]]), [[\n]], [[\\n]], 'g')
    fn.setreg('/', search_string)
    fn.setreg('@', temp)
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
    if cmd ~= '' then
        local stdout = fn.system(cmd, lines)
        print(stdout)
        return
    end

    if vim.bo.filetype == 'vim' then
        print(fn.execute(lines))
    elseif vim.bo.filetype == 'lua' then
        assert(loadstring(table.concat(lines, '\n')))()
    else
        local filetype_cmds = {
            javascript = 'node',
            typescript = 'deno',
        }
        local stdout = fn.system(filetype_cmds[vim.bo.filetype] or vim.bo.filetype, lines)
        print(stdout)
    end
end

function M.scratch(mods, range, line1, line2, filetype)
    local ns = vim.api.nvim_create_namespace('scratch_buffer')
    local mark_start, mark_end

    local original_bufnr = fn.bufnr()
    local tempname = fn.tempname()
    local range_of_lines = {}
    if range ~= 0 then
        mark_start = vim.api.nvim_buf_set_extmark(original_bufnr, ns, 0, line1, 0, {})
        mark_end = vim.api.nvim_buf_set_extmark(original_bufnr, ns, 0, line2, 0, {})
        range_of_lines = fn.getline(line1, line2)
    end
    local scratch_ft = vim.bo.filetype
    if filetype ~= '' then scratch_ft = filetype end

    vim.cmd(mods..' new '..tempname)

    if range ~= 0 then
        vim.b.original_bufnr = original_bufnr
        vim.b.original_mark_start = mark_start
        vim.b.original_mark_end = mark_end
        vim.b.original_ns = ns
        -- Send the code in the scratch buffer back to its original buffer
        vim.cmd 'command! -buffer SendBack lua require"my.utils".send_back()'
    end

    vim.bo.filetype = scratch_ft
    vim.bo.buftype = 'nofile'
    vim.bo.bufhidden = 'hide'
    vim.bo.swapfile = false

    fn.setline(1, range_of_lines)
end

function M.send_back()
    if fn.buflisted(vim.b.original_bufnr) == 0 then
        print('The original buffer was closed')
        return
    end

    local text_to_send = fn.getline(1, fn.line('$'))

    local line1 = vim.api.nvim_buf_get_extmark_by_id(
        vim.b.original_bufnr,
        vim.b.original_ns,
        vim.b.original_mark_start
        )[1]
    local line2 = vim.api.nvim_buf_get_extmark_by_id(
        vim.b.original_bufnr,
        vim.b.original_ns,
        vim.b.original_mark_end
        )[1]

    vim.api.nvim_buf_set_lines(
        vim.b.original_bufnr,
        line1 - 1,
        line2,
        true,
        text_to_send
        )

    vim.b.original_mark_start = vim.api.nvim_buf_set_extmark(
        vim.b.original_bufnr,
        vim.b.original_ns,
        vim.b.original_mark_start,
        line1,
        0,
        {}
        )

    vim.b.original_mark_end = vim.api.nvim_buf_set_extmark(
        vim.b.original_bufnr,
        vim.b.original_ns,
        vim.b.original_mark_end,
        line1 + #text_to_send - 1,
        0,
        {}
        )
end

function M.extmarks_debug(extmark_group)
end

function M.extmarks_debug_stop()
end

return M
