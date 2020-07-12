vim.cmd 'packadd nvim-treesitter'

require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {},
    },
    incremental_selection = {
        enable = true,
        disable = {},
        keymaps = {
            init_selection = '<C-A-k>',
            node_incremental = '<C-A-k>',
            node_decremental = '<C-A-j>',
            scope_incremental = 'grc',
            scope_decremental = 'grm',
        },
    },
    refactor = {
        highlight_definitions = {
            enable = true
        },
    },
}

local autocmds = {
    nvim_treesitter = {
        {'VimEnter', '*', 'TSEnableAll incremental_selection'},
        {'VimEnter', '*', 'TSEnableAll refactor.highlight_definitions'},
    }
}

require'my.utils'.nvim_create_augroups(autocmds)
