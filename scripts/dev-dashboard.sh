#!/bin/bash

clear
echo "🚀 AI Development Dashboard"
echo "=========================="
echo
echo "📦 Models Status:"
ollama list | grep -E "(codellama|deepseek|gemma|llama32|nomic)" || echo "No models loaded"
echo
echo "🔧 Services:"
echo -n "Ollama: "
pgrep -x "ollama" > /dev/null && echo "✓ Running" || echo "✗ Stopped"
echo -n "LocalAI: "
curl -s http://localhost:8080/readyz > /dev/null && echo "✓ Running" || echo "✗ Stopped"
echo -n "VS Code: "
if pgrep -f "Visual Studio Code" > /dev/null || pgrep -f "Code Helper" > /dev/null || ps aux | grep -v grep | grep -q "Applications/Visual Studio Code"; then
    echo "✓ Running"
else
    echo "✗ Stopped"
fi
echo
echo "🛠️  Available Scripts:"
echo "  dev-start        - Start development environment with VS Code"
echo "  create-project   - Create new project (node/react/python/go)"
echo "  vibe-check       - Check complete AI coding setup"
echo "  test-continue    - Test Continue.dev configuration"
echo "  dev-dashboard    - Show this dashboard"
echo "  manage-scripts   - Manage custom scripts"
echo
echo "🧠 AI Tools:"
echo "  code-with-certs  - Launch VS Code with certificates"
echo "  start-ollama     - Start Ollama AI service"
echo "  start-localai    - Start LocalAI service"
echo "  test-ai-models   - Test all AI models"
echo
echo "⌨️  VS Code Shortcuts:"
echo "  Cmd+L            - Open Continue chat"
echo "  Cmd+I            - Open GitHub Copilot"
echo "  Tab              - Accept Copilot suggestion"
echo "  @codebase        - Search entire project with AI"
echo
echo "🔥 Git AI Commands:"
echo "  git ai-commit    - Generate commit message with AI"
echo "  git ai-review    - Review staged changes with AI"
echo
echo "📚 Documentation:"
echo "  ~/workspace/ai-dev-setup/README.md"
echo "  ~/workspace/ai-dev-setup/SETUP_INFO.md"
echo "  ~/workspace/ai-dev-setup/docs/AI_FEATURES.md"
echo "  ~/workspace/ai-dev-setup/docs/CHEATSHEETS.md"
echo "  ~/workspace/ai-dev-setup/docs/QUICKREF.md"
echo "  ~/workspace/ai-dev-setup/docs/CORPORATE_CERTIFICATES.md"
echo "=========================="
echo
echo "💡 Quick Start: Type 'create-project my-app' to begin!"


