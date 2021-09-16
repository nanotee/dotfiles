-- Port of this script: https://gist.github.com/wellle/7458953
local function mapper(mapmode, keymap, mapping)
    vim.api.nvim_set_keymap(mapmode, keymap, mapping, {noremap = true, silent = true})
end

-- pairs
for _, mapmode in ipairs{'o', 'x'} do
    for _, delimiter in ipairs{{'{', '}'}, {'(', ')'}, {'[', ']'}, {'<', '>'}} do
        local opening, closing = delimiter[1], delimiter[2]
        for _, modifier in ipairs{'i', 'a'} do
            for _, trigger in ipairs{opening, closing} do
                mapper(mapmode, modifier .. 'n' .. trigger, ':<C-U>normal! f' .. opening .. 'v' .. modifier .. closing .. '<CR>')
                mapper(mapmode, modifier .. 'l' .. trigger, ':<C-U>normal! F' .. opening .. 'v' .. modifier .. closing .. '<CR>')
            end
        end
    end

    -- single (text objects like da. delete one dot)
    for _, delimiter in ipairs{'_', '.', ':', ',', ';', '<Bar>', '/', '<Bslash>', '*', '#', '%'} do
        mapper(mapmode, 'i' .. delimiter, ':<C-U>normal! t' .. delimiter .. 'vT' .. delimiter .. '<CR>')
        mapper(mapmode, 'a' .. delimiter, ':<C-U>normal! f' .. delimiter .. 'vF' .. delimiter .. '<CR>')
        mapper(mapmode, 'in' .. delimiter, ':<C-U>normal! f' .. delimiter .. 'lvt' .. delimiter .. '<CR>')
        mapper(mapmode, 'an' .. delimiter, ':<C-U>normal! f' .. delimiter .. 'lvf' .. delimiter .. '<CR>')
        mapper(mapmode, 'il' .. delimiter, ':<C-U>normal! F' .. delimiter .. 'hvT' .. delimiter .. '<CR>')
        mapper(mapmode, 'al' .. delimiter, ':<C-U>normal! F' .. delimiter .. 'vT' .. delimiter .. '<CR>')
    end

    -- double (text objects like dan" delete both quotes)
    -- doesn't handle one surrounding whitespace like da" does
    for _, delimiter in ipairs{'"', "'", '`'} do
        mapper(mapmode, 'in' .. delimiter, ':<C-U>normal! f' .. delimiter .. 'lvt' .. delimiter .. '<CR>')
        mapper(mapmode, 'an' .. delimiter, ':<C-U>normal! f' .. delimiter .. 'vf' .. delimiter .. '<CR>')
        mapper(mapmode, 'il' .. delimiter, ':<C-U>normal! F' .. delimiter .. 'hvT' .. delimiter .. '<CR>')
        mapper(mapmode, 'al' .. delimiter, ':<C-U>normal! F' .. delimiter .. 'vF' .. delimiter .. '<CR>')
    end
end
