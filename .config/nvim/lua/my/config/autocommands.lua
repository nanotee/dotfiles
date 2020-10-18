local autocmds = {
    statusline = {
        {'WinEnter,BufEnter', '*', 'setlocal statusline=%!v:lua.statusline.active()'},
        {'WinLeave,BufLeave', '*', 'setlocal statusline=%!v:lua.statusline.inactive()'},
        {'ColorScheme', 'dracula', 'luafile ' .. vim.fn.stdpath('config') .. '/lua/my/statusline_colors.lua'},
    },
    terminal_settings = {
        {'TermOpen', '*', 'setlocal bufhidden=hide'},
        {'TermOpen', '*', 'setlocal nonumber'},
        {'TermOpen', '*', 'setlocal scrolloff=0'}, -- Fix terminal flicker
        {'TermOpen', '*zsh*', 'startinsert'},
    },
    no_cursorline_in_insert_mode = {
        {'InsertLeave,WinEnter', '*', 'set cursorline'},
        {'InsertEnter,WinLeave', '*', 'set nocursorline'},
    },
    quickfix = {
        {'QuickFixCmdPost', 'grep', 'cwindow'},
        {'QuickFixCmdPost', 'helpgrep', 'cwindow'},
        {'QuickFixCmdPost', 'make', 'lua require"my.utils".quickfix_make_signs("quickfix")'},
        {'QuickFixCmdPost', 'lmake', 'lua require"my.utils".quickfix_make_signs("location")'},
        {'FileType', 'qf', 'setlocal scrolloff=0'},
    },
    hl_yank = {
        {'TextYankPost',  '*', 'lua require"vim.highlight".on_yank()'},
    },
    restore_curpos = {
        {
        'BufReadPost',
        '*',
        [[
        if line("'\"") >= 1 && line("'\"") <= line("$")
            exe "normal! g`\""
        endif
        ]],
        },
    },
}

require'my.utils'.nvim_create_augroups(autocmds)
