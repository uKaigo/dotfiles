# Loads /etc/environment. Should only be run by wsl, since it does not do it automatically.
set --local ENVS_SET (cat /etc/environment | grep -o '^[^#]*')

for env_dec in $ENVS_SET
  set -gx (string split '=' $env_dec)
end
