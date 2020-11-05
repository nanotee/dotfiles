vim.g.polyglot_disabled = {'sensible'}
vim.g.javascript_plugin_jsdoc = 1
vim.cmd [[packadd! vim-polyglot]]
vim.cmd [[runtime! ftdetect/polyglot.vim]]
require'profiler'
require'my.utils.debug'
require'my.utils'
require'my.statusline'
reload'my.config.options'
reload'my.config.mappings'
require'my.config.extra-text-objects'
require'my.config.packages'
require'my.config.autocommands'
