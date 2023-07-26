start_tmux > /dev/null
if [ $status -eq 0 ]
  # Odd way of exitting, but "exit" does not work for some reason.
  exec true
end
