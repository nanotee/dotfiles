if exists('g:loaded_dracula_treesitter_colors')
  finish
endif
let g:loaded_dracula_treesitter_colors = 1

function! s:set_dracula_treesitter_colors() abort
  hi link TSParameter DraculaOrange
  hi link TSVariableBuiltin DraculaPurpleItalic
  hi link TSOperator DraculaPink
endfunction

function! s:set_dracula_custom() abort
  " Subtler highlight for splits
  hi! link VertSplit EndOfBuffer
  " Make inactive windows darker
  hi! link NormalNC Pmenu
endfunction

augroup dracula_set
  autocmd!
  autocmd ColorSchemePre dracula call s:set_dracula_treesitter_colors()
  autocmd ColorScheme dracula call s:set_dracula_custom()
augroup END

if g:colors_name == 'dracula'
  call s:set_dracula_treesitter_colors()
  call s:set_dracula_custom()
endif
