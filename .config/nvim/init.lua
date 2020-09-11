require'my.utils'
require'my.statusline'
reload'my.config.options'
reload'my.config.mappings'
require'my.config.extra-text-objects'
require'my.config.packages'
require'my.config.autocommands'

-- Plugins
require'my.config.plugins.wiki-vim'
require'my.config.plugins.fzf'
require'my.config.plugins.nvim-colorizer'
require'my.config.plugins.pear-tree'
require'my.config.plugins.vim-sandwich'
require'my.config.plugins.lf'
require'my.config.plugins.vCoolor'
require'my.config.plugins.emmet-vim'
require'my.config.plugins.vista-vim'
require'my.config.plugins.snippets-nvim'
require'my.config.plugins.firenvim'
if not vim.g.minimal_config then
    require'my.config.plugins.completion-nvim'
    require'my.config.plugins.nvim-lsp'.init()
    vim.cmd'autocmd InsertEnter,CmdlineEnter * ++once lua require"my.config.plugins.neomake"'
    -- require'my.config.plugins.nvim-treesitter'
    -- require'my.config.plugins.coc-nvim'
end
