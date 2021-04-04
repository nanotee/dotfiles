vim.api.nvim_exec([[
packadd nvim-treesitter
packadd playground
]], false)

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
    playground = {
        enable = true,
        updatetime = 25,
    },
}
