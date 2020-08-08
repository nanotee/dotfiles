vim.cmd 'packadd nvim-treesitter'

require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<C-A-k>',
            node_incremental = '<C-A-k>',
            node_decremental = '<C-A-j>',
        },
    },
    refactor = {
        highlight_definitions = {
            enable = true,
        },
    },
    textobjects = {
        enable = true,
        keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
        },
    },
}

local autocmds = {
    nvim_treesitter = {
        {'VimEnter', '*', 'TSEnableAll highlight'},
        {'VimEnter', '*', 'TSEnableAll incremental_selection'},
        {'VimEnter', '*', 'TSEnableAll refactor.highlight_definitions'},
        {'VimEnter', '*', 'TSEnableAll textobjects'},
    }
}

require'my.utils'.nvim_create_augroups(autocmds)
