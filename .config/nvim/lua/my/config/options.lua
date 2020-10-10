-- Appearence
vim.cmd 'packadd dracula'
vim.g.colors_name = 'dracula'
vim.o.termguicolors = true
vim.wo.number = true
vim.wo.signcolumn = 'number'
vim.wo.list = true
local listchars = {
     'tab:│ ',
     'eol:¬',
     'nbsp:␣',
     'trail:•',
}
vim.o.listchars = table.concat(listchars, ',')
local fillchars = {
    'eob: ',
    'stlnc:─',
    'diff:─',
}
vim.o.fillchars = table.concat(fillchars, ',')
vim.wo.linebreak = true
vim.wo.breakindent = true
vim.o.showmode = false
vim.o.pumblend = 10
vim.o.pumheight = 25
vim.o.title = true

-- Cursor
vim.wo.cursorline = true
vim.o.mouse = 'a'
vim.o.whichwrap = 'b,h,l,s,<,>,[,],~'
local guicursor = {
    'n-v-c:block',
    'i-ci-ve:ver25',
    'r-cr:hor20',
    'o:hor50',
    'a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor',
    'sm:block-blinkwait175-blinkoff150-blinkon175',
}
vim.o.guicursor = table.concat(guicursor, ',')
vim.o.virtualedit = 'block'

-- Indentation behaviour
vim.bo.expandtab = true
vim.o.expandtab = true
vim.bo.shiftwidth = 4
vim.o.shiftwidth = 4
vim.bo.tabstop = 4
vim.o.tabstop = 4

-- Search Behaviour
vim.o.ignorecase = true
vim.o.inccommand = 'split'

-- Splits
vim.o.splitright = true
vim.o.splitbelow = true

-- External programs
vim.o.grepprg = 'rg --vimgrep --no-heading --smart-case'
vim.o.formatprg = 'prettier --stdin-filepath=%'

-- Filesystem
local wildignore = {
    'node_modules/',
}
vim.o.wildignore = table.concat(wildignore, ',')

-- Deactivate plugins I don't use
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_2html_plugin = 1
vim.g.did_install_default_menus = 1
vim.g.did_install_syntax_menu = 1

-- Providers
vim.g.loaded_python_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Miscellaneous
vim.o.lazyredraw = true
vim.o.updatetime = 300
vim.bo.spelllang = 'fr'
vim.o.spelllang = 'fr'
vim.o.hidden = true
vim.bo.undofile = true
vim.o.undofile = true
vim.o.switchbuf = 'usetab'
vim.o.shortmess = vim.o.shortmess..'cI'
local completeopt = {
    'menuone',
    'noinsert',
}
vim.o.completeopt = table.concat(completeopt, ',')
vim.o.joinspaces = false
