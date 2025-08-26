vim.loader.enable()

local map = vim.keymap.set
local g, o, bo, wo = vim.g, vim.o, vim.bo, vim.wo
local api, fn, cmd, lsp = vim.api, vim.fn, vim.cmd, vim.lsp

if fn.has('nvim-0.12') == 1 then
    require('vim._extui').enable({})
end

-- Remove when 0.12 comes out
vim.pack = vim.pack or { add = require('paq') }

vim.pack.add({
    {
        src = 'https://github.com/dracula/vim',
        name = 'dracula',
        -- Remove when 0.12 comes out
        url = 'https://github.com/dracula/vim',
        as = 'dracula',
    },
    'https://github.com/nvim-lualine/lualine.nvim',
    'https://github.com/junegunn/fzf.vim',
    'https://github.com/tpope/vim-abolish',
    'https://github.com/tpope/vim-eunuch',
    'https://github.com/tpope/vim-fugitive',
    'https://github.com/tpope/vim-rhubarb',
    'https://github.com/tpope/vim-repeat',
    'https://github.com/tpope/vim-surround',
    'https://github.com/tpope/vim-dispatch',
    'https://github.com/tpope/vim-projectionist',
    'https://github.com/ii14/lsp-command',
    'https://github.com/kosayoda/nvim-lightbulb',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/mroavi/lf.vim',
    'https://github.com/hrsh7th/nvim-cmp',
    'https://github.com/hrsh7th/cmp-nvim-lsp',
    'https://github.com/tweekmonster/helpful.vim',
    'https://github.com/vim-test/vim-test',
    'https://codeberg.org/mfussenegger/nvim-dap',
    'https://github.com/noahfrederick/vim-composer',
    'https://github.com/lumiliet/vim-twig',
    'https://codeberg.org/mfussenegger/nvim-lint',
})

cmd.set('runtimepath+=~/Projets/dev/nvim/zoxide.vim')
cmd.set('runtimepath+=~/Projets/dev/nvim/sqls.nvim')

cmd('silent! colorscheme dracula')
o.number = true
o.signcolumn = 'number'
o.list = true
o.linebreak = true
o.breakindent = true
o.pumblend = 20
o.pumheight = 25
o.previewheight = 18
o.exrc = true
o.winborder = 'rounded'
o.cmdheight = 0
o.cursorline = true

o.expandtab = true
o.shiftwidth = 0
o.tabstop = 4

o.ignorecase = true
o.inccommand = 'split'

o.splitright = true
o.splitbelow = true

if fn.has('win32') == 1 then
    o.shell = 'powershell'
    o.shellcmdflag = '-Command'
    o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
    o.shellpipe = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
    o.shellquote = ''
    o.shellxquote = ''
    o.shelltemp = false
end

g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

o.lazyredraw = true
o.updatetime = 300
o.undofile = true
cmd.set('switchbuf+=usetab')
o.completeopt = 'menu,menuone,noselect'
cmd.set('shada+=:1000,/1000')

g.mapleader = 'ù'
g.maplocalleader = 'à'

map('i', 'jk', '<Esc>')

vim.g['test#strategy'] = 'neovim'
vim.g['test#neovim#term_position'] = 'belowright'

g['lf#set_default_mappings'] = 0
g['lf#replace_netrw'] = 1
g['lf#layout'] = { window = { width = 0.9, height = 0.6 } }
g['lf#action'] = {
    ['<C-T>'] = 'tab split',
    ['<C-X>'] = 'split',
    ['<C-V>'] = 'vsplit',
}

map('n', '<Leader>f', function()
    return fn.expand('%') == '' and '<Cmd>Lp %:p:h<CR>' or '<Cmd>Lp %<CR>'
end, { expr = true })

g.fzf_buffers_jump = 1

map('n', '<C-p>', '<Cmd>Files<CR>')

