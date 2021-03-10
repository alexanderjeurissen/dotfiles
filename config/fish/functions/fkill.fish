function fkill
  ps ax -o pid,time,command | fzf -m | awk '{print $1}' | xargs kill -9
end
