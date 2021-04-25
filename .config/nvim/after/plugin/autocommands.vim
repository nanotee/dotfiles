augroup terminal_settings
    autocmd!
    autocmd TermOpen * setlocal bufhidden=hide
    autocmd TermOpen * setlocal nonumber
    autocmd TermOpen * setlocal scrolloff=0
    autocmd TermOpen *zsh* startinsert
augroup END
augroup no_cursorline_in_insert_mode
    autocmd!
    autocmd InsertLeave,WinEnter * set cursorline
    autocmd InsertEnter,WinLeave * set nocursorline
augroup END
augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost grep cwindow
    autocmd QuickFixCmdPost helpgrep cwindow
    autocmd QuickFixCmdPost make lua require('my.utils').quickfix_make_signs("quickfix")
    autocmd QuickFixCmdPost lmake lua require('my.utils').quickfix_make_signs("location")
    autocmd FileType qf setlocal scrolloff=0
augroup END
augroup hl_yank
    autocmd!
    autocmd TextYankPost * lua require('vim.highlight').on_yank()
augroup END
augroup restore_curpos
    autocmd!
    autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif
augroup END
