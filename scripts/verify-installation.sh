#!/bin/bash

echo "🔍 Verifying AI Development Environment..."
echo

CHECKS_PASSED=0
CHECKS_TOTAL=0

check() {
    CHECKS_TOTAL=$((CHECKS_TOTAL + 1))
    if eval "$2"; then
        echo "✅ $1"
        CHECKS_PASSED=$((CHECKS_PASSED + 1))
    else
        echo "❌ $1"
        echo "   Fix: $3"
    fi
}

# Check core tools
check "Homebrew" "command -v brew >/dev/null 2>&1" "Install from https://brew.sh"
check "Ollama" "command -v ollama >/dev/null 2>&1" "brew install ollama"
check "VS Code" "command -v code >/dev/null 2>&1" "Install VS Code"
check "Git" "command -v git >/dev/null 2>&1" "brew install git"

# Check Ollama service
check "Ollama running" "pgrep -x ollama >/dev/null" "ollama serve"

# Check models directory
check "Models directory" "[ -d $HOME/localai-models ]" "Create ~/localai-models"

# Check VS Code extensions
if command -v code >/dev/null 2>&1; then
    check "Continue extension" "code --list-extensions | grep -qi Continue.continue" "code --install-extension Continue.continue"
    check "GitHub Copilot" "code --list-extensions | grep -qi GitHub.copilot" "code --install-extension GitHub.copilot"
    check "Copilot Chat" "code --list-extensions | grep -qi GitHub.copilot-chat" "code --install-extension GitHub.copilot-chat"
fi

# Check specific models
check "CodeLlama in Ollama" "ollama list | grep -q '^codellama-7b'" "Run: make models"
check "DeepSeek in Ollama" "ollama list | grep -q '^deepseek-r1'" "Run: make models"

# Check scripts and config
check "Scripts directory" "[ -d $HOME/workspace/ai-dev-setup/scripts ]" "Scripts missing"
check "Dev-start symlink" "[ -L $HOME/.local/bin/dev-start ]" "Run: make symlinks"
check "Continue config" "[ -f $HOME/.continue/config.json ]" "Run: make continue"

echo
echo "Results: $CHECKS_PASSED/$CHECKS_TOTAL checks passed"

# Show feature summary
echo
echo "🤖 AI Features Status:"
echo "━━━━━━━━━━━━━━━━━━━━"
echo "Local AI (Continue):"
ollama list | grep -E "codellama|deepseek|gemma|llama" | awk '{printf "  • %-20s %s\n", $1, $2}' || echo "  No models loaded"
echo
echo "Cloud AI (Copilot):"
if code --list-extensions | grep -qi GitHub.copilot; then
    echo "  • GitHub Copilot     ✓ Installed"
    echo "  • Copilot Chat       ✓ Installed"
    echo "  • Agents available   @workspace, @vscode, @terminal"
else
    echo "  • GitHub Copilot     ✗ Not installed"
fi
echo "━━━━━━━━━━━━━━━━━━━━"
