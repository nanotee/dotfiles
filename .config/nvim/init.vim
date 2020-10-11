let $MYVIMRC = stdpath('config') .. '/init.lua'
luafile $MYVIMRC
packadd! vim-polyglot
runtime! ftdetect/polyglot.vim
