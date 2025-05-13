#!/bin/bash

echo "Setting up VS Code extensions..."

# Check if VS Code is installed
if ! command -v code &> /dev/null; then
    echo "VS Code not found"
    echo "Please install from: https://code.visualstudio.com/download"
    exit 1
fi

# Install all required extensions
REQUIRED_EXTENSIONS=(
    "Continue.continue"
    "GitHub.copilot"
    "GitHub.copilot-chat"
    "GitHub.copilot-labs"  # Experimental features
    "GitHub.vscode-pull-request-github"  # PR integration
)

echo "Checking extensions..."
for ext in "${REQUIRED_EXTENSIONS[@]}"; do
    if code --list-extensions | grep -qi "^${ext}$"; then
        echo "✓ $ext already installed"
    else
        echo "Installing $ext..."
        code --install-extension "$ext" --force || {
            if [[ "$ext" == *"labs"* ]]; then
                echo "Note: Copilot Labs may not be available in your region"
            else
                echo "Warning: Failed to install $ext"
            fi
        }
    fi
done

# Check for VS Code settings
VSCODE_SETTINGS="$HOME/.config/Code/User/settings.json"
if [ ! -f "$VSCODE_SETTINGS" ]; then
    echo "Creating VS Code settings..."
    mkdir -p "$(dirname "$VSCODE_SETTINGS")"
    cat > "$VSCODE_SETTINGS" << 'SETTINGS_EOF'
{
  "editor.fontSize": 14,
  "editor.formatOnSave": true,
  "editor.inlineSuggest.enabled": true,
  "github.copilot.enable": {
    "*": true
  },
  "github.copilot.chat.enabled": true,
  "github.copilot.voice.enabled": true,
  "continue.telemetryEnabled": false,
  "continue.enableTabAutocomplete": true,
  "terminal.integrated.fontSize": 14
}
SETTINGS_EOF
else
    echo "VS Code settings already exist"
fi

# Add keybindings for Copilot
KEYBINDINGS="$HOME/.config/Code/User/keybindings.json"
if [ ! -f "$KEYBINDINGS" ]; then
    echo "Creating keybindings..."
    cat > "$KEYBINDINGS" << 'KEYBINDINGS_EOF'
[
  {
    "key": "cmd+l",
    "command": "continue.focusContinueInput"
  },
  {
    "key": "cmd+i",
    "command": "workbench.action.chat.open"
  },
  {
    "key": "tab",
    "command": "github.copilot.acceptCopilotSuggestion",
    "when": "suggestWidgetVisible && github.copilot.activated"
  },
  {
    "key": "cmd+]",
    "command": "editor.action.inlineSuggest.showNext",
    "when": "inlineSuggestionVisible"
  },
  {
    "key": "cmd+[",
    "command": "editor.action.inlineSuggest.showPrevious", 
    "when": "inlineSuggestionVisible"
  }
]
KEYBINDINGS_EOF
fi

echo "✓ VS Code setup complete"
echo ""
echo "Copilot features available:"
echo "- GitHub Copilot (code suggestions)"
echo "- Copilot Chat (AI assistant)"
echo "- Copilot agents (@workspace, @vscode, @terminal)"
echo "- PR integration"
