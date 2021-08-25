local map = vim.api.nvim_set_keymap
local g, opt = vim.g, vim.opt

g.polyglot_disabled = {'sensible', 'autoindent'}

function _G.put(...)
    local objects = {}
    for i = 1, select('#', ...) do
        local v = select(i, ...)
        table.insert(objects, vim.inspect(v))
    end

    print(table.concat(objects, '\n'))
    return ...
end

function _G.reload(modname)
    package.loaded[modname] = nil
    return require(modname)
end

function _G.benchmark(fun, name)
    local start = vim.loop.hrtime()
    fun()
    local total = (vim.loop.hrtime() - start) / 1e6
    print(total, 'ms', name and '--- ' .. name or '')
end

vim.cmd [[colorscheme dracula]]
opt.termguicolors = true
opt.number = true
opt.signcolumn = 'number'
opt.list = true
opt.listchars = {
     tab = '> ',
     eol = '¬',
     nbsp = '␣',
     trail = '•',
}
opt.fillchars = {
    eob = ' ',
    stlnc = '─',
    diff = '·',
}
opt.linebreak = true
opt.breakindent = true
opt.showmode = false
opt.pumblend = 20
opt.pumheight = 25
opt.title = true
opt.guifont = 'mononoki Nerd Font'
opt.previewheight = 18

opt.cursorline = true
opt.mouse = 'a'
opt.guicursor = {
    'n-v-c:block',
    'i-ci-ve:ver25',
    'r-cr:hor20',
    'o:hor50',
    'a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor',
    'sm:block-blinkwait175-blinkoff150-blinkon175',
}
opt.virtualedit = 'block'

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4

opt.ignorecase = true
opt.inccommand = 'split'

opt.splitright = true
opt.splitbelow = true

opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
opt.formatprg = 'prettier --stdin-filepath=%'

g.loaded_netrwPlugin = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_tarPlugin = 1
g.loaded_zipPlugin = 1
g.loaded_gzip = 1
g.loaded_2html_plugin = 1
g.did_install_default_menus = 1
g.did_install_syntax_menu = 1

g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

opt.lazyredraw = true
opt.updatetime = 300
opt.undofile = true
opt.switchbuf:append{'usetab'}
opt.shortmess:append{c = true, I = true}
opt.completeopt = {'menuone', 'noselect'}
opt.shada:append{':1000', '/1000'}

g.mapleader = 'ù'
g.maplocalleader = 'à'

map('i', 'jk', '<Esc>', {})

map('', 'gx', '<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>', {})

map('n', '<Leader>rc', '<Cmd>tabedit $MYVIMRC<CR>', {noremap = true})

map('', 'j', "(v:count? 'j' : 'gj')", {noremap = true, expr = true})
map('', 'k', "(v:count? 'k' : 'gk')", {noremap = true, expr = true})

map('n', '<C-w>e', '<Cmd>wincmd _ | wincmd |<CR>', {noremap = true})

map('o', 'ad', '<Cmd>normal! ggVG<CR>', {noremap = true})
map('x', 'ad', 'gg0oG$', {noremap = true})

map('n', '<Leader>rr',  '<Cmd>RunCode<CR>', {noremap = true})
map('n', '<Leader>rl',  '<Cmd>.RunCode<CR>', {noremap = true})
map('v', '<leader>r', ':RunCode<CR>', {noremap = true})

map('c', '<Tab>', [[getcmdtype() =~# '[/?]' ? "\<C-g>" : "\<Tab>"]], {expr = true, noremap = true})
map('c', '<S-Tab>', [[getcmdtype() =~# '[/?]' ? "\<C-t>" : "\<S-Tab>"]], {expr = true, noremap = true})

-- https://www.galago-project.org/specs/notification/0.9/x320.html
local notify_send_urgency_map = {
    [vim.lsp.log_levels.TRACE] = 'low',
    [vim.lsp.log_levels.DEBUG] = 'low',
    [vim.lsp.log_levels.INFO]  = 'normal',
    [vim.lsp.log_levels.WARN]  = 'normal',
    [vim.lsp.log_levels.ERROR] = 'critical',
}

-- https://specifications.freedesktop.org/icon-naming-spec/latest/ar01s04.html
local xdg_icons_map = {
    [vim.lsp.log_levels.TRACE] = 'nvim',
    [vim.lsp.log_levels.DEBUG] = 'nvim',
    [vim.lsp.log_levels.INFO]  = 'dialog-information',
    [vim.lsp.log_levels.WARN]  = 'dialog-warning',
    [vim.lsp.log_levels.ERROR] = 'dialog-error',
}

function vim.notify(msg, log_level, opts)
    log_level = log_level or vim.lsp.log_levels.TRACE
    opts = opts or {}
    local command = {
        'notify-send',
        '--icon', xdg_icons_map[log_level],
        '--urgency', notify_send_urgency_map[log_level],
        '--category', ('x-neovim.notification.%s'):format(vim.lsp.log_levels[log_level]),
        '--hint', 'STRING:desktop-entry:nvim',
    }
    if opts.timeout then
        command[#command+1] = '--expire-time'
        command[#command+1] = opts.timeout
    end

    command[#command+1] = opts.title or 'Neovim'
    command[#command+1] = msg
    vim.fn.jobstart(command)
end

require('my.config.packages')
require('my.config.lsp')
