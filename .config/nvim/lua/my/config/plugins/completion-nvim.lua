local M = {}

vim.cmd 'packadd completion-nvim'
-- vim.cmd 'packadd completion-buffers'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noinsert,noselect'
-- Enable Fuzzy Matching
vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
-- Auto parens when completing methods
vim.g.completion_enable_auto_paren = 1
-- This mapping is necessary to avoid breaking <CR> with Pear-Tree
vim.g.completion_confirm_key = [[<C-space>]]

vim.g.completion_chain_complete_list = {
    default = {
        default = {
            {complete_items = {'lsp', 'snippet', 'buffers'}},
            {mode = '<c-p>'},
            {mode = '<c-n>'},
        },
        ['string'] = {
            {complete_items = {'path', 'buffers'}},
        },
        vim = {
            {mode = 'cmd'},
        },
        sql = {
            {complete_items = {'vim-dadbod-completion'}}
        }
    }
}

function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

local mappings = {
    {'i', '<Tab>',
        "pumvisible() ? '<C-n>' : v:lua.check_back_space() ? '<Tab>' : completion#trigger_completion()",
        {expr = true, silent = true}
    },
    {'i', '<S-Tab>', "pumvisible() ? '<C-p>' : '<C-h>'", {expr = true}},
}

require'my.utils'.setup_keymaps(mappings)

local autocmds = {
    completion_nvim = {
        -- Use completion-nvim in every buffer
        {'BufEnter', '*', "lua require'completion'.on_attach()"},
    }
}

require'my.utils'.nvim_create_augroups(autocmds)

return M
