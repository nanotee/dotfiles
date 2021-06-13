local g, opt = vim.g, vim.opt
-- Appearence
g.colors_name = 'dracula'
opt.termguicolors = true
opt.number = true
opt.signcolumn = 'number'
opt.list = true
opt.listchars = {
     tab = '│ ',
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
opt.pumblend = 10
opt.pumheight = 25
opt.title = true
opt.guifont = 'mononoki Nerd Font'

-- Cursor
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

-- Indentation behaviour
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4

-- Search Behaviour
opt.ignorecase = true
opt.inccommand = 'split'

-- Splits
opt.splitright = true
opt.splitbelow = true

-- External programs
opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
opt.formatprg = 'prettier --stdin-filepath=%'

-- Deactivate plugins I don't use
g.loaded_netrwPlugin = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_tarPlugin = 1
g.loaded_zipPlugin = 1
g.loaded_gzip = 1
g.loaded_2html_plugin = 1
g.did_install_default_menus = 1
g.did_install_syntax_menu = 1

-- Providers
g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- Miscellaneous
opt.lazyredraw = true
opt.updatetime = 300
opt.spelllang = 'fr'
opt.hidden = true
opt.undofile = true
opt.switchbuf = 'usetab'
opt.shortmess:append{c = true, I = true}
opt.completeopt = {'menuone', 'noselect'}
opt.joinspaces = false
opt.shada = {'!', "'100", '<50', 's10', 'h', ':1000', '/1000'}
