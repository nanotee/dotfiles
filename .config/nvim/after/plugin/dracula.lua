local g = vim.g
local api = vim.api
if g.loaded_dracula_custom_colors then
    return
end
g.loaded_dracula_custom_colors = true

local highlight_groups = {
    LspSignatureActiveParameter = {link = 'DraculaOrange'},
    -- Make inactive windows darker
    NormalNC = {link = 'Pmenu'},
    -- diff
    DiffAdd = {bg = '#2B4B3C'},
    DiffChange = {bg = '#4B3D3A'},
    DiffDelete = {bg = '#4B2D38', fg = 'NONE'},
    DiffText = {bg = '#725542'},
    -- sandwich
    OperatorSandwichAdd = {link = 'DraculaGreen'},
    OperatorSandwichChange = {link = 'DraculaOrange'},
    OperatorSandwichDelete = {link = 'DraculaRed'},
    -- HerringtonDarkholme/yats.vim
    typescriptArrayMethod = {link = 'DraculaCyan'},
    typescriptArrayStaticMethod = {link = 'DraculaCyan'},
    typescriptBOM = {link = 'Type'},
    typescriptBOMLocationMethod = {link = 'DraculaCyan'},
    typescriptBOMWindowMethod = {link = 'DraculaCyan'},
    typescriptCacheMethod = {link = 'DraculaCyan'},
    typescriptClassHeritage = {link = 'DraculaCyanItalic'},
    typescriptClassName = {link = 'DraculaCyan'},
    typescriptDOMDocMethod = {link = 'DraculaCyan'},
    typescriptDOMDocProp = {link = 'Constant'},
    typescriptDOMEventProp = {link = 'Constant'},
    typescriptDOMEventMethod = {link = 'DraculaCyan'},
    typescriptDOMEventTargetMethod = {link = 'DraculaCyan'},
    typescriptDOMFormMethod = {link = 'DraculaCyan'},
    typescriptDOMNodeMethod = {link = 'DraculaCyan'},
    typescriptDOMStorageMethod = {link = 'DraculaCyan'},
    typescriptFunctionMethod = {link = 'DraculaCyan'},
    typescriptHeadersMethod = {link = 'DraculaCyan'},
    typescriptMathStaticMethod = {link = 'DraculaCyan'},
    typescriptNodeGlobal = {link = 'Constant'},
    typescriptObjectMethod = {link = 'DraculaCyan'},
    typescriptObjectStaticMethod = {link = 'DraculaCyan'},
    typescriptPromiseMethod = {link = 'DraculaCyan'},
    typescriptStringMethod = {link = 'DraculaCyan'},
    -- vim/zsh.vim
    zshCommands = {link = 'DraculaCyan'},
    zshOptStart = {link = 'DraculaCyan'},
    zshTypes = {link = 'Keyword'},
    -- vim-python/python-syntax
    pythonBuiltinFunc = {link = 'DraculaCyan'},
    pythonClass = {link = 'DraculaCyan'},
    -- StanAngeloff/php.vim
    phpClass = {link = 'DraculaCyan'},
    phpClassExtends = {link = 'Type'},
    phpFunctions = {link = 'DraculaCyan'},
    phpFunctionCall = {link = 'Function'},
    phpMethod = {link = 'Function'},
    phpThis = {link = 'DraculaPurpleItalic'},
    phpUseClass = {link = 'Type'},
    phpUseNamespaceSeparator = {link = 'DraculaPink'},
    -- tbastos/vim-lua
    luaFuncKeyword = {link = 'DraculaPink'},
    -- vim/vim.vim
    vimFuncName = {link = 'DraculaCyan'},
    vimFuncVar = {link = 'DraculaOrangeItalic'},
    vimNotation = {link = 'Constant'},
    -- tree-sitter
    TSConstBuiltin = {link = 'Constant'},
    TSEmphasis = {link = 'DraculaYellowItalic'},
    TSField = {link = 'Identifier'},
    TSLiteral = {link = 'DraculaGreen'},
    TSNamespace = {link = 'Identifier'},
    TSParameterReference = {link = 'DraculaOrangeItalic'},
    TSStrong = {link = 'DraculaOrangeBold'},
    TSTitle = {link = 'DraculaPurpleBold'},
    markdownTSURI = {link = 'DraculaCyan'},
    jsonTSLabel = {link = 'DraculaCyan'},
    yamlTSField = {link = 'DraculaCyan'},
    yamlTSPunctDelimiter = {link = 'DraculaPink'},
}

local nvim_set_hl = api.nvim_set_hl
local function set_dracula_custom()
    for name, val in pairs(highlight_groups) do
        nvim_set_hl(0, name, val)
    end
end

api.nvim_create_autocmd('ColorScheme', {
    group = api.nvim_create_augroup('set_dracula_custom', {}),
    pattern = 'dracula',
    callback = set_dracula_custom,
})

if g.colors_name == 'dracula' then
    set_dracula_custom()
end
