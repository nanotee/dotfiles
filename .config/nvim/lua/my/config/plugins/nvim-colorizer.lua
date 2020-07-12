vim.cmd "autocmd BufReadPre * lua require'my.config.plugins.nvim-colorizer'.init()"

local M = {}

function M.init()
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
end

return M
