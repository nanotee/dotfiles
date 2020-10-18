let $MYVIMRC = stdpath('config') .. '/init.lua'
packadd! profiler.nvim
lua require('profiler')
luafile $MYVIMRC
packadd! vim-polyglot
runtime! ftdetect/polyglot.vim
