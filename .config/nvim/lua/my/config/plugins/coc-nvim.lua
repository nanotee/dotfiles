vim.cmd 'packadd coc.nvim'

local M = {}

vim.g.coc_snippet_next = '<Tab>'

vim.g.coc_global_extensions = {
    'coc-html',
    'coc-css',
    'coc-emmet',
    'coc-tsserver',
    'coc-json',
    'coc-phpls',
    'coc-snippets',
}

local mappings = {
    -- Remap keys for gotos
    {'n', '<leader>gd', '<Plug>(coc-definition)', {noremap = false}},
    {'n', '<leader>gy', '<Plug>(coc-type-definition)', {noremap = false}},
    {'n', '<leader>gi', '<Plug>(coc-implementation)', {noremap = false}},
    {'n', '<leader>gr', '<Plug>(coc-references)', {noremap = false}},

    -- Remap for rename current word
    {'n', '<leader>rn', '<Plug>(coc-rename)', {noremap = false}},

    -- Use K to show documentation in preview window
    {'n', 'K', "<Cmd>lua require'my.config.plugins.coc-nvim'.show_documentation()<CR>"},

    -- Tab completion
    {'i', '<Tab>',
        [[pumvisible() ? coc#_select_confirm() :]] ..
        [[coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :]] ..
        [[v:lua.check_back_space() ? "\<TAB>" :]] ..
        [[coc#refresh()]],
        {expr = true, silent = true, noremap = true}
    },
}

require'my.utils'.setup_keymaps(mappings)

function M.show_documentation()
    if vim.fn.index({'vim','help'}, vim.bo.filetype) >= 0 then
        vim.cmd('h ' .. vim.fn.expand('<cword>'))
    else
        vim.fn.CocAction('doHover')
    end
end

function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

return M
