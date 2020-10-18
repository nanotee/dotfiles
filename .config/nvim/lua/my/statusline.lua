-- Lots of inspiration was taken from these dotfiles:
-- https://github.com/haorenW1025/dotfiles/blob/master/nvim/lua/status-line.lua
-- https://github.com/kyazdani42/dotfiles/blob/master/config/common/nvim/lua/statusline.lua

_G.statusline = {}

local fn, api = vim.fn, vim.api
local o, bo, wo = vim.o, vim.bo, vim.wo
local filter = vim.tbl_filter

local function cat(tbl, sep)
    return table.concat(filter(function(x) return x ~= nil end, tbl), sep)
end

local path = '%f'
local modified_flag = '%m'
local readonly_flag = '%r'
local help_buffer_flag = '%h'
local line_number = '%3l'
local total_lines_in_buffer = '%L'
local column_number = '%3c'
local percentage_through_file = '%3p%%'

local truncate = '%<'
local align = '%='

local modes = {
    ['n']   = {val = ' NORMAL',     color = '%#SLNormalMode#'},
    ['v']   = {val = 'ﭟ VISUAL',     color = '%#SLVisualMode#'},
    ['V']   = {val = 'ﭟ V·LINE',     color = '%#SLVisualMode#'},
    ['\22'] = {val = 'ﭟ V·BLOCK',    color = '%#SLVisualMode#'},
    ['s']   = {val = 'ﭟ SELECT',     color = '%#SLVisualMode#'},
    ['S']   = {val = 'ﭟ S·LINE',     color = '%#SLVisualMode#'},
    ['\19'] = {val = 'ﭟ S·BLOCK',    color = '%#SLVisualMode#'},
    ['i']   = {val = ' INSERT',     color = '%#SLInsertMode#'},
    ['R']   = {val = ' REPLACE',    color = '%#SLReplaceMode#'},
    ['c']   = {val = 'ﲵ COMMAND',    color = '%#SLCommandLineMode#'},
    ['r']   = {val = ' PROMPT',     color = '%#SLCommandLineMode#'},
    ['!']   = {val = ' SHELL',      color = '%#SLCommandLineMode#'},
    ['t']   = {val = ' TERMINAL',   color = '%#SLCommandLineMode#'},
}

local function get_mode_info()
    return modes[fn.mode()] or {val = 'Unknown', color = '%#SLNormalMode#'}
end

local function static_section(color)
    return function(module)
        return ('%s%s'):format(color, module or '')
    end
end

local function dynamic_section(fun)
    return function(module)
        return ('%s%s'):format(fun(), module or '')
    end
end

local function include_on_filetypes(filetypes, fun)
    return function()
        if filetypes[bo.filetype] then
            return fun()
        end
    end
end

local mode_color = dynamic_section(function() return get_mode_info().color end)
local secondary_color = static_section('%#SLSecondary#')
local end_of_buffer = static_section('%#EndOfBuffer#')
local normal_color = static_section('%#SLNormal#')
local modified_color = dynamic_section(function()
    if bo.modified then return '%#NormalNC#' end
    return '%#SLNormal#'
end)

local function mode_module()
    return (' %s '):format(get_mode_info().val)
end

local function spell_module()
    if wo.spell then
        return ' SPELL [%{toupper(&spelllang)}] '
    end
end

local function git_module()
    if vim.g.loaded_fugitive == 1 then
        local branch = fn.FugitiveHead()
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

local filetype_module = ' %{&filetype} '

local fileencoding_module = ' %{&fileencoding}[%{&fileformat}] '

local wordcount_module = include_on_filetypes(
    {
        asciidoc = true,
        help = true,
        mail = true,
        markdown = true,
        org = true,
        rst = true,
        plaintex = true,
        tex = true,
        text = true,
    },
    function()
        return ' %{"[vs]" =~? mode() ? wordcount().visual_words : wordcount().words} words '
    end
    )

local buffer_info_module = (' %s ☰ %s/%s:%s '):format(
    percentage_through_file,
    line_number,
    total_lines_in_buffer,
    column_number
    )

local right_section_separator = ''
local left_section_separator = ''

function _G.statusline.active()
    return cat{
        mode_color(cat({
                    mode_module(),
                    spell_module(),
            }, left_section_separator)),
        secondary_color(git_module()),
        modified_color(cat{
                file_module,
                truncate,
                align,
                filetype_module,
            }),
        secondary_color(fileencoding_module),
        mode_color(cat({
                    wordcount_module(),
                    buffer_info_module,
            }, right_section_separator)),
    }
end

function _G.statusline.inactive()
    return cat{
        normal_color(file_module),
        end_of_buffer(),
    }
end
