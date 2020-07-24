local M = {}

function M.init()
    vim.cmd 'packadd vim-packager'
    vim.fn['packager#init']()

    local packages = {
        {'kristijanhusak/vim-packager', {type = 'opt'}},
        {'neovim/nvim-lsp', {type = 'opt'}},
        {'nvim-lua/completion-nvim', {type = 'opt'}},
        {'norcalli/snippets.nvim', {type = 'opt'}},
        {'nvim-lua/diagnostic-nvim', {type = 'opt'}},
        {'nvim-treesitter/nvim-treesitter', {type = 'opt'}},
        {'neoclide/coc.nvim', {branch = 'release', type = 'opt'}},
        {'neomake/neomake', {type = 'opt'}},
        {'junegunn/fzf.vim'},
        {'liuchengxu/vista.vim'},
        {'lervag/wiki.vim', {type = 'opt'}},
        {'bfredl/nvim-incnormal'},
        {'tpope/vim-unimpaired'},
        {'tpope/vim-fugitive'},
        {'tpope/vim-eunuch'},
        {'tpope/vim-abolish'},
        {'tpope/vim-dadbod'},
        {'kristijanhusak/vim-dadbod-ui'},
        {'kristijanhusak/vim-dadbod-completion'},
        {'mattn/emmet-vim'},
        {'tomtom/tcomment_vim'},
        {'machakann/vim-sandwich'},
        {'tmsvg/pear-tree'},
        {'editorconfig/editorconfig-vim'},
        {'ptzz/lf.vim'},
        {'rbgrouleff/bclose.vim'},
        {'norcalli/nvim-colorizer.lua'},
        {'dracula/vim', {name = 'dracula'}},
        {'KabbAmine/vCoolor.vim', {type = 'opt'}},

        -- Filetype plugins
        {'sheerun/vim-polyglot'},
        {'bakpakin/fennel.vim'},
        {'Konfekt/vim-compilers'},
    }

    for _, pack in ipairs(packages) do
        vim.fn['packager#add'](unpack(pack))
    end

    return {
        install = vim.fn['packager#install'],
        update = vim.fn['packager#update'],
        clean = vim.fn['packager#clean'],
        status = vim.fn['packager#status'],
    }
end

vim.cmd [[command! PackagerInstall lua require'my.config.packages'.init().install()]]
vim.cmd [[command! -bang PackagerUpdate lua require'my.config.packages'.init().update({ force_hooks = '<bang>' })]]
vim.cmd [[command! PackagerClean lua require'my.config.packages'.init().clean()]]
vim.cmd [[command! PackagerStatus lua require'my.config.packages'.init().status()]]

return M
