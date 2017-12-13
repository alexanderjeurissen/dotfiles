##
## syntastic.kak by lenormf
## Auto lint (and optionally format) your code on write
##

decl bool syntastic_autoformat no

def -params 2..3 \
    -docstring %{syntastic-declare-filetype <filetype> <lintcmd> <formatcmd>: automatically lint and/or format buffers on write} \
    syntastic-declare-filetype %{ %sh{
    readonly filetype="$1"

    printf 'hook global WinSetOption filetype=%s %%{\n' "${filetype}"

    if [ $# -gt 2 ] && [ -n "$3" ]; then
        printf 'hook buffer BufWritePre "\Q%%val{buffile}" %%{ %%sh{
            if [ "${kak_opt_syntastic_autoformat}" = true ]; then
                if [ -z "${kak_opt_formatcmd}" ]; then
                    printf "set buffer formatcmd \\"%%s\\"\\\\n" "%s"
                fi
                echo format
            fi
        } }\n' "$(printf %s "$3" | sed -e 's/"/\\\\\\"/g' -e 's/%/\\\\%/g')"
    fi

    echo '
        lint-enable
        hook buffer BufWritePost "\Q%val{buffile}" %{
    '

    if [ -n "$2" ]; then
        printf '%%sh{
            if [ -z "${kak_opt_lintcmd}" ]; then
                printf "set window lintcmd \\"%%s\\"\\\\n" "%s"
            fi
        }\n' "$(printf %s "$2" | sed -e 's/"/\\\\\\"/g' -e 's/%/\\\\%/g')"
    fi

    echo 'lint } }'
} }

syntastic-declare-filetype "c" \
    'cppcheck --language=c --enable=all --template="{file}:{line}:1: {severity}: {message}" 2>&1' \
    'clang-format'

syntastic-declare-filetype "cpp" \
    'cppcheck --language=c++ --enable=all --template="{file}:{line}:1: {severity}: {message}" 2>&1' \
    'clang-format'

## FIXME: `dscanner` hasn't been tested
syntastic-declare-filetype "d" \
    'dscanner' \
    'dfmt'

## FIXME: `gometalinter` only takes directories as argument, create a wrapper
syntastic-declare-filetype "go" \
    'gometalinter' \
    'gofmt -e -s'

syntastic-declare-filetype "python" \
    'flake8 --filename=* --format="%(path)s:%(row)d:%(col)d: error: %(text)s"' \
    'autopep8 -'

syntastic-declare-filetype "sh" \
    'shellcheck -fgcc -Cnever'

syntastic-declare-filetype "ruby" \
    'bundle exec rubocop --format emacs'
