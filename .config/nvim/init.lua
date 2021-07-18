vim.g.polyglot_disabled = {'sensible', 'autoindent'}
require('my.utils')
require('my.config.options')
require('my.config.mappings')
require('my.config.packages')
require('my.config.lsp')

-- https://www.galago-project.org/specs/notification/0.9/x320.html
local notify_send_urgency_map = {
    [vim.lsp.log_levels.TRACE] = 'low',
    [vim.lsp.log_levels.DEBUG] = 'low',
    [vim.lsp.log_levels.INFO]  = 'normal',
    [vim.lsp.log_levels.WARN]  = 'normal',
    [vim.lsp.log_levels.ERROR] = 'critical',
}

-- https://specifications.freedesktop.org/icon-naming-spec/latest/ar01s04.html
local xdg_icons_map = {
    [vim.lsp.log_levels.TRACE] = 'nvim',
    [vim.lsp.log_levels.DEBUG] = 'nvim',
    [vim.lsp.log_levels.INFO]  = 'dialog-information',
    [vim.lsp.log_levels.WARN]  = 'dialog-warning',
    [vim.lsp.log_levels.ERROR] = 'dialog-error',
}

function vim.notify(msg, log_level, opts)
    log_level = log_level or vim.lsp.log_levels.TRACE
    opts = opts or {}
    local command = {
        'notify-send',
        '--icon', xdg_icons_map[log_level],
        '--urgency', notify_send_urgency_map[log_level],
        '--category', ('x-neovim.notification.%s'):format(vim.lsp.log_levels[log_level]),
        '--hint', 'STRING:desktop-entry:nvim',
    }
    if opts.timeout then
        command[#command+1] = '--expire-time'
        command[#command+1] = opts.timeout
    end

    command[#command+1] = opts.title or 'Neovim'
    command[#command+1] = msg
    vim.fn.jobstart(command)
end
