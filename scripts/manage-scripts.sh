#!/bin/bash

SCRIPTS_DIR="$HOME/Workspace/workstation/scripts"
BIN_DIR="$HOME/.local/bin"

case "$1" in
  list)
    echo "Available scripts:"
    ls -1 "$SCRIPTS_DIR"/*.sh | xargs -I {} basename {} .sh
    ;;
  link)
    if [ -z "$2" ]; then
      echo "Usage: manage-scripts link <script-name>"
      exit 1
    fi
    script_path="$SCRIPTS_DIR/$2.sh"
    if [ -f "$script_path" ]; then
      ln -sf "$script_path" "$BIN_DIR/$2"
      echo "Linked $2"
    else
      echo "Script $2.sh not found"
    fi
    ;;
  create)
    if [ -z "$2" ]; then
      echo "Usage: manage-scripts create <script-name>"
      exit 1
    fi
    script_path="$SCRIPTS_DIR/$2.sh"
    echo "#!/bin/bash" > "$script_path"
    echo "# $2 script" >> "$script_path"
    chmod +x "$script_path"
    echo "Created $script_path"
    echo "Edit with: code $script_path"
    ;;
  *)
    echo "Usage: manage-scripts {list|link|create} [script-name]"
    ;;
esac
