function! s:make_abbrevs() abort
    Abolish docotr{,ate}{,s} doctor{}{}
    Abolish -cmdline func{toi,ito,oti}n{,s} func{tio}n{}
    Abolish lan{gau,uga}ge{,s} lan{gua}ge{}
    Abolish pariticipant{,e}{,s} participant{}{}
    Abolish phtoo{,s} photo{}
    Abolish conatin{,er}{,s} contain{}{}
    Abolish -cmdline ver{iso,soi}n{,s} ver{sio}n{}
    Abolish refacotr{,ed,ing} refactor{}
    Abolish anwser{,s,ing} answer{}
endfunction

autocmd InsertEnter,CmdlineEnter * ++once call <SID>make_abbrevs()
