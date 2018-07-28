# zsh-cmdstat
# Print information about exit code and execution time after a program exits
#
# Authors:
#   Anders Engström <ankaan@gmail.com>
#
# This project is released under the MIT License.
# 

function _zsh_cmdstat_displaytime() {
    local T=$1
    local D=$((T/60/60/24))
    local H=$((T/60/60%24))
    local M=$((T/60%60))
    local S=$((T%60))
    [[ $D > 0 ]] && printf '%dd:' $D
    [[ $D > 0 || $H > 0 ]] && printf '%dh:' $H
    [[ $D > 0 || $H > 0 || $M > 0 ]] && printf '%dm:' $M
    printf '%ds' $S
}

function _zsh_cmdstat_collect() {
    _zsh_cmdstat_cmd=$1
    _zsh_cmdstat_time=$(date "+%s")
}

function _zsh_cmdstat_display() {
    _zsh_cmdstat_status=$?
    if [[ -n $_zsh_cmdstat_cmd && -n $_zsh_cmdstat_time ]]; then
        local now diff timeout last_status

        now=$(date "+%s")
        last_status=$_zsh_cmdstat_status

        zstyle -s ':cmdstat:' command-complete-timeout timeout \
            || timeout=5
        zstyle -s ':cmdstat:' always-on-error always_on_error \
            || always_on_error=yes
        zstyle -s ':cmdstat:' bell bell \
            || bell=no

        secs=$(( $now - $_zsh_cmdstat_time ))
        if [[ $always_on_error == "yes" && $last_status -gt "0" ]] || (( secs >= $timeout )); then
            [[ $bell != no ]] && echo -ne "\a"
            printf '[exit %s] [time %s]\n' \
                "$last_status" \
                "$(_zsh_cmdstat_displaytime $secs)"
        fi
    fi
    unset _zsh_cmdstat_cmd _zsh_cmdstat_time _zsh_cmdstat_status
}

autoload add-zsh-hook
add-zsh-hook preexec _zsh_cmdstat_collect
add-zsh-hook precmd _zsh_cmdstat_display
