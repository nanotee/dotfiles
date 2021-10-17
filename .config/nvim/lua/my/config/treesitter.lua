require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<C-A-K>',
            node_incremental = '<C-A-K>',
            node_decremental = '<C-A-J>',
        },
    },
    playground = {
        enable = true,
        updatetime = 25,
    },
    context_commentstring = {
        enable = true,
    },
}
