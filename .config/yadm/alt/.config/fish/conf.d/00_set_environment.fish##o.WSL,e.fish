# Loads /etc/environment. Should only be run by wsl, since it does not do it automatically.
export (grep -o '^[^#]*' </etc/environment)

for file in /etc/environment.d/*
    export (grep -o '^[^#]*' <$file)
end
