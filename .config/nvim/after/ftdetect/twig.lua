vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.html.twig',
    command = 'set filetype=html.twig',
})
