local cmd = vim.cmd

require('paq') {
    'savq/paq-nvim',
    { 'dracula/vim', as = 'dracula' },
    'nvim-lualine/lualine.nvim',
    'junegunn/fzf.vim',
    'tpope/vim-abolish',
    'tpope/vim-eunuch',
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    'tpope/vim-repeat',
    'tpope/vim-surround',
    'tpope/vim-dispatch',
    'tpope/vim-projectionist',
    'ii14/lsp-command',
    'kosayoda/nvim-lightbulb',
    'neovim/nvim-lspconfig',
    'mroavi/lf.vim',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'tweekmonster/helpful.vim',
    'vim-test/vim-test',
    'mfussenegger/nvim-dap',
    'noahfrederick/vim-composer',
    'lumiliet/vim-twig',
}

cmd.set('runtimepath+=~/Projets/dev/nvim/zoxide.vim')
cmd.set('runtimepath+=~/Projets/dev/nvim/sqls.nvim')
