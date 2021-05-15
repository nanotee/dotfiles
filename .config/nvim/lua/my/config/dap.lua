local dap = require('dap')

dap.adapters.node2 = {
    type = 'executable',
    command = 'vscode-node-debug2'
}

dap.configurations.javascript = {
    {
        type = 'node2',
        request = 'launch',
        program = '${workspaceFolder}/${file}',
        name = 'Node',
    },
}

dap.adapters.nlua = function(callback, config)
    callback({type = 'server', host = config.host, port = config.port})
end

dap.configurations.lua = {
    {
        type = 'nlua',
        request = 'attach',
        name = 'Neovim Lua',
        host = '127.0.0.1',
        port = 8080,
    },
}

dap.adapters.c = {
    {
        type = 'executable',
        attach = {
            pidProperty = "pid",
            pidSelect = "ask"
        },
        command = 'lldb-vscode',
        env = {
            LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
        },
        name = "lldb",
    }
}

dap.adapters['lldb-vscode'] = dap.adapters.c
