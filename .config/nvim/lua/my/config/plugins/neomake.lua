vim.cmd 'packadd! neomake'

vim.fn['neomake#configure#automake']('rw', 1000)

-- Already handled by language servers
vim.g.neomake_lua_enabled_makers = {}
vim.g.neomake_nim_enabled_makers = {}
