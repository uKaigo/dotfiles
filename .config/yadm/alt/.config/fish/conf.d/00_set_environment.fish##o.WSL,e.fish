# Loads /etc/environment. Should only be run by wsl, since it does not do it automatically.
set --local ENVS_SET (grep -o '^[^#]*' </etc/environment)

for env_declaration in $ENVS_SET
  set -gx (string split -m 1 '=' $env_declaration)
end
