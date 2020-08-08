function fkill
set -l pid (ps -ef | sed 1d | fzf -m | awk '{print $2}') || return
kill -9 $pid
end
