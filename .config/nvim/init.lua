vim.g.polyglot_disabled = {'sensible', 'autoindent'}
vim.g.javascript_plugin_jsdoc = 1
require'my.utils'
require'my.config.options'
require'my.config.mappings'
require'my.config.extra-text-objects'
require'my.config.packages'
require'my.config.lsp'.init()

local log_levels = {
    [0] = 'trace',
    [1] = 'debug',
    [2] = 'info',
    [3] = 'warn',
    [4] = 'error',
}

function vim.notify(msg, log_level, opts)
    vim.fn.jobstart{
        'notify-send',
        '--icon', 'nvim',
        '--category', ('x-neovim.log.%s'):format(log_levels[log_level] or 'trace'),
        msg
    }
end
