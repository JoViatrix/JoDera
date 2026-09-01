# Source bash-preexec before atuin
if [[ -n "${BASH_VERSION:-}" ]]; then
    source /usr/local/share/bash-preexec/bash-preexec.sh
fi
