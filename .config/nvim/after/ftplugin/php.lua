vim.o.commentstring = '// %s'
vim.cmd.setlocal('path+=templates')

local dap = require('dap')

dap.adapters.php = {
  type = 'executable',
  command = 'php-dap',
}
