-- Port of this script: https://gist.github.com/wellle/7458953
local function mapper(mapmode, keymap, mapping)
    vim.api.nvim_set_keymap(mapmode, keymap, mapping, {noremap = true, silent = true})
end

-- pairs
for _, mapmode in ipairs{'o', 'x'} do
    for _, delimiter in ipairs{'{}', '()', '[]', '<>'} do
        local opening = delimiter:sub(1, 1)
        local closing = delimiter:sub(2, 2)
        for _, modifier in ipairs{'i', 'a'} do
            for _, trigger in ipairs{opening, closing} do
                mapper(mapmode, modifier .. 'n' .. trigger, ':<C-u>normal! f' .. opening .. 'v' .. modifier .. closing .. '<CR>')
                mapper(mapmode, modifier .. 'l' .. trigger, ':<C-u>normal! F' .. opening .. 'v' .. modifier .. closing .. '<CR>')
            end
        end
    end

    -- single (text objects like da. delete one dot)
    for _, delimiter in ipairs{'_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '#', '%'} do
        mapper(mapmode, 'i' .. delimiter, ':<C-u>normal! t' .. delimiter .. 'vT' .. delimiter .. '<CR>')
        mapper(mapmode, 'a' .. delimiter, ':<C-u>normal! f' .. delimiter .. 'vF' .. delimiter .. '<CR>')
        mapper(mapmode, 'in' .. delimiter, ':<C-u>normal! f' .. delimiter .. 'lvt' .. delimiter .. '<CR>')
        mapper(mapmode, 'an' .. delimiter, ':<C-u>normal! f' .. delimiter .. 'lvf' .. delimiter .. '<CR>')
        mapper(mapmode, 'il' .. delimiter, ':<C-u>normal! F' .. delimiter .. 'hvT' .. delimiter .. '<CR>')
        mapper(mapmode, 'al' .. delimiter, ':<C-u>normal! F' .. delimiter .. 'vT' .. delimiter .. '<CR>')
    end

    -- double (text objects like dan" delete both quotes)
    -- doesn't handle one surrounding whitespace like da" does
    for _, delimiter in ipairs{'"', "'", '`'} do
        mapper(mapmode, 'in' .. delimiter, ':<C-u>normal! f' .. delimiter .. 'lvt' .. delimiter .. '<CR>')
        mapper(mapmode, 'an' .. delimiter, ':<C-u>normal! f' .. delimiter .. 'vf' .. delimiter .. '<CR>')
        mapper(mapmode, 'il' .. delimiter, ':<C-u>normal! F' .. delimiter .. 'hvT' .. delimiter .. '<CR>')
        mapper(mapmode, 'al' .. delimiter, ':<C-u>normal! F' .. delimiter .. 'vF' .. delimiter .. '<CR>')
    end
end
