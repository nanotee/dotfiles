delcommand Glog
delcommand Gstatus
delcommand GcLog
delcommand GlLog

augroup fugitive_deprecations
    autocmd!
    autocmd FileType fugitive*,git nmap <buffer> q q
augroup END
