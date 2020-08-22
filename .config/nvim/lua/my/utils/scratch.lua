local M = {}

local fn = vim.fn

function M.open(mods, range, line1, line2, filetype)
    local ns = vim.api.nvim_create_namespace('scratch_buffer')
    local mark_start, mark_end

    local original_bufnr = fn.bufnr()
    local tempname = fn.tempname()
    local range_of_lines = {}
    if range ~= 0 then
        mark_start = vim.api.nvim_buf_set_extmark(original_bufnr, ns, 0, line1, 0, {})
        mark_end = vim.api.nvim_buf_set_extmark(original_bufnr, ns, 0, line2, 0, {})
        range_of_lines = fn.getline(line1, line2)
    end
    local scratch_ft = vim.bo.filetype
    if filetype ~= '' then scratch_ft = filetype end

    vim.cmd(mods..' new '..tempname)

    if range ~= 0 then
        vim.b.original_bufnr = original_bufnr
        vim.b.original_mark_start = mark_start
        vim.b.original_mark_end = mark_end
        vim.b.original_ns = ns
        -- Send the code in the scratch buffer back to its original buffer
        vim.cmd 'command! -buffer SendBack lua require"my.utils.scratch".send_back()'
    end

    vim.bo.filetype = scratch_ft
    vim.bo.buftype = 'nofile'
    vim.bo.bufhidden = 'hide'
    vim.bo.swapfile = false

    fn.setline(1, range_of_lines)
end

function M.send_back()
    if fn.buflisted(vim.b.original_bufnr) == 0 then
        print('The original buffer was closed')
        return
    end

    local text_to_send = fn.getline(1, fn.line('$'))

    local line1 = vim.api.nvim_buf_get_extmark_by_id(
        vim.b.original_bufnr,
        vim.b.original_ns,
        vim.b.original_mark_start
        )[1]
    local line2 = vim.api.nvim_buf_get_extmark_by_id(
        vim.b.original_bufnr,
        vim.b.original_ns,
        vim.b.original_mark_end
        )[1]

    vim.api.nvim_buf_set_lines(
        vim.b.original_bufnr,
        line1 - 1,
        line2,
        true,
        text_to_send
        )

    vim.b.original_mark_start = vim.api.nvim_buf_set_extmark(
        vim.b.original_bufnr,
        vim.b.original_ns,
        vim.b.original_mark_start,
        line1,
        0,
        {}
        )

    vim.b.original_mark_end = vim.api.nvim_buf_set_extmark(
        vim.b.original_bufnr,
        vim.b.original_ns,
        vim.b.original_mark_end,
        line1 + #text_to_send - 1,
        0,
        {}
        )
end

return M
