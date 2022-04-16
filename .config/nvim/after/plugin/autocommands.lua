local api = vim.api
local fn = vim.fn
local opt_local = vim.opt_local

api.nvim_create_autocmd('TermOpen', {
    group = api.nvim_create_augroup('terminal_settings', {}),
    callback = function()
        opt_local.bufhidden = 'hide'
        opt_local.number = false
    end,
})

api.nvim_create_augroup('no_cursorline_in_insert_mode', {})
api.nvim_create_autocmd({'InsertLeave', 'WinEnter'}, {
    group = 'no_cursorline_in_insert_mode',
    callback = function()
        opt_local.cursorline = true
    end,
})
api.nvim_create_autocmd({'InsertEnter', 'WinLeave'}, {
    group = 'no_cursorline_in_insert_mode',
    callback = function()
        opt_local.cursorline = false
    end,
})

api.nvim_create_autocmd('QuickFixCmdPost', {
    pattern = {'grep', 'helpgrep'},
    group = api.nvim_create_augroup('quickfix', {}),
    command = 'cwindow',
})

api.nvim_create_autocmd('TextYankPost', {
    group = api.nvim_create_augroup('hl_yank', {}),
    callback = function() vim.highlight.on_yank() end,
})

api.nvim_create_autocmd('BufReadPost', {
    group = api.nvim_create_augroup('restore_curpos', {}),
    callback = function()
        if fn.line("'\"") >= 1 and fn.line("'\"") <= fn.line('$') and not opt_local.filetype:get():match('commit') then
            fn.execute('normal! g`"')
        end
    end,
})
