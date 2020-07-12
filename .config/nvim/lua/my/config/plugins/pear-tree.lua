vim.g.pear_tree_repeatable_expand = 0
vim.g.pear_tree_smart_backspace = 1
-- Insert extra space when pressing space between parentheses
vim.api.nvim_set_keymap('i', '<Space>', '<Plug>(PearTreeSpace)', {noremap = false})
