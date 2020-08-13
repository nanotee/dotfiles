vim.g.fzf_layout = {window = {width = 0.9, height = 0.9}}
vim.g.fzf_buffers_jump = 1

local mappings = {
    {'n', '<Space>', '<Cmd>Buffers<CR>'},
    {'n', '<leader>sf', '<Cmd>Files<CR>'},

    -- Quickly search through my config files
    {'n', '<leader>sc', '<Cmd>Files '..vim.fn.stdpath('config')..'<CR>'},

    -- Search through my personal wiki
    {'n', '<leader>sw', '<Cmd>Files '..vim.g.wiki_root..'<CR>'},

    -- Use Rg on the word under my cursor
    {'n', '<leader>rw', ':<C-u>Rg <C-r><C-w><CR>'},
}

require'my.utils'.setup_keymaps(mappings)
