function _run_if_found --description "Run the program if it's found. Intended for use in scripts."
  command -sq $argv[1] || return 0
  command $argv[1] $argv[2..]
  return $status
end
