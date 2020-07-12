local M = {}

local api = vim.api

-- Taken from https://github.com/neovim/neovim/issues/9718#issuecomment-559573308
function M.fzf_floatwin()
    local width = math.min(vim.o.columns - 4, math.max(80, vim.o.columns - 20))
    local height = math.min(vim.o.lines - 4, math.max(20, vim.o.lines - 10))
    local row = ((vim.o.lines - height) / 2) - 1
    local col = (vim.o.columns - width) / 2
    local opts = {relative = 'editor', row = row, col = col, width = width, height = height, style = 'minimal'}

    local top = '╭'..string.rep('─', width - 2)..'╮'
    local mid = '│'..string.rep(' ', width - 2)..'│'
    local bot = '╰'..string.rep('─', width - 2)..'╯'
    local lines = {}
    table.insert(lines, top)
    for _ = 1, (height - 2) do table.insert(lines, mid) end
    table.insert(lines, bot)
    local buf = api.nvim_create_buf(false, true)
    api.nvim_buf_set_lines(buf, 0, -1, true, lines)
    api.nvim_open_win(buf, true, opts)
    vim.wo.winhl = 'Normal:Floating'
    opts.row = opts.row + 1
    opts.height = opts.height - 2
    opts.col = opts.col + 2
    opts.width = opts.width - 4
    api.nvim_open_win(api.nvim_create_buf(false, true), true, opts)
    vim.cmd('autocmd BufWipeout <buffer> bwipeout '..buf)
end

vim.g.fzf_layout = {window = 'lua require"my.config.plugins.fzf".fzf_floatwin()'}
vim.g.fzf_buffers_jump = 1

local mappings = {
    {'n', '<Space>', '<Cmd>Buffers<CR>'},
    {'n', '<leader>sf', '<Cmd>Files<CR>'},

    -- Quickly search through my config files
    {'n', '<leader>sc', '<Cmd>Files '..vim.fn.stdpath('config')..'<CR>'},

    -- Search through my personal wiki
    {'n', '<leader>sw', '<Cmd>Files '..vim.g.wiki_root..'<CR>'},

    -- Use Rg on the word under my cursor
    {'n', '<leader>rw', ':<C-u>Rg <C-r><C-w><CR>'},
}

require'my.utils'.setup_keymaps(mappings)

return M
