vim.cmd 'packadd snippets.nvim'
vim.cmd 'autocmd VimEnter * lua require"my.config.plugins.snippets-nvim".init()'

local M = {}

function M.init()
    require'my.utils'.setup_keymaps{
        {
            'i',
            '<C-A-k>',
            "<Cmd>lua return require'snippets'.expand_at_cursor() or require'snippets'.advance_snippet(1)<CR>",
        },
    }
    require'snippets'.snippets = {
        lua = {
            ["for"] = "for ${1:i}, ${2:v} in ipairs(${3:t}) do\n$0\nend",
        },
    }
end

return M
