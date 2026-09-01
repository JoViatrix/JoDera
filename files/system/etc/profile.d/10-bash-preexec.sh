# Source bash-preexec before atuin
if [[ -n "${BASH_VERSION:-}" ]]; then
    source /usr/share/bash-preexec/bash-preexec.sh
fi
