command! ReloadInit luafile $MYVIMRC
command! ClearMakeSigns call sign_unplace('MakeErrors') | call sign_unplace('MakeWarnings')

" Redirects the output of an ex command in a scratch buffer. May become
" obsolete once https://github.com/neovim/neovim/issues/5054 is implemented
command! -nargs=* -complete=command Redirect
    \ let s:result = execute(<q-args>) |
    \ <mods> new |
    \ setlocal nonumber nolist noswapfile bufhidden=wipe buftype=nofile |
    \ put =s:result | unlet s:result

" Takes a range of lines of code from the current buffer and runs them (the
" whole buffer is run by default)
" Accepts a shell command to run the code in a specific program
command! -range=% -nargs=? -complete=shellcmd Run lua require'my.utils'.run(<line1>, <line2>, <q-args>)

" Creates a scratch buffer in a new window.
" Accepts a range to copy a set of lines over from the current buffer
" (The code can be sent back to its original buffer with :SendBack)
" Accepts a filetype to set the scratch buffer to
" Accepts a modifier to create a vertical split or a new tab
command! -range=0 -nargs=? -complete=filetype Scratch lua require'my.utils.scratch'.create('<mods>', <range>, <line1>, <line2>, <q-args>)

" I want https://github.com/neovim/neovim/pull/10842 so bad
command! -nargs=+ -complete=file T
    \ tab new | setlocal nonumber nolist noswapfile bufhidden=wipe |
    \ call termopen([<f-args>]) |
    \ startinsert
cabbrev ! T

command! -nargs=? -complete=dir LiveServer lua require'my.utils'.live_server(<f-args>)

function! s:align(line1, line2, ...)
    let l:separator = shellescape(a:1)
    let l:output_separator = exists('a:2') ? shellescape(a:2) : l:separator
    execute a:line1..","..a:line2.."!column -t -s"..l:separator.." -o"..l:output_separator
endfunction

command! -nargs=+ -range Align call s:align(<line1>, <line2>, <f-args>)

command! -bang Trash
            \ let s:file = fnamemodify(bufname(<q-args>),':p') |
            \ execute 'bdelete<bang>' |
            \ call system(['kioclient5', 'move', s:file, 'trash:/']) |
            \ if !bufloaded(s:file) && v:shell_error |
            \ echoerr 'Failed to move "'.s:file.'" to trash' |
            \ endif |
            \ unlet s:file
