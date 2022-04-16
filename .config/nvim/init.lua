require('impatient')

local map = vim.keymap.set
local g, opt = vim.g, vim.opt
local api, fn, cmd = vim.api, vim.fn, vim.cmd
local split = vim.split

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
opt.shiftwidth = 0
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
opt.completeopt = {'menu', 'menuone', 'noselect'}
opt.shada:append{':1000', '/1000'}

g.mapleader = 'ù'
g.maplocalleader = 'à'

map('i', 'jk', '<Esc>')

map('', 'gx', '<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>')

map('', 'j', "(v:count? 'j' : 'gj')", {expr = true})
map('', 'k', "(v:count? 'k' : 'gk')", {expr = true})

map('o', 'ad', '<Cmd>normal! ggVG<CR>')
map('x', 'ad', 'gg0oG$')

map('n', ']!', vim.diagnostic.goto_next)
map('n', '[!', vim.diagnostic.goto_prev)
map('n', 'g!', '<Cmd>lua vim.diagnostic.open_float(0, {scope = "line"})<CR>')

local mapmodes = {'o', 'x'}
local map_opts = {silent = true}
for _, delimiter in ipairs{'_', '.', ':', ',', ';', '<Bar>', '/', '<Bslash>', '*', '#', '%'} do
    map(mapmodes, 'i' .. delimiter, ':<C-U>normal! t' .. delimiter .. 'vT' .. delimiter .. '<CR>', map_opts)
    map(mapmodes, 'a' .. delimiter, ':<C-U>normal! f' .. delimiter .. 'vF' .. delimiter .. '<CR>', map_opts)
    map(mapmodes, 'in' .. delimiter, ':<C-U>normal! f' .. delimiter .. 'lvt' .. delimiter .. '<CR>', map_opts)
    map(mapmodes, 'an' .. delimiter, ':<C-U>normal! f' .. delimiter .. 'lvf' .. delimiter .. '<CR>', map_opts)
    map(mapmodes, 'il' .. delimiter, ':<C-U>normal! F' .. delimiter .. 'hvT' .. delimiter .. '<CR>', map_opts)
    map(mapmodes, 'al' .. delimiter, ':<C-U>normal! F' .. delimiter .. 'vT' .. delimiter .. '<CR>', map_opts)
end

-- Redirects the output of an ex command in a scratch buffer. May become
-- obsolete once https://github.com/neovim/neovim/issues/5054 is implemented
api.nvim_create_user_command('Redirect', function(opts)
    local buf = api.nvim_create_buf(false, true)
    cmd(('%s split'):format(opts.mods))
    local win = api.nvim_get_current_win()
    vim.wo[win].number = false
    vim.wo[win].list = false
    vim.bo[buf].bufhidden = 'wipe'

    local result = fn.execute(opts.args)
    api.nvim_buf_set_lines(buf, 0, 0, true, split(result, '\n', {plain = true, trimempty = true}))
    api.nvim_win_set_buf(win, buf)
end, {nargs = 1, complete = 'command'})

api.nvim_create_user_command('Trash', function(opts)
    local file = fn.fnamemodify(fn.bufname(opts.args), ':p')
    cmd('bdelete' .. (opts.bang and '!' or ''))
    fn.system({'kioclient5', 'move', file, 'trash:/'})
    if fn.bufloaded(file) == 0 and vim.v.shell_error > 0 then
        api.nvim_err_writeln(('Failed to move %s to trash'):format(file))
    end
end, {bang = true})

api.nvim_create_user_command('WikiFzfSearch', function(opts)
    fn['fzf#vim#grep'](
        ('rg --column --line-number --no-heading --color=always --smart-case -- %s %s')
            :format(fn.shellescape(opts.args), vim.g.wiki_root),
        1,
        opts.bang
    )
end, {bang = true, nargs = '*'})

api.nvim_create_user_command('Scratch', function(opts)
    local buf = api.nvim_create_buf(false, false)
    vim.bo[buf].filetype = opts.args ~= '' and vim.trim(opts.args) or vim.bo.filetype
    vim.bo[buf].buftype = 'nofile'
    vim.bo[buf].bufhidden = 'hide'
    vim.bo[buf].swapfile = false
    if opts.range ~= 0 then
        local lines_to_copy = api.nvim_buf_get_lines(api.nvim_get_current_buf(), opts.line1 - 1, opts.line2, false)
        api.nvim_buf_set_lines(buf, 0, 1, false, lines_to_copy)
    end
    vim.cmd(('%s split'):format(opts.mods))
    api.nvim_win_set_buf(0, buf)
end, {range = 0, nargs = '?', complete = 'filetype'})

vim.diagnostic.config({
    virtual_text = false,
    float = {
        border = 'rounded',
        source = 'always',
    },
})

vim.filetype.add({
    extension = {
        mustache = 'html.mustache',
    },
})

-- https://www.galago-project.org/specs/notification/0.9/x320.html
local notify_send_urgency_map = {
    [vim.log.levels.TRACE] = 'low',
    [vim.log.levels.DEBUG] = 'low',
    [vim.log.levels.INFO]  = 'normal',
    [vim.log.levels.WARN]  = 'normal',
    [vim.log.levels.ERROR] = 'critical',
}

-- https://specifications.freedesktop.org/icon-naming-spec/latest/ar01s04.html
local xdg_icons_map = {
    [vim.log.levels.TRACE] = 'nvim',
    [vim.log.levels.DEBUG] = 'nvim',
    [vim.log.levels.INFO]  = 'dialog-information',
    [vim.log.levels.WARN]  = 'dialog-warning',
    [vim.log.levels.ERROR] = 'dialog-error',
}

function vim.notify(msg, log_level, opts)
    log_level = log_level or vim.log.levels.TRACE
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

function vim.ui.select(items, opts, on_choice)
    vim.validate {
        items = { items, 'table', false },
        on_choice = { on_choice, 'function', false },
    }
    opts = opts or {}
    local choices = {}
    local lookup = {}
    local format_item = opts.format_item or tostring
    for i, item in pairs(items) do
        local choice = ('%s: %s'):format(i, format_item(item))
        table.insert(choices, choice)
        lookup[choice] = #choices
    end
    local fzf_wrapped_options = vim.fn['fzf#wrap']('vim.ui.select', {
        source = choices,
        options = {'--prompt', opts.prompt or 'Select one of:'}
    })
    fzf_wrapped_options['sink*'] = function(result)
        local index = lookup[result[2]]
        on_choice(items[index], index)
    end

    vim.fn['fzf#run'](fzf_wrapped_options)
end

require('my.config.packages')
require('my.config.lsp')
