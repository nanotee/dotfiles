vim.cmd 'packadd! nvim-colorizer.lua'

require'colorizer'.setup {
    'html',
    'htmldjango',
    'markdown',
    'css',
    'scss',
    'javascript',
    'php',
    'vim',

    css = {
        RGB      = true,
        RRGGBB   = true,
        names    = true,
        RRGGBBAA = true,
        rgb_fn   = true,
        hsl_fn   = true,
        css      = true,
        css_fn   = true,
    }

}
