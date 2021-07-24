require('packer').startup{function(use)
    use 'wbthomason/packer.nvim'
    use 'sheerun/vim-polyglot'
    use {'dracula/vim', as = 'dracula'}
    use {
        'hoob3rt/lualine.nvim',
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'dracula',
                    section_separators = {'', ''},
                    component_separators = {'', ''},
                },
                extensions = {'quickfix'},
                sections = {
                    lualine_c = {
                        {'filename', path = 1},
                        {'quickfix'},
                        {'diagnostics', sources = {'nvim_lsp'}},
                    },
                },
            }
        end,
    }
    use {
        'neovim/nvim-lspconfig',
        requires = {
            'kosayoda/nvim-lightbulb',
            {'ojroques/nvim-lspfuzzy', config = 'require("lspfuzzy").setup{}'},
            'ray-x/lsp_signature.nvim',
        }
    }
    use {
        'hrsh7th/nvim-compe',
        config = function()
            require('compe').setup {
                source = {
                    path = true,
                    buffer = true,
                    nvim_lsp = true,
                    vsnip = true,
                },
                preselect = 'always',
            }
        end,
        event = 'InsertEnter *',
    }
    use {
        'hrsh7th/vim-vsnip',
        config = function()
            local map = vim.api.nvim_set_keymap

            map('i', '<Tab>', [[vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : compe#confirm("\<Tab>")]], {expr = true})
            map('i', '<S-Tab>', [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']], {expr = true})
            map('s', '<Tab>', [[vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']], {expr = true})
            map('s', '<S-Tab>', [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']], {expr = true})

            vim.g.vsnip_snippet_dir = vim.fn.stdpath('config') .. '/snippets'
        end,
        requires = 'rafamadriz/friendly-snippets',
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        opt = true,
        config = 'require("my.config.treesitter")',
        requires = {'nvim-treesitter/playground', opt = true},
    }
    use {
        'mfussenegger/nvim-lint',
        config = function()
            require('lint').linters_by_ft = {
                sh = {'shellcheck'},
                html = {'tidy'},
                php = {'psalm'}
            }

            vim.api.nvim_exec([[
            augroup nvim_lint
                autocmd!
                autocmd BufWritePost * lua require('lint').try_lint()
            augroup END
            ]], false)

            vim.cmd("command! -nargs=? Lint lua require('lint').try_lint(<f-args>)")
        end,
    }
    use {
        'junegunn/fzf.vim',
        config = function()
            vim.g.fzf_buffers_jump = 1

            local map = vim.api.nvim_set_keymap

            map('n', '<Space>', '<Cmd>Buffers<CR>', {noremap = true})
            map('n', '<Leader>sf', '<Cmd>Files<CR>', {noremap = true})
            map('n', '<Leader>sc', '<Cmd>exe "Files" stdpath("config")<CR>', {noremap = true})
            map('n', '<Leader>sp', '<Cmd>exe "Files" stdpath("data") .. "/site"<CR>', {noremap = true})
            map('n', '<Leader>sw', '<Cmd>exe "Files" g:wiki_root<CR>', {noremap = true})
            map('n', '<Leader>rw', '<Cmd>exe "Rg" expand("<cword>")<CR>', {noremap = true})
        end,
    }
    use 'nvim-lua/plenary.nvim'
    use 'KabbAmine/zeavim.vim'
    use {
        'lervag/wiki.vim',
        setup = function()
            vim.g.wiki_root = '~/Documents/wiki'
            vim.g.wiki_filetypes = {'md'}
            vim.g.wiki_link_extension = '.md'
            vim.g.wiki_link_target_type = 'md'
            vim.g.wiki_export = {
                args = '--highlight-style=tango --template=eisvogel',
                from_format = 'markdown',
                ext = 'pdf',
                view = true,
                viewer = 'okular',
            }
        end,
        cmd = {
            'WikiEnable',
            'WikiFzfPages',
            'WikiFzfTags',
            'WikiIndex',
            'WikiJournal',
            'WikiOpen',
            'WikiReload',
        },
        event = 'BufReadPre ~/Documents/wiki/*.md',
        keys = '<Leader>w',
    }
    use 'tweekmonster/helpful.vim'
    use {'tpope/vim-unimpaired', keys = {'[', ']', '<', '>', '=', 'y'}}
    use {
        'tpope/vim-fugitive',
        requires = 'tpope/vim-rhubarb',
        config = 'vim.g.fugitive_legacy_commands = 0'
    }
    use 'tpope/vim-eunuch'
    use 'tpope/vim-abolish'
    use 'tpope/vim-dadbod'
    use 'tpope/vim-projectionist'
    use {'tpope/vim-dispatch', requires = 'radenling/vim-dispatch-neovim'}
    use 'kristijanhusak/vim-dadbod-ui'
    use {
        'mroavi/lf.vim',
        config = function()
            vim.g['lf#replace_netrw'] = 1
            vim.g['lf#set_default_mappings'] = 0
            vim.g['lf#action'] = {
                ['<C-t>'] = 'tab split',
                ['<C-x>'] = 'split',
                ['<C-v>'] = 'vsplit',
            }
            vim.g['lf#layout'] = {window = {width = 0.9, height = 0.6}}
            vim.g['lf#command'] = 'lf -command "map e open; map <esc> quit; map <enter> open"'

            local map = vim.api.nvim_set_keymap
            map('n', '<Leader>f', '<Cmd>LfPicker %:p:h<CR>', {noremap = true})
        end,
    }
    use {
        'mattn/emmet-vim',
        config = function()
            vim.g.user_emmet_settings = {
                html = {
                    snippets = {
                        ['html:5'] =
                        '!!!+html[lang=fr]>(head>(meta[charset=${charset}]' ..
                        '+meta[name="viewport" content="width=device-width,initial-scale=1.0"]' ..
                        ' +meta[http-equiv="X-UA-Compatible" content="ie=edge"]title{}<body>{}'
                    }
                }
            }
        end,
    }
    use {
        'tomtom/tcomment_vim',
        config = function()
            vim.g.tcomment_mapleader1 = 0
            vim.g.tcomment_mapleader2 = 0
            vim.g.tcomment_mapleader_uncomment_anyway = 0
            vim.g.tcomment_mapleader_comment_anyway = 0
            vim.g.tcomment_textobject_inlinecomment = 0
        end
    }
    use {'machakann/vim-sandwich', config = 'vim.cmd "runtime macros/sandwich/keymap/surround.vim"'}
    use {
        'tmsvg/pear-tree',
        config = function()
            vim.g.pear_tree_repeatable_expand = 0
            vim.g.pear_tree_smart_backspace = 1
        end,
    }
    use 'editorconfig/editorconfig-vim'
    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup {
                'html',
                'htmldjango',
                'markdown',
                'scss',
                'javascript',
                'php',
                'vim',
                css = {
                    RGB      = true,
                    RRGGBB   = true,
                    names    = true,
                    RRGGBBAA = true,
                    rgb_fn   = true,
                    hsl_fn   = true,
                    css      = true,
                    css_fn   = true,
                },
            }
        end,
    }
    use {
        'KabbAmine/vCoolor.vim',
        config = [[vim.g.vcoolor_custom_picker = "kdialog --title 'vCoolor' --getcolor --default "]],
    }
    use 'kergoth/vim-hilinks'
    use {'mfussenegger/nvim-dap', config = 'require("my.config.dap")', opt = true}
    use 'jbyuki/one-small-step-for-vimkind'
    use 'folke/lua-dev.nvim'

    -- My plugins
    use '~/Projets/dev/nvim/zoxide.vim'
    use '~/Projets/dev/nvim/nvim-if-lua-compat'
    use '~/Projets/dev/nvim/sqls.nvim'
    use '~/Projets/dev/nvim/nvim-lsp-basics'
    use '~/Projets/dev/nvim/luv-vimdocs'
end,
config = {
    max_jobs = 10,
}}
