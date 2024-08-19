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

