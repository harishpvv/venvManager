envm() { 
    if [[ "$1" == "a" && -n "$2" ]]; then
        # Activate environment
        local name="$2"
        local env_path="$HOME/.venvs/$name"

        if [[ ! -f "$env_path/bin/activate" ]]; then
            echo "❌ No such environment: $name"
            return 1
        fi

        # Deactivate current venv if active
        if [[ -n "$VIRTUAL_ENV" ]]; then
            deactivate 2>/dev/null
        fi

        # Source the new venv
        source "$env_path/bin/activate"
        echo "✅ Activated '$name'"

    elif [[ "$1" == "c" && -n "$2" ]]; then
        # Create environment
        local name="$2"
        shift 2
        local info="$*"
        local env_path="$HOME/.venvs/$name"

        if [[ -d "$env_path" ]]; then
            echo "❌ Environment '$name' already exists."
            return 1
        fi

        python3 -m venv "$env_path"
        [[ -n "$info" ]] && echo "$info" > "$env_path/.info"
        echo "✅ Created venv '$name'"

    elif [[ "$1" == "l" ]]; then
        # List all venvs (no active column)
        printf "%-20s %s\n" "NAME" "INFO"
        echo "------------------------------------------------------------"
        for d in "$HOME/.venvs"/*/; do
            [[ -d "$d" ]] || continue
            local name=$(basename "$d")
            local info=""
            [[ -f "$d/.info" ]] && info=$(<"$d/.info")
            printf "%-20s %s\n" "$name" "$info"
        done

    elif [[ "$1" == "D" || "$1" == "d" ]]; then
        # Delete environments
        if [[ $2 == "all" ]]; then
            # Delete all venvs
            for env_path in "$HOME/.venvs"/*/; do
                [[ -d "$env_path" ]] || continue
                name=$(basename "$env_path")
                rm -rf "$env_path"
                echo "🗑️ Deleted '$name'"
            done
        else
            shift
            if [[ $# -eq 1 ]]; then
                echo "Usage: envm d name1 [name2 ...] or envm d all"
                return 1
            fi

            for name in "$@"; do
                env_path="$HOME/.venvs/$name"
                if [[ ! -d "$env_path" ]]; then
                    echo "❌ No such environment: $name"
                    continue
                fi
                rm -rf "$env_path"
                echo "🗑️ Deleted '$name'"
            done
        fi

    elif [[ "$1" == "i" && -n "$2" ]]; then
        # Change info
        local name="$2"
        shift 2
        local info="$*"
        local env_path="$HOME/.venvs/$name"

        if [[ ! -d "$env_path" ]]; then
            echo "❌ No such environment: $name"
            return 1
        fi

        echo "$info" > "$env_path/.info"
        echo "✏️ Updated info for '$name'"

    else
        echo "Usage: envm [a|c|l|d|i] ..."
        echo "a name        Activate venv"
        echo "c name info   Create venv with optional info"
        echo "l             List all venvs"
        echo "d name.../all Delete one, multiple, or all venvs"
        echo "i name info   Update info for venv"
    fi
}
