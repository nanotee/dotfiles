require('packer').startup{function(use)
    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'
    use {'dracula/vim', as = 'dracula'}
    use {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'dracula',
                    section_separators = {left = '', right = ''},
                    component_separators = {left = '', right = ''},
                },
                extensions = {'quickfix'},
                sections = {
                    lualine_c = {
                        {'filename', path = 1},
                    },
                },
            }
        end,
    }
    use 'neovim/nvim-lspconfig'
    use 'kosayoda/nvim-lightbulb'
    use {'ojroques/nvim-lspfuzzy', config = 'require("lspfuzzy").setup{}'}
    use {
        'hrsh7th/nvim-cmp',
        config = function()
            local cmp = require('cmp')
            cmp.setup {
                sources = {
                    {name = 'buffer', keyword_length = 3},
                    {name = 'nvim_lsp'},
                    {name = 'luasnip'},
                    {name = 'nvim_lsp_signature_help'},
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({select = true}),
                },
                documentation = {
                    border = 'rounded',
                },
            }
        end,
    }
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'saadparwaiz1/cmp_luasnip'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use {
        'L3MON4D3/LuaSnip',
        config = function()
            require('luasnip.loaders.from_vscode').load()
            local map = vim.keymap.set

            map('i', '<Tab>', [[luasnip#expand_or_jumpable() ? "\<Plug>luasnip-expand-or-jump" : "\<Tab>"]], {expr = true, remap = true})
            map('i', '<S-Tab>', [[<Cmd>lua require('luasnip').jump(-1)<CR>]])
            map('s', '<Tab>', [[<Cmd>lua require('luasnip').jump(1)<CR>]])
            map('s', '<S-Tab>', [[<Cmd>lua require('luasnip').jump(-1)<CR>]])
        end,
    }
    use 'rafamadriz/friendly-snippets'
    use {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('nvim-treesitter.configs').setup {
                highlight = {
                    enable = true,
                },
                playground = {
                    enable = true,
                    updatetime = 25,
                },
                context_commentstring = {
                    enable = true,
                },
            }
        end,
    }
    use 'nvim-treesitter/playground'
    use 'JoosepAlviste/nvim-ts-context-commentstring'
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

            function _G.nvim_linters()
                local result = {}
                for _, file in ipairs(vim.api.nvim_get_runtime_file('lua/lint/linters/*', true)) do
                    local linter = vim.fn.fnamemodify(file, ':t:r')
                    table.insert(result, linter)
                end
                return table.concat(result, '\n')
            end

            vim.cmd("command! -nargs=? -complete=custom,v:lua.nvim_linters Lint lua require('lint').try_lint(<f-args>)")
        end,
    }
    use {
        'junegunn/fzf.vim',
        config = function()
            vim.g.fzf_buffers_jump = 1

            local map = vim.keymap.set

            map('n', '<Space>', '<Cmd>Buffers<CR>')
            map('n', '<Leader>sf', '<Cmd>Files<CR>')
            map('n', '<Leader>sc', '<Cmd>exe "Files" stdpath("config")<CR>')
            map('n', '<Leader>sp', '<Cmd>exe "Files" stdpath("data") .. "/site"<CR>')
            map('n', '<Leader>sw', '<Cmd>exe "Files" g:wiki_root<CR>')
            map('n', '<Leader>rw', '<Cmd>exe "Rg" expand("<cword>")<CR>')
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
    use 'tpope/vim-commentary'
    use {'tpope/vim-unimpaired', keys = {'[', ']', '<', '>', '=', 'y'}}
    use {'tpope/vim-fugitive', config = 'vim.g.fugitive_legacy_commands = 0'}
    use 'tpope/vim-rhubarb'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-abolish'
    use 'tpope/vim-dadbod'
    use 'kristijanhusak/vim-dadbod-ui'
    use 'tpope/vim-projectionist'
    use 'tpope/vim-dispatch'
    use {
        'mroavi/lf.vim',
        config = function()
            vim.g['lf#replace_netrw'] = 1
            vim.g['lf#set_default_mappings'] = 0
            vim.g['lf#action'] = {
                ['<C-T>'] = 'tab split',
                ['<C-X>'] = 'split',
                ['<C-V>'] = 'vsplit',
            }
            vim.g['lf#layout'] = {window = {width = 0.9, height = 0.6}}
            vim.g['lf#command'] = 'lf -command "map e open; map <esc> quit; map <enter> open"'

            local map = vim.keymap.set
            map("n", '<Leader>f', "expand('%') == '' ? '<Cmd>Lp %:p:h<CR>' : '<Cmd>Lp %<CR>'", {expr = true})
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
        'KabbAmine/vCoolor.vim',
        config = [[vim.g.vcoolor_custom_picker = "kdialog --title 'vCoolor' --getcolor --default "]],
    }
    use 'folke/lua-dev.nvim'

    -- Language plugins
    use 'lumiliet/vim-twig'
    use {'plasticboy/vim-markdown', config = 'vim.g.vim_markdown_folding_disabled = 1'}
    use 'zah/nim.vim'
    use 'MTDL9/vim-log-highlighting'

    -- My plugins
    use '~/Projets/dev/nvim/zoxide.vim'
    use '~/Projets/dev/nvim/sqls.nvim'
    use '~/Projets/dev/nvim/nvim-lsp-basics'
    use '~/Projets/dev/nvim/luv-vimdocs'
end,
config = {
    max_jobs = 10,
}}
