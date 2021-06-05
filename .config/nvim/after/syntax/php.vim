syn keyword phpThis this containedin=phpIdentifier contained
syn keyword phpKeyword fn contained
syn keyword phpKeyword abstract static final var public private protected const contained
syn match phpFunctionCall /\k\+\%(\s*(\)\@=/ containedin=phpRegion contained
