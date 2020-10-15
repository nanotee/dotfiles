-- Lots of inspiration was taken from these dotfiles:
-- https://github.com/haorenW1025/dotfiles/blob/master/nvim/lua/status-line.lua
-- https://github.com/kyazdani42/dotfiles/blob/master/config/common/nvim/lua/statusline.lua

_G.statusline = {}

local cat = table.concat

local path = '%f'
local modified_flag = '%m'
local readonly_flag = '%r'
local help_buffer_flag = '%h'
local line_number = '%3l'
local total_lines_in_buffer = '%L'
local column_number = '%3c'
local percentage_through_file = '%3p%%'

local modes = {
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

local function get_mode_info()
    return modes[vim.api.nvim_get_mode().mode]
end

local function static_section(color)
    return function(module)
        return ('%s%s'):format(color, module or '')
    end
end

local function dynamic_section(fn)
    return function(module)
        return ('%s%s'):format(fn(), module or '')
    end
end

local mode_color = dynamic_section(function() return get_mode_info().color end)
local secondary_color = static_section('%#SLSecondary#')
local end_of_buffer = static_section('%#EndOfBuffer#')
local normal_color = static_section('%#StatusLine#')

local function mode_module()
    return (' %s '):format(get_mode_info().val)
end

local function spell_module()
    if vim.wo.spell then
        return (' SPELL [%s] '):format(vim.o.spelllang)
    end
end

local function git_module()
    if vim.g.loaded_fugitive == 1 then
        local branch = vim.fn.FugitiveHead()
        if branch ~= '' then
            branch = ' ' .. branch
        end
        return (' %s '):format(branch)
    end
end

local file_module = (' %s %s%s%s '):format(
    path,
    modified_flag,
    help_buffer_flag,
    readonly_flag
    )

local buffer_info_module = (' %s  %s/%s:%s '):format(
    percentage_through_file,
    line_number,
    total_lines_in_buffer,
    column_number
    )

function _G.statusline.active()
    return cat{
        mode_color(cat({
                    mode_module(),
                    spell_module(),
            }, '|')),
        secondary_color(git_module()),
        normal_color(cat{
                file_module,
                '%<',
                '%=',
                ' %{&filetype} ',
            }),
        secondary_color(' %{&fileencoding}[%{&fileformat}] '),
        mode_color(buffer_info_module),
    }
end

function _G.statusline.inactive()
    return cat{
        normal_color(file_module),
        end_of_buffer(),
    }
end
