vim.g.polyglot_disabled = {'sensible', 'autoindent'}
vim.g.javascript_plugin_jsdoc = 1
require'my.utils'
require'my.config.options'
require'my.config.mappings'
require'my.config.extra-text-objects'
require'my.config.packages'
require'my.config.lsp'.init()

function vim.notify(msg, log_level, opts)
    vim.validate{
        msg = {msg, 'string'},
        log_level = {log_level, 'number', true},
        opts = {opts, 'table', true}
    }
    vim.fn.jobstart{
        'notify-send',
        '--icon', 'nvim',
        '--category', ('x-neovim.log.%s'):format(vim.lsp.log_levels[log_level] or vim.lsp.log_levels[0]),
        msg
    }
end
