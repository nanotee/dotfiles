local colors = {
    bg = '#282A36',
    fg = '#F8F8F2',
    sel = '#44475A',
    comment = '#6272A4',
    red = '#FF5555',
    orange = '#FFB86C',
    yellow = '#F1FA8C',
    green = '#50FA7B',
    purple = '#BD93F9',
    cyan = '#8BE9FD',
    pink = '#FF79C6',
}

local hi_groups = {
    ['SLNormalMode'] = {guifg = colors.bg, guibg = colors.purple},
    ['SLVisualMode'] = {guifg = colors.bg, guibg = colors.yellow},
    ['SLInsertMode'] = {guifg = colors.bg, guibg = colors.green},
    ['SLReplaceMode'] = {guifg = colors.bg, guibg = colors.orange},
    ['SLCommandLineMode'] = {guifg = colors.bg, guibg = colors.purple},
    ['SLSecondary'] = {guifg = colors.fg, guibg = colors.comment},
    ['SLNormal'] = {guifg = colors.fg, guibg = colors.sel}
}

for name, color in pairs(hi_groups) do
    vim.cmd(('hi def %s gui=NONE guifg=%s guibg=%s'):format(name, color.guifg, color.guibg))
end
