if exists('g:loaded_dracula_custom_colors')
  finish
endif
let g:loaded_dracula_custom_colors = 1

function! s:set_dracula_custom() abort
  " Make inactive windows darker
  hi! link NormalNC Pmenu
  " HerringtonDarkholme/yats.vim
  hi! link typescriptArrayMethod          DraculaCyan
  hi! link typescriptArrayStaticMethod    DraculaCyan
  hi! link typescriptBOM                  Type
  hi! link typescriptBOMLocationMethod    DraculaCyan
  hi! link typescriptBOMWindowMethod      DraculaCyan
  hi! link typescriptCacheMethod          DraculaCyan
  hi! link typescriptClassHeritage        DraculaCyanItalic
  hi! link typescriptClassName            DraculaCyan
  hi! link typescriptDOMDocMethod         DraculaCyan
  hi! link typescriptDOMDocProp           Constant
  hi! link typescriptDOMEventProp         Constant
  hi! link typescriptDOMEventMethod       DraculaCyan
  hi! link typescriptDOMEventTargetMethod DraculaCyan
  hi! link typescriptDOMFormMethod        DraculaCyan
  hi! link typescriptDOMNodeMethod        DraculaCyan
  hi! link typescriptDOMStorageMethod     DraculaCyan
  hi! link typescriptFunctionMethod       DraculaCyan
  hi! link typescriptHeadersMethod        DraculaCyan
  hi! link typescriptMathStaticMethod     DraculaCyan
  hi! link typescriptNodeGlobal           Constant
  hi! link typescriptObjectMethod         DraculaCyan
  hi! link typescriptObjectStaticMethod   DraculaCyan
  hi! link typescriptPromiseMethod        DraculaCyan
  hi! link typescriptStringMethod         DraculaCyan
  " vim-python/python-syntax
  hi! link pythonBuiltinFunc DraculaCyan
  " tbastos/vim-lua
  hi! link luaFuncKeyword DraculaPink
  " vim/vim.vim
  hi! link vimFuncName DraculaCyan
  hi! link vimFuncVar  DraculaOrangeItalic
  hi! link vimNotation Constant
endfunction

augroup set_dracula_custom
  autocmd!
  autocmd ColorScheme dracula call s:set_dracula_custom()
augroup END

if get(g:, 'colors_name') ==# 'dracula'
  call s:set_dracula_custom()
endif
