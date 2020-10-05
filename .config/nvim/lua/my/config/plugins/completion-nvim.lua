vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
vim.g.completion_enable_auto_paren = 1
vim.g.completion_confirm_key = ''
vim.g.completion_enable_snippet = 'snippets.nvim'

vim.g.completion_chain_complete_list = {
    default = {
        default = {
            {complete_items = {'lsp', 'snippet'}},
            {mode = '<c-n>'},
            {mode = '<c-p>'},
        },
        ['string'] = {
            {complete_items = {'path'}},
        },
        vim = {
            {mode = 'cmd'},
        },
        sql = {
            {complete_items = {'vim-dadbod-completion'}},
        },
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
        [[complete_info()["selected"] != "-1" ?]]..
        [["\<Plug>(completion_confirm_completion)" : v:lua.check_back_space() ?]]..
        [["\<Tab>" : completion#trigger_completion()]],
        {expr = true, silent = true}
    },
}

require'my.utils'.setup_keymaps(mappings)

local autocmds = {
    completion_nvim = {
        -- Use completion-nvim in every buffer
        {'BufEnter', '*', "lua require'completion'.on_attach()"},
    }
}

require'my.utils'.nvim_create_augroups(autocmds)
