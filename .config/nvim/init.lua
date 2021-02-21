vim.g.polyglot_disabled = {'sensible', 'sleuth'}
vim.g.javascript_plugin_jsdoc = 1
vim.cmd [[packadd! vim-polyglot]]
vim.cmd [[runtime! ftdetect/polyglot.vim]]
-- require'profiler'
require'my.utils'
require'my.statusline'
require'my.config.options'
require'my.config.mappings'
require'my.config.extra-text-objects'
require'my.config.packages'
require'my.config.autocommands'
