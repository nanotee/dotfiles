local packer = require('packer')

packer.init {
    max_jobs = 10,
}

packer.startup(function(use)
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
            }
        end,
    }
    use {
        'neovim/nvim-lspconfig',
        requires = {
            'kosayoda/nvim-lightbulb',
            {'ojroques/nvim-lspfuzzy', config = 'require"lspfuzzy".setup{}'},
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
                    nvim_lua = true,
                    vsnip = true,
                },
            }
        end,
        event = 'InsertEnter *',
    }
    use {
        'hrsh7th/vim-vsnip',
        config = function()
            local map = require'my.utils'.map

            map.i['<Tab>'] = {[[vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : compe#confirm("\<Tab>")]], 'expr'}
            map.i['<S-Tab>'] = {[[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']], 'expr'}
            map.s['<Tab>'] = {[[vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']], 'expr'}
            map.s['<S-Tab>'] = {[[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']], 'expr'}

            vim.g.vsnip_snippet_dir = vim.fn.stdpath('config') .. '/snippets'
            vim.g.vsnip_snippet_dirs = {vim.fn.stdpath('data') .. '/site/pack/packer/start/friendly-snippets/snippets'}
        end,
        requires = 'rafamadriz/friendly-snippets',
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        -- cond = 'not vim.g.minimal_config',
        opt = true,
        config = 'require("my.config.plugins.nvim-treesitter")',
        requires = {'nvim-treesitter/playground', opt = true},
    }
    use {
        'mfussenegger/nvim-lint',
        config = function()
            require('lint').linters_by_ft = {
                sh = {'shellcheck'},
                html = {'tidy'},
            }

            vim.api.nvim_exec([[
            augroup nvim_lint
                autocmd!
                autocmd BufReadPost,BufWritePost * lua require('lint').try_lint()
            augroup END
            ]], false)
        end,
    }
    use {
        'junegunn/fzf.vim',
        config = function()
            vim.g.fzf_buffers_jump = 1

            local map = require('my.utils').map

            map.n['<Space>'] = {'<Cmd>Buffers<CR>', 'noremap'}
            map.n['<Leader>sf'] = {'<Cmd>Files<CR>', 'noremap'}

            -- Search through my config files
            map.n['<Leader>sc'] = {'<Cmd>exe "Files" stdpath("config")<CR>', 'noremap'}

            -- Search through my packages
            map.n['<Leader>sp'] = {'<Cmd>exe "Files" stdpath("data") .. "/site"<CR>', 'noremap'}

            -- Search through my personal wiki
            map.n['<Leader>sw'] = {'<Cmd>exe "Files" g:wiki_root<CR>', 'noremap'}

            -- Use Rg on the word under my cursor
            map.n['<Leader>rw'] = {'<Cmd>exe "Rg" expand("<cword>")<CR>', 'noremap'}
        end,
    }
    use 'tjdevries/nlua.nvim'
    use {'nvim-lua/plenary.nvim', opt = true}
    use 'KabbAmine/zeavim.vim'
    use {
        'liuchengxu/vista.vim',
        config = function()
            vim.g.vista_fzf_preview = {'right:50%'}
            vim.g.vista_default_executive = 'nvim_lsp'
        end,
    }
    use {
        'lervag/wiki.vim',
        setup = function()
            vim.g.wiki_root = '~/Documents/wiki'
            vim.g.wiki_filetypes = {'md'}
            vim.g.wiki_link_extension = '.md'
            vim.g.wiki_link_target_type = 'md'
            vim.g.wiki_list_todos = {'TODO', 'DOING', 'DONE'}
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
    use {
        'glacambre/firenvim',
        cond = 'vim.g.started_by_firenvim',
        run = [[:packadd firenvim | call firenvim#install(0, printf('export VIMRUNTIME="%s"', $VIMRUNTIME))]],
        setup = function()
            vim.g.firenvim_config = {
                localSettings = {
                    ['.*'] = {
                        cmdline = 'firenvim',
                        takeover = 'never',
                    }
                }
            }
        end,
        config = function()
            vim.o.laststatus = 0
            vim.bo.filetype = 'markdown'
        end,
    }
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

            local map = require('my.utils').map
            map.n['<Leader>f'] = {'<Cmd>LfPicker %:p:h<CR>', 'noremap'}
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
    use {'tomtom/tcomment_vim', keys = 'gc', cmd = 'TComment'}
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
            require'colorizer'.setup {
                'html',
                'htmldjango',
                'markdown',
                'css',
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
        config = 'vim.g.vcoolor_custom_picker = "kdialog --getcolor"',
        ft = {'html', 'css', 'scss', 'javascript'},
        cmd = 'VCoolor',
    }
    use 'kergoth/vim-hilinks'
    use 'junegunn/vim-easy-align'

    -- My plugins
    use '~/Projets/dev/nvim/zoxide.vim'
    use '~/Projets/dev/nvim/nvim-if-lua-compat'
    use '~/Projets/dev/nvim/sqls.nvim'
end
)

return packer
