delcommand Gremove
delcommand Gdelete
delcommand Gmove
delcommand Grename
delcommand Gbrowse
delcommand Gblame
delcommand Gcommit
delcommand Gmerge
delcommand Gpull
delcommand Grebase
delcommand Grevert
delcommand Gpush
delcommand Gfetch
delcommand Glog
delcommand Gstatus
delcommand GcLog
delcommand GlLog

augroup fugitive_deprecations
    autocmd!
    autocmd FileType fugitive,git nmap <buffer> q q
augroup END
