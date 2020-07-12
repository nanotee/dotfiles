command! ReloadInit luafile $MYVIMRC
command! InsertDate call append(line('.'), strftime('%Y-%m-%d'))
command! InsertDateLong call append(line('.'), strftime('%Y-%m-%dT%H:%M:%S') .. "+01:00")
command! ClearMakeSigns call sign_unplace('MakeErrors') | call sign_unplace('MakeWarnings')

" Redirects the output of an ex command in a scratch buffer. May become
" obsolete once https://github.com/neovim/neovim/issues/5054 is implemented
command! -nargs=* -complete=command Redirect
    \ let s:result = execute('<args>') |
    \ <mods> new |
    \ setlocal nonumber nolist noswapfile bufhidden=delete buftype=nofile |
    \ put =s:result

" Takes a range of lines of code from the current buffer and runs them (the
" whole buffer is run by default)
command! -range=% Run lua require'my.utils'.run('<line1>', '<line2>')

" Creates a scratch buffer in a new window.
" Accepts a range to copy a set of lines over from the current buffer
" (The code can be sent back to its original buffer with :SendBack)
" Accepts a filetype to set the scratch buffer to
" Accepts a modifier to create a vertical split or a new tab
command! -range=0 -nargs=? -complete=filetype Scratch lua require'my.utils'.scratch('<mods>', <range>, <line1>, <line2>, '<args>')
