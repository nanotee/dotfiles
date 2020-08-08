vim.g.mapleader = ','

local mappings = {
    -- Better shortcut to exit insert mode
    {'i', 'jk', '<Esc>', {noremap = false}},

    -- Better shortcut to exit insert mode in the terminal
    {'t', '<leader>jk', [[<C-\><C-n>]]},

    -- Make Y more consistent with other commands
    {'', 'Y', 'y$', {noremap = false}},

    -- Copy to/paste from system clipboard more easily
    {'', '<leader>y', '"+y', {noremap = false}},
    {'', '<leader>Y', '"+Y', {noremap = false}},
    {'', '<leader>p', '"+p', {noremap = false}},
    {'', '<leader>P', '"+P', {noremap = false}},

    -- Keep */# from automatically jumping to the next result
    {'n', '*', [[<Cmd>call setreg('/', expand('<cword>'))<CR><Cmd>set hlsearch<CR>]]},
    {'n', '#', '#<C-o>'},

    -- Visual Mode */# from Scrooloose
    {'x', '*', [[:<C-u>lua require'my.utils'.VSetSearch()<CR>//<CR><C-o>]]},
    {'x', '#', [[:<C-u>lua require'my.utils'.VSetSearch()<CR>??<CR><C-o>]]},

    -- Make <C-u> and <C-w> undoable
    {'i', '<C-u>', '<C-g>u<C-u>'},
    {'i', '<C-w>', '<C-g>u<C-w>'},

    -- URL handling
    {'', 'gx', '<Cmd>call jobstart(["xdg-open", expand("<cfile>")])<CR>', {noremap = false}},

    -- Quickly edit my Neovim configuration
    {'n', '<leader>rc', '<Cmd>tabedit $MYVIMRC<CR>'},

    -- Turn off hlsearch quickly
    {'n', '<leader><Space>', '<Cmd>let v:hlsearch=!v:hlsearch<CR>'},

    -- Navigate wrapping lines more easily
    {'', 'j', "(v:count? 'j' : 'gj')", {noremap = true, expr = true}},
    {'', 'k', "(v:count? 'k' : 'gk')", {noremap = true, expr = true}},

    -- Quickly open a terminal in a different window/tab
    {'n', '<leader>ts', '<Cmd>split term://$SHELL<CR>'},
    {'n', '<leader>tv', '<Cmd>vsplit term://$SHELL<CR>'},
    {'n', '<leader>tt', '<Cmd>tabedit term://$SHELL<CR>'},

    -- Open zeal doc for current word
    {'n', '<leader>zl', [[<Cmd>call jobstart(['zeal', &filetype..':'..expand('<cword>')], {'detach': v:true})<CR>]]},

    -- Expand current window to take the entire screen
    {'n', '<C-w>e', '<Cmd>wincmd _ | wincmd |<CR>'},
    {'n', '<C-w><C-e>', '<Cmd>wincmd _ | wincmd |<CR>'},

    -- Text object: "around document" (whole file)
    {'o', 'ad', '<Cmd>normal! ggVG<CR>'},
    {'x', 'ad', 'ggo0G$'},

    -- Run code quickly
    {'n', '<leader>rr', '<Cmd>Run<CR>'},
    {'n', '<leader>rl', '<Cmd>.Run<CR>'},
}

require'my.utils'.setup_keymaps(mappings)
