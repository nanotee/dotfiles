command! LspLog execute '<mods> pedit +$' v:lua.vim.lsp.get_log_path()
command! ClearMakeSigns call sign_unplace('MakeErrors') | call sign_unplace('MakeWarnings')

" Redirects the output of an ex command in a scratch buffer. May become
" obsolete once https://github.com/neovim/neovim/issues/5054 is implemented
command! -nargs=1 -complete=command Redirect
            \ let s:output = split(execute(<q-args>), "\n") |
            \ <mods> new |
            \ setlocal nonumber nolist noswapfile bufhidden=wipe buftype=nofile |
            \ call append(0, s:output) |
            \ unlet s:output

" Takes a range of lines of code from the current buffer and runs them (the
" whole buffer is run by default)
" Accepts a shell command to run the code in a specific program
command! -range=% -nargs=? -complete=shellcmd RunCode lua require'my.utils'.run(<line1>, <line2>, <q-args>)
command! -range=% -nargs=? -complete=shellcmd QuickRun lua require'my.utils'.run(<line1>, <line2>, <q-args>)

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

command! -bang Trash
            \ let s:file = fnamemodify(bufname(<q-args>),':p') |
            \ execute 'bdelete<bang>' |
            \ call system(['kioclient5', 'move', s:file, 'trash:/']) |
            \ if !bufloaded(s:file) && v:shell_error |
            \ echoerr 'Failed to move "'.s:file.'" to trash' |
            \ endif |
            \ unlet s:file

command! -bang -nargs=* WikiFzfSearch
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>) .. ' ' .. g:wiki_root, 1,
            \   fzf#vim#with_preview(), <bang>0)
