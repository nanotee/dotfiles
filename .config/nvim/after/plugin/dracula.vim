if exists('g:loaded_dracula_custom_colors')
  finish
endif
let g:loaded_dracula_custom_colors = 1

function! s:set_dracula_custom() abort
  " Subtler highlight for splits
  hi link VertSplit EndOfBuffer
  " Make inactive windows darker
  hi link NormalNC Pmenu
  " tree-sitter
  hi link TSParameter DraculaOrangeItalic
  hi link TSVariableBuiltin DraculaPurpleItalic
  hi link TSOperator DraculaPink
  hi link TSFuncBuiltin DraculaCyan
  " tbastos/vim-lua
  hi link luaFuncKeyword DraculaPink
  hi link luaFuncCall DraculaGreen
  hi link luaFuncArgName DraculaOrangeItalic
  hi link luaSpecialValue DraculaCyan
  hi link luaSpecialTable DraculaPurple
  hi link luaBuiltIn DraculaPurpleItalic
  hi link luaLocal DraculaPink
  " pangloss/vim-javascript
  hi link jsFuncArgs DraculaOrangeItalic
  hi link jsThis DraculaPurpleItalic
  " HerringtonDarkholme/yats.vim
  hi link typescriptDOMDocMethod DraculaCyan
  hi link typescriptDOMNodeMethod DraculaCyan
  hi link typescriptDOMEventMethod DraculaCyan
  hi link typescriptDOMEventTargetMethod DraculaCyan
  hi link typescriptDOMFormMethod DraculaCyan
  hi link typescriptDOMStorageMethod DraculaCyan
  " vim-python/python-syntax
  hi link pythonBuiltinFunc DraculaCyan
endfunction

augroup set_dracula_custom
  autocmd!
  autocmd ColorScheme dracula call s:set_dracula_custom()
augroup END

if g:colors_name == 'dracula'
  call s:set_dracula_custom()
endif
