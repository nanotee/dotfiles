local api = vim.api

local ScratchPad = {}

local list = {}

local function create(mods, range, line1, line2, filetype)
    local refname = vim.fn.tempname()
    list[refname] = ScratchPad:new(mods, range, line1, line2, filetype, refname):create_buf():open_win()
end

function ScratchPad:new(mods, range, line1, line2, filetype, refname)
    local o = {}
    o.mods = mods
    o.range = range
    o.line1 = line1
    o.line2 = line2
    o.refname = refname
    o.namespace = api.nvim_create_namespace('scratch_pad')
    o.original_bufnr = api.nvim_get_current_buf()
    o.filetype = filetype
    if o.filetype == '' then
        o.filetype = vim.bo[o.original_bufnr].filetype
    end
    if o.range ~= 0 then
        o.mark_start = api.nvim_buf_set_extmark(o.original_bufnr, o.namespace, o.line1, 0, {})
        o.mark_end = api.nvim_buf_set_extmark(o.original_bufnr, o.namespace, o.line2, 0, {})
    end
    self.__index = self
    return setmetatable(o, self)
end

function ScratchPad:create_buf()
    self.bufnr = api.nvim_create_buf(false, false)
    vim.bo[self.bufnr].filetype = self.filetype
    vim.bo[self.bufnr].buftype = 'nofile'
    vim.bo[self.bufnr].bufhidden = 'hide'
    vim.bo[self.bufnr].swapfile = false
    if self.range ~= 0 then
        local lines_to_copy = api.nvim_buf_get_lines(self.original_bufnr, self.line1 - 1, self.line2, false)
        api.nvim_buf_set_lines(self.bufnr, 0, 1, false, lines_to_copy)
        -- TODO: This would be better if I could create commands and autocommands in Lua directly...
        api.nvim_buf_call(self.bufnr, function()
            vim.cmd('command! -buffer SendBack lua require"my.utils.scratch".list["' .. self.refname .. '"]:send_back()')
            vim.cmd('autocmd BufDelete <buffer> lua require"my.utils.scratch".list["' .. self.refname .. '"] = nil')
        end)
    end
    return self
end

function ScratchPad:open_win()
    vim.cmd(('%s split'):format(self.mods))
    api.nvim_win_set_buf(0, self.bufnr)
    return self
end

function ScratchPad:send_back()
    if vim.bo[self.original_bufnr].buflisted == 0 then
        api.nvim_err_writeln('The original buffer was closed')
        return
    end

    local text_to_send = api.nvim_buf_get_lines(self.bufnr, 0, -1, false)

    local line1 =
        api.nvim_buf_get_extmark_by_id(self.original_bufnr, self.namespace, self.mark_start, {})[1]
    local line2 =
        api.nvim_buf_get_extmark_by_id(self.original_bufnr, self.namespace, self.mark_end, {})[1]

    api.nvim_buf_set_lines(self.original_bufnr, line1 - 1, line2, true, text_to_send)

    api.nvim_buf_del_extmark(self.original_bufnr, self.namespace, self.mark_start)
    api.nvim_buf_del_extmark(self.original_bufnr, self.namespace, self.mark_end)

    self.mark_start =
        api.nvim_buf_set_extmark(self.original_bufnr, self.namespace, line1, 0, {id = self.mark_start})
    self.mark_end =
        api.nvim_buf_set_extmark(self.original_bufnr, self.namespace, line1 + #text_to_send - 1, 0, {id = self.mark_end})
end

return {
    ScratchPad = ScratchPad,
    create = create,
    list = list,
}
