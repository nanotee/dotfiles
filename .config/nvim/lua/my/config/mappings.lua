local map = require('my.utils').map

vim.g.mapleader = 'ù'
vim.g.maplocalleader = 'à'

map.i.jk = {'<Esc>'}

-- Make Y more consistent with other commands
map[''].Y = {'y$'}

-- Ex-mode be gone
map[''].Q = {''}

-- Make <C-u> and <C-w> undoable
map.i['<C-u>'] = {'<C-g>u<C-u>', 'noremap'}
map.i['<C-w>'] = {'<C-g>u<C-w>', 'noremap'}

map[''].gx = {'<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>'}

map.n['<Leader>rc'] = {'<Cmd>tabedit $MYVIMRC<CR>', 'noremap'}

-- Adapted from vim-sensible
map.n['<C-l>'] = {'<Cmd>nohlsearch<CR><Cmd>diffupdate<CR><C-l>', 'noremap'}

-- Navigate wrapping lines more easily
map[''].j = {"(v:count? 'j' : 'gj')", 'noremap', 'expr'}
map[''].k = {"(v:count? 'k' : 'gk')", 'noremap', 'expr'}

-- Expand current window to take the entire screen
map.n['<C-w>e'] = {'<Cmd>wincmd _ | wincmd |<CR>', 'noremap'}

-- Text object: "around document" (whole file)
map.o.ad = {'<Cmd>normal! ggVG<CR>', 'noremap'}
map.x.ad = {'gg0oG$', 'noremap'}

map.n['<Leader>rr'] = {'<Cmd>RunCode<CR>', 'noremap'}
map.n['<Leader>rl'] = {'<Cmd>.RunCode<CR>', 'noremap'}
map.v['<leader>r'] = {[[:RunCode<CR>]], 'noremap'}
