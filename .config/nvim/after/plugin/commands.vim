command! ReloadInit luafile $MYVIMRC
command! InsertDate call append(line('.'), strftime('%Y-%m-%d'))
command! InsertDateLong call append(line('.'), strftime('%Y-%m-%dT%H:%M:%S') .. "+01:00")
command! ClearMakeSigns call sign_unplace('MakeErrors') | call sign_unplace('MakeWarnings')

" Redirects the output of an ex command in a scratch buffer. May become
" obsolete once https://github.com/neovim/neovim/issues/5054 is implemented
command! -nargs=* -complete=command Redirect
    \ let s:result = execute(<q-args>) |
    \ <mods> new |
    \ setlocal nonumber nolist noswapfile bufhidden=delete buftype=nofile |
    \ put =s:result

" Takes a range of lines of code from the current buffer and runs them (the
" whole buffer is run by default)
" Accepts a shell command to run the code in a specific program
command! -range=% -nargs=? -complete=shellcmd Run lua require'my.utils'.run(<line1>, <line2>, <q-args>)

" Creates a scratch buffer in a new window.
" Accepts a range to copy a set of lines over from the current buffer
" (The code can be sent back to its original buffer with :SendBack)
" Accepts a filetype to set the scratch buffer to
" Accepts a modifier to create a vertical split or a new tab
command! -range=0 -nargs=? -complete=filetype Scratch lua require'my.utils'.scratch('<mods>', <range>, <line1>, <line2>, <q-args>)

" I want https://github.com/neovim/neovim/pull/10842 so bad
command! -nargs=+ -complete=file -bang T <mods> new | call termopen([<f-args>]) | setlocal nonumber nolist noswapfile bufhidden=delete
cabbrev ! T!

command! -nargs=? -complete=dir LiveServer lua require'my.utils'.live_server(<f-args>)

command! -nargs=1 -bang Z
    \ let s:folder = system('zoxide query <args>') |
    \ let s:cmd = <bang>0 ? 'lcd' : 'cd' |
    \ execute s:cmd s:folder

" TODO
command! -nargs=1 ExtmarksDebug lua require'my.utils'.extmarks_debug(<q-args>)
command! ExtmarksDebugStop lua require'my.utils'.extmarks_debug_stop()
