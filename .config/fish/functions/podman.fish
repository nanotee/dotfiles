function podman --description 'alias podman flatpak-spawn podman --host'
    flatpak-spawn --host podman $argv
end
