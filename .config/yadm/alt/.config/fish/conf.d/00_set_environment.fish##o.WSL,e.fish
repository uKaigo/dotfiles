# Loads /etc/environment. Should only be run by wsl, since it does not do it automatically.
set data (grep -o '^[^#]*' </etc/environment)

test -n $data && export $data

for file in /etc/environment.d/*
    set data (grep -o '^[^#]*' <$file)
    test -n $data && export $data
end
