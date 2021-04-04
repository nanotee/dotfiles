local M = {}
local lsp = vim.lsp
local fn = vim.fn
local api = vim.api
local cmd = vim.cmd

local function make_lsp_commands(client)
    local cap = client.resolved_capabilities
    if cap.rename then
        cmd 'command! -buffer -nargs=? LspRename lua vim.lsp.buf.rename(<f-args>)'
    end
    if cap.find_references then
        cmd 'command! -buffer LspReferences lua vim.lsp.buf.references()'
    end
    if cap.document_formatting then
        cmd 'command! -buffer -bang LspFormat lua require"my.utils.lsp".format_command("<bang>" == "!")'
    end
    if cap.document_range_formatting then
        cmd 'command! -buffer -range=% LspFormatRange lua require"my.utils.lsp".range_format_command(<line1>, <line2>)'
    end
    if cap.workspace_symbol then
        cmd 'command! -buffer -nargs=? LspWorkspaceSymbol lua vim.lsp.buf.workspace_symbol(<f-args>)'
    end
    if cap.call_hierarchy then
        cmd 'command! -buffer LspIncomingCalls lua vim.lsp.buf.incoming_calls()'
        cmd 'command! -buffer LspOutgoingCalls lua vim.lsp.buf.outgoing_calls()'
    end
    if cap.workspace_folder_properties.supported then
        cmd 'command! -buffer LspListWorkspaceFolders lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))'
        cmd 'command! -buffer -nargs=? -complete=dir LspAddWorkspaceFolder lua vim.lsp.buf.add_workspace_folder(<f-args>)'
        cmd 'command! -buffer -nargs=? -complete=dir LspRemoveWorkspaceFolder lua vim.lsp.buf.remove_workspace_folder(<f-args>)'
    end
    if cap.document_symbol then
        cmd 'command! -buffer LspDocumentSymbol lua vim.lsp.buf.document_symbol()'
    end
    if cap.goto_definition then
        cmd 'command! -buffer LspDefinition lua vim.lsp.buf.definition()'
    end
    if cap.type_definition then
        cmd 'command! -buffer LspTypeDefinition lua vim.lsp.buf.type_definition()'
    end
    if cap.declaration then
        cmd 'command! -buffer LspDeclaration lua vim.lsp.buf.declaration()'
    end
    if cap.implementation then
        cmd 'command! -buffer LspImplementation lua vim.lsp.buf.implementation()'
    end
end

function M.make_lsp_commands(client, bufnr)
    api.nvim_buf_call(bufnr, function()
        make_lsp_commands(client)
    end)
end

function M.make_lsp_mappings(client, bufnr)
    local function bmap(mode, lhs, rhs)
        api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, {noremap = true})
    end

    local cap = client.resolved_capabilities
    if cap.goto_definition then
        bmap('n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>')
    end
    if cap.hover then
        bmap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
    end
    if cap.code_action then
        bmap('n', 'gA', '<Cmd>lua vim.lsp.buf.code_action()<CR>')
        bmap('x', 'gA', '<Cmd>lua vim.lsp.buf.range_code_action()<CR>')
    end
end

function M.format_command(bang)
    if bang then
        lsp.buf.formatting_sync()
    else
        lsp.buf.formatting()
    end
end

local visual_modes = {
    ['v'] = true,
    ['V'] = true,
    ['\26'] = true,
    ['s'] = true,
    ['S'] = true,
    ['\23'] = true,
}

function M.range_format_command(line1, line2)
    -- TODO
    lsp.buf.range_formatting()
end

return M
