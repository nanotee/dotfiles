if exists('g:loaded_dracula_treesitter_colors')
  finish
endif
let g:loaded_dracula_treesitter_colors = 1

function! s:set_dracula_treesitter_colors() abort
  hi link TSParameter DraculaOrange
  hi link TSVariableBuiltin DraculaPurpleItalic
  hi link TSOperator DraculaPink
endfunction

augroup dracula_set
  autocmd!
  autocmd ColorSchemePre dracula call s:set_dracula_treesitter_colors()
augroup END

if g:colors_name == 'dracula'
  call s:set_dracula_treesitter_colors()
endif
