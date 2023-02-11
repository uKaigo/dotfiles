local functions = {}

-- Will require the path and print any errors without throwing.
function functions.prequire(path)
  local ran, res = pcall(require, path)
  if not ran then
    vim.cmd(([[
              echohl ErrorMsg
              echo " "
              echo 'Failed to load "%s":'
              echo "%s"
              echohl None 
	     ]]):format(path, res))
    return false
  end
  return res
end

return functions
