local fn = vim.fn
local api = vim.api
local map = vim.keymap.set

local filetype_cmds = {
    javascript = {'node'},
    typescript = {'env', 'NO_COLOR=1', 'deno', 'run', '--quiet', '--allow-read', '-'},
    r = {'R', '--vanilla', '--quiet'},
    dot = {'dot', '-Tgtk'},
    lua = function(lines)
        assert(loadstring(table.concat(lines, '\n')))()
    end,
    vim = function(lines)
        print(fn.execute(lines))
    end,
    c = function()
        print(fn.system({'zig', 'run', '-lc', fn.expand('%')}))
    end,
}

-- Takes a range of lines of code from the current buffer and runs them (the
-- whole buffer is run by default)
-- Accepts a shell command to run the code in a specific program
api.nvim_add_user_command('RunCode',
    function(params)
        local line1, line2, cmd = params.line1, params.line2, params.args
        local lines = fn.getline(line1, line2)
        if cmd == '' then cmd = vim.bo.filetype end

        if type(filetype_cmds[cmd]) == 'function' then
            filetype_cmds[cmd](lines)
            return
        end
        local stdout = fn.system(filetype_cmds[cmd] or cmd, lines)
        print(stdout)
    end,
    {
        nargs = '?',
        range = '%',
        complete = 'shellcmd',
    }
)

map('n', '<Leader>rr',  '<Cmd>RunCode<CR>')
map('n', '<Leader>rl',  '<Cmd>.RunCode<CR>')
map('v', '<leader>r', ':RunCode<CR>')
