function! SearchJump()
    cnoremap <Tab> <C-g>
    cnoremap <S-Tab> <C-t>
    autocmd CmdlineLeave * ++once cunmap <Tab>
    autocmd CmdlineLeave * ++once cunmap <S-Tab>
endfunction

noremap / /<Cmd>call SearchJump()<CR>
noremap ? ?<Cmd>call SearchJump()<CR>
