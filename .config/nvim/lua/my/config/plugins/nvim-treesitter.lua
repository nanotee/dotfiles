vim.api.nvim_exec([[
packadd nvim-treesitter
packadd nvim-treesitter-refactor
packadd nvim-treesitter-textobjects
packadd playground
packadd nvim-treesitter-context
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
    refactor = {
        highlight_definitions = {
            enable = true,
        },
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner',
            },
        },
    },
    playground = {
        enable = true,
        updatetime = 25,
    },
}
