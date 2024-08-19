if [ $# -eq 0 ]; then
    printf "Choose a cookiecutter template!\\n\\n"
    echo "Options:"
    for TEMPLATE in "$COOKIECUTTER_DIR"/*; do
        TEMPLATE=$(basename "$TEMPLATE")
        echo "  - ${TEMPLATE}"
    done
    exit 1
else
    CHOSEN_TEMPLATE="$1"
    echo "$COOKIECUTTER_DIR"
    cookiecutter "$COOKIECUTTER_DIR/$CHOSEN_TEMPLATE"
fi

_complete_templates() {
    local cur opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    opts=()

    if [[ -d "$COOKIECUTTER_DIR" ]]; then
        opts=("$COOKIECUTTER_DIR"/*)
        opts=("${opts[@]##*/}")
    fi

    COMPREPLY=( "$(compgen -W "${opts[*]}" -- "${cur}")" )
    return 0
}

complete -F _complete_templates cookiecutter

