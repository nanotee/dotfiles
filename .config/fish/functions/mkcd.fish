function mkcd --description 'alias mkcd mkdir --parents $argv && cd $argv'
    command mkdir --parents $argv && cd $argv
end