local mapmodes = { 'o', 'x' }
local map_opts = { silent = true }
for _, delimiter in ipairs { '_', '.', ':', ',', ';', '<Bar>', '/', '<Bslash>', '*', '#', '%' } do
    map(mapmodes, 'i' .. delimiter, ':<C-U>normal! t' .. delimiter .. 'vT' .. delimiter .. '<CR>', map_opts)
    map(mapmodes, 'a' .. delimiter, ':<C-U>normal! f' .. delimiter .. 'vF' .. delimiter .. '<CR>', map_opts)
    map(mapmodes, 'in' .. delimiter, ':<C-U>normal! f' .. delimiter .. 'lvt' .. delimiter .. '<CR>', map_opts)
    map(mapmodes, 'an' .. delimiter, ':<C-U>normal! f' .. delimiter .. 'lvf' .. delimiter .. '<CR>', map_opts)
    map(mapmodes, 'il' .. delimiter, ':<C-U>normal! F' .. delimiter .. 'hvT' .. delimiter .. '<CR>', map_opts)
    map(mapmodes, 'al' .. delimiter, ':<C-U>normal! F' .. delimiter .. 'vT' .. delimiter .. '<CR>', map_opts)
end

map('n', '<F5>', function() require('dap').continue() end, { desc = 'DAP: continue' })
map('n', '<F10>', function() require('dap').step_over() end, { desc = 'DAP: step over' })
map('n', '<F11>', function() require('dap').step_into() end, { desc = 'DAP: step into' })
map('n', '<S-F11>', function() require('dap').step_out() end, { desc = 'DAP: step out' })
map('n', '<F9>', function() require('dap').toggle_breakpoint() end, { desc = 'DAP: toggle breakpoint' })
map('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
    { desc = 'DAP: set log point' })
