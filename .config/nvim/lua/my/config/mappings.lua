local map = require('my.utils').map

vim.g.mapleader = 'ù'
vim.g.maplocalleader = 'à'

-- Better shortcut to exit insert mode
map.i.jk = {'<Esc>'}

-- Better shortcut to exit insert mode in the terminal
map.t['<Leader>jk'] = {[[<C-\><C-n>]], 'noremap'}

-- Make Y more consistent with other commands
map[''].Y = {'y$'}

-- Copy to/paste from system clipboard more easily
map['']['<Leader>y'] = {'"+y'}
map['']['<Leader>Y'] = {'"+Y'}
map['']['<Leader>p'] = {'"+p'}
map['']['<Leader>P'] = {'"+P'}

-- Ex-mode be gone
map[''].Q = {''}

-- Make <C-u> and <C-w> undoable
map.i['<C-u>'] = {'<C-g>u<C-u>', 'noremap'}
map.i['<C-w>'] = {'<C-g>u<C-w>', 'noremap'}

-- URL handling
map[''].gx = {'<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>'}

-- Quickly edit my Neovim configuration
map.n['<Leader>rc'] = {'<Cmd>tabedit $MYVIMRC<CR>', 'noremap'}

-- Turn off hlsearch quickly
map.n['<C-l>'] = {'<Cmd>nohlsearch<CR><C-l>', 'noremap'}

-- Navigate wrapping lines more easily
map[''].j = {"(v:count? 'j' : 'gj')", 'noremap', 'expr'}
map[''].k = {"(v:count? 'k' : 'gk')", 'noremap', 'expr'}

-- Quickly open a terminal in a different window/tab
map.n['<Leader>ts'] = {'<Cmd>new +term<CR>', 'noremap'}
map.n['<Leader>tv'] = {'<Cmd>vnew +term<CR>', 'noremap'}
map.n['<Leader>tt'] = {'<Cmd>tabedit +term<CR>', 'noremap'}

-- Expand current window to take the entire screen
map.n['<C-w>e'] = {'<Cmd>wincmd _ | wincmd |<CR>', 'noremap'}

-- Text object: "around document" (whole file)
map.o.ad = {'<Cmd>normal! ggVG<CR>', 'noremap'}
map.x.ad = {'gg0oG$', 'noremap'}

-- Run code quickly
map.n['<Leader>rr'] = {'<Cmd>RunCode<CR>', 'noremap'}
map.n['<Leader>rl'] = {'<Cmd>.RunCode<CR>', 'noremap'}
map.v['<leader>r'] = {[[:RunCode<CR>]], 'noremap'}
