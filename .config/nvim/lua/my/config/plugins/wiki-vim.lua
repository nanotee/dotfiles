vim.cmd 'autocmd VimEnter * packadd wiki.vim'

vim.g.wiki_root = '~/Documents/wiki'
vim.g.wiki_filetypes = {'md'}
vim.g.wiki_link_extension = '.md'
vim.g.wiki_link_target_type = 'md'
vim.g.wiki_export = {
    args = '--highlight-style=tango',
    from_format = 'markdown',
    ext = 'pdf',
    view = true,
    viewer = 'okular',
}