map('n', '<Leader>dr', function() require('dap').repl.toggle() end, { desc = 'DAP: toggle REPL' })
map('n', '<Leader>dl', function() require('dap').run_last() end, { desc = 'DAP: run last' })
map({ 'n', 'v' }, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
end, { desc = 'DAP: show hover' })
map({ 'n', 'v' }, '<Leader>dp', function()
    require('dap.ui.widgets').preview()
end, { desc = 'DAP: show preview' })
map('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end, { desc = 'DAP: show frames' })
map('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end, { desc = 'DAP: show scopes' })

api.nvim_create_user_command('Trash', function(opts)
    local file = fn.fnamemodify(fn.bufname(opts.args), ':p')
    cmd('bdelete' .. (opts.bang and '!' or ''))
    fn.system({ 'gio', 'trash', file })
    if fn.bufloaded(file) == 0 and vim.v.shell_error > 0 then
        api.nvim_echo({ { ('Failed to move %s to trash'):format(file) } }, true, { err = true })
    end
end, { bang = true })

api.nvim_create_user_command('Scratch', function(opts)
    local buf = api.nvim_create_buf(false, false)
    bo[buf].filetype = opts.args ~= '' and vim.trim(opts.args) or bo.filetype
    bo[buf].buftype = 'nofile'
    bo[buf].bufhidden = 'hide'
    bo[buf].swapfile = false
    if opts.range ~= 0 then
        local lines_to_copy = api.nvim_buf_get_lines(api.nvim_get_current_buf(), opts.line1 - 1, opts.line2, false)
        api.nvim_buf_set_lines(buf, 0, 1, false, lines_to_copy)
    end
    cmd.split({ mods = opts.smods })
    api.nvim_win_set_buf(0, buf)
end, { range = 0, nargs = '?', complete = 'filetype' })

vim.diagnostic.config({
    virtual_lines = {
        current_line = true,
    },
})

vim.filetype.add({
    extension = {
        mustache = 'html.mustache',
    },
})
vim.filetype.add({
    extension = {
        importmap = 'json',
    },
})
vim.filetype.add({
    extension = {
        ['xml.dist'] = 'xml',
    },
})

if fn.has('linux') == 1 then
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
        [vim.log.levels.TRACE] = 'io.neovim.nvim',
        [vim.log.levels.DEBUG] = 'io.neovim.nvim',
        [vim.log.levels.INFO]  = 'dialog-information',
        [vim.log.levels.WARN]  = 'dialog-warning',
        [vim.log.levels.ERROR] = 'dialog-error',
    }

    ---@diagnostic disable-next-line
    function vim.notify(msg, log_level, opts)
        log_level = log_level or vim.log.levels.TRACE
        opts = opts or {}
        local command = {
            'notify-send',
            '--icon', xdg_icons_map[log_level],
            '--urgency', notify_send_urgency_map[log_level],
            '--category', ('x-neovim.notification.%s'):format(lsp.log_levels[log_level]),
            '--hint', 'STRING:desktop-entry:nvim',
            '--app-name', 'Neovim',
        }
        if opts.timeout then
            command[#command + 1] = '--expire-time'
            command[#command + 1] = opts.timeout
        end

        command[#command + 1] = opts.title or 'Neovim'
        command[#command + 1] = msg
        fn.jobstart(command)
    end
end

---@diagnostic disable-next-line
function vim.ui.select(items, opts, on_choice)
    vim.validate {
        items = { items, 'table', false },
        opts = { opts, 'table', false },
        on_choice = { on_choice, 'function', false },
    }
    local choices = {}
    local lookup = {}
    local format_item = opts.format_item or tostring
    for i, item in pairs(items) do
        local choice = ('%s: %s'):format(i, format_item(item))
        table.insert(choices, choice)
        lookup[choice] = #choices
    end
    local fzf_wrapped_options = fn['fzf#wrap']('vim.ui.select', {
        source = choices,
        options = { '--prompt', opts.prompt or 'Select one of:' }
    })

    fzf_wrapped_options['sink*'] = function(result)
        local index = lookup[result[2]]
        on_choice(items[index], index)
    end

    fn['fzf#run'](fzf_wrapped_options)
end

require('lualine').setup()

local function has_words_before()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require('cmp')
cmp.setup {
    sources = {
        { name = 'nvim_lsp' },
    },
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-space>'] = {
            i = cmp.mapping.complete(),
        },
        ['<Enter>'] = {
            i = cmp.mapping.confirm({ select = true }),
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.snippet.active({ direction = 1 }) then
                vim.snippet.jump(1)
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.snippet.active({ direction = -1 }) then
                vim.snippet.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
}

vim.keymap.set({ 'i', 's' }, '<Tab>', function()
    if vim.snippet.active({ direction = 1 }) then
        return '<Cmd>lua vim.snippet.jump(1)<CR>'
    else
        return '<Tab>'
    end
end, { expr = true })

lsp.commands['editor.action.triggerParameterHints'] = function()
    lsp.buf.signature_help()
end

vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            completion = {
                callSnippet = 'Replace',
            },
            hint = {
                enable = true,
                arrayIndex = false,
            },
        },
    },
})
vim.lsp.config('jsonls', {
    schemaDownload = {
        enable = true,
    },
})
vim.lsp.config('emmet_language_server', {
    filetypes = vim.list_extend(vim.lsp.config.emmet_language_server.filetypes, { 'html.twig' }),
})
vim.lsp.config('html', {
    filetypes = vim.list_extend(vim.lsp.config.html.filetypes, { 'html.twig' }),
})
vim.lsp.config('intelephense', {
    init_options = {
        globalStoragePath = (vim.env.XDG_DATA_HOME or '') .. '/intelephense',
        licenceKey = (vim.env.XDG_DATA_HOME or '') .. '/intelephense/licence.txt',
    },
})

vim.lsp.enable {
    'lua_ls',
    'jsonls',
    'yamlls',
    -- 'denols',
    'ts_ls',
    'clangd',
    'vimls',
    'emmet_language_server',
    'html',
    'cssls',
    'sqls',
    'zls',
    'intelephense',
    'bashls',
}

api.nvim_create_augroup('no_cursorline_in_insert_mode', {})
api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
    group = 'no_cursorline_in_insert_mode',
    callback = function()
        wo.cursorline = true
    end,
})
api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
    group = 'no_cursorline_in_insert_mode',
    callback = function()
        wo.cursorline = false
    end,
})

api.nvim_create_autocmd('QuickFixCmdPost', {
    pattern = { 'grep', 'helpgrep' },
    group = api.nvim_create_augroup('quickfix', {}),
    command = 'cwindow',
})

api.nvim_create_autocmd('TextYankPost', {
    group = api.nvim_create_augroup('hl_yank', {}),
    callback = function() vim.highlight.on_yank() end,
})

api.nvim_create_autocmd('BufReadPost', {
    group = api.nvim_create_augroup('restore_curpos', {}),
    callback = function()
        if fn.line("'\"") >= 1 and fn.line("'\"") <= fn.line('$') and not bo.filetype:match('commit') then
            fn.execute('normal! g`"')
        end
    end,
})

api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    group = api.nvim_create_augroup('LspLightBulb', {}),
    callback = function() require('nvim-lightbulb').update_lightbulb() end,
})
