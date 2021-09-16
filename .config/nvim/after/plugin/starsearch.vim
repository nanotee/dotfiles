" Keep */# from automatically jumping to the next result
nnoremap * <Cmd>let @/ = '\<'..expand('<cword>')..'\>'<CR>
            \<Cmd>let v:hlsearch = 1<CR>
            \<Cmd>let v:searchforward = 1<CR>
nnoremap # <Cmd>let @/ = '\<'..expand('<cword>')..'\>'<CR>
            \<Cmd>let v:hlsearch = 1<CR>
            \<Cmd>let v:searchforward = 0<CR>
nnoremap g* <Cmd>let @/ = expand('<cword>')<CR>
            \<Cmd>let v:hlsearch = 1<CR>
            \<Cmd>let v:searchforward = 1<CR>
nnoremap g# <Cmd>let @/ = expand('<cword>')<CR>
            \<Cmd>let v:hlsearch = 1<CR>
            \<Cmd>let v:searchforward = 0<CR>

" Visual Mode */# from Scrooloose (with a few tweaks)
function s:VSetSearch()
    let temp = @@
    noautocmd silent! normal! y
    let @/ = '\V'..substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction

xnoremap <silent> * <Cmd>call <SID>VSetSearch()<CR>
            \<Cmd>let v:hlsearch = 1<CR>
            \<Cmd>let v:searchforward = 1<CR>
xnoremap <silent> # <Cmd>call <SID>VSetSearch()<CR>
            \<Cmd>let v:hlsearch = 1<CR>
            \<Cmd>let v:searchforward = 0<CR>
