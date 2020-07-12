-- Lots of inspiration was taken from these dotfiles:
-- https://github.com/haorenW1025/dotfiles/blob/master/nvim/lua/status-line.lua
-- https://github.com/kyazdani42/dotfiles/blob/master/config/nvim/lua/statusline.lua

_G.statusline = {}

local path = '%f'
local modified_flag = '%m'
local readonly_flag = '%r'
local help_buffer_flag = '%h'
local line_number = '%3l'
local total_lines_in_buffer = '%L'
local column_number = '%3c'
local percentage_through_file = '%3p%%'

local current_mode = {
    ['n']   = {val = ' NORMAL',     color = '%#SLNormalMode#'},
    ['niI'] = {val = ' NORMAL',     color = '%#SLNormalMode#'},
    ['niR'] = {val = ' NORMAL',     color = '%#SLNormalMode#'},
    ['no']  = {val = ' OP·PENDING', color = '%#SLNormalMode#'},
    ['v']   = {val = '麗VISUAL',     color = '%#SLVisualMode#'},
    ['V']   = {val = '麗V·LINE',     color = '%#SLVisualMode#'},
    ['\22'] = {val = '麗V·BLOCK',    color = '%#SLVisualMode#'},
    ['s']   = {val = '麗SELECT',     color = '%#SLVisualMode#'},
    ['S']   = {val = '麗S·LINE',     color = '%#SLVisualMode#'},
    ['\19'] = {val = '麗S·BLOCK',    color = '%#SLVisualMode#'},
    ['i']   = {val = ' INSERT',     color = '%#SLInsertMode#'},
    ['ic']  = {val = ' INSERT',     color = '%#SLInsertMode#'},
    ['ix']  = {val = ' INSERT',     color = '%#SLInsertMode#'},
    ['R']   = {val = ' REPLACE',    color = '%#SLReplaceMode#'},
    ['Rv']  = {val = ' V·REPLACE',  color = '%#SLReplaceMode#'},
    ['c']   = {val = ' COMMAND',    color = '%#SLCommandLineMode#'},
    ['cv']  = {val = 'VIM EX',       color = '%#SLCommandLineMode#'},
    ['ce']  = {val = 'EX',           color = '%#SLCommandLineMode#'},
    ['r']   = {val = 'PROMPT',       color = '%#SLCommandLineMode#'},
    ['rm']  = {val = 'MORE',         color = '%#SLCommandLineMode#'},
    ['r?']  = {val = 'CONFIRM',      color = '%#SLCommandLineMode#'},
    ['!']   = {val = 'SHELL',        color = '%#SLCommandLineMode#'},
    ['t']   = {val = ' TERMINAL',   color = '%#SLCommandLineMode#'},
}

local function mode_indicator()
    local clear_hi = '%#StatusLine#'
    local mode = current_mode[vim.api.nvim_get_mode().mode] or {
        val = vim.api.nvim_get_mode().mode,
        color = clear_hi,
    }
    local color = mode.color
    local val = mode.val

    local spell = ''
    if vim.wo.spell then
        spell = string.format(' | SPELL [%s]', vim.o.spelllang)
    end
    return string.format('%s %s%s %s', color, val, spell, clear_hi)
end

local function git_indicator()
    if vim.g.loaded_fugitive then
        local branch = vim.fn.FugitiveHead()
        if branch ~= '' then
            branch = ' '..branch
        end
        return string.format(
            '%s %s %s',
            '%#SLSecondary#',
            branch,
            '%#StatusLine#'
            )
    else
        return ''
    end
end

local file_indicator = string.format(
    ' %s %s%s%s ',
    path,
    modified_flag,
    help_buffer_flag,
    readonly_flag
)

local filetype = ' %y '

local function fileencoding()
    return string.format(
        '%s %s %s',
        '%#SLSecondary#',
        vim.bo.fileencoding,
        '%#StatusLine#'
        )
end

local function buffer_info_indicator()
    return string.format(
        '%s %s  %s/%s:%s%s',
        current_mode[vim.api.nvim_get_mode()['mode']].color,
        percentage_through_file,
        line_number,
        total_lines_in_buffer,
        column_number,
        '%#StatusLine#'
        )
end

function _G.statusline.active()
    local statusline = {
        mode_indicator(),
        git_indicator(),
        file_indicator,
        '%<',
        '%=',
        filetype,
        fileencoding(),
        buffer_info_indicator(),
    }
    return table.concat(statusline)
end

function _G.statusline.inactive()
    local statusline = {
        '%#StatusLine#',
        file_indicator,
    }
    return table.concat(statusline)
end
