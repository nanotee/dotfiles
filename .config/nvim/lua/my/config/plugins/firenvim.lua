if vim.g.started_by_firenvim then
    vim.g.firenvim_config = {
        localSettings = {
            ['.*'] = {
                cmdline = 'firenvim',
                takeover = 'never',
            }
        }
    }
    vim.cmd 'packadd firenvim'
    vim.o.laststatus = 0
    vim.bo.filetype = 'markdown'
end
