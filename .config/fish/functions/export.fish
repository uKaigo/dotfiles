# Taken from /usr/share/fish/functions/export.fish
function export --description 'Set env variable. Alias for `set -gx` for bash compatibility.'
    if not set -q argv[1]
        set -x
        return 0
    end
    for arg in $argv
        set -l v (string split -m 1 "=" -- $arg)
        # strip trailing quotes to accomodate 'VAR="value"' as the arg.
        set v[2] (echo $v[2] | sed -e 's/^"//' -e 's/"$//' -e "s/^'//" -e "s/'\$//")
        switch (count $v)
            case 1
                set -gx $v $$v
            case 2
                if contains -- $v[1] PATH CDPATH MANPATH
                    set -l colonized_path (string replace -- "$$v[1]" (string join ":" -- $$v[1]) $v[2])
                    set -gx $v[1] (string split ":" -- $colonized_path)
                else
                    # status is 1 from the contains check, and `set` does not change the status on success: reset it.
                    true
                    set -gx $v[1] $v[2]
                end
        end
    end
end
