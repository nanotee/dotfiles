let $MYVIMRC = stdpath('config') .. '/init.lua'
packadd! profiler.nvim
lua require('profiler')
luafile $MYVIMRC
packadd! vim-polyglot
let g:polyglot_disabled = ['sensible']
runtime! ftdetect/polyglot.vim
