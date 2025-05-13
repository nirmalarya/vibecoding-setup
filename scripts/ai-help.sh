#!/bin/bash

if [ -z "$1" ]; then
    echo "🤖 AI Development Tools Help"
    echo "==========================="
    echo
    echo "Usage: ai-help <command>"
    echo
    echo "Available commands:"
    echo "  dev-start        - Start development environment"
    echo "  create-project   - Create new project with AI assistance"
    echo "  vibe-check       - Verify AI coding setup"
    echo "  test-continue    - Test Continue.dev integration"
    echo "  code-with-certs  - VS Code with certificate support"
    echo "  manage-scripts   - Script management utility"
    echo
    echo "For detailed help: ai-help <command>"
    exit 0
fi

case "$1" in
    "dev-start")
        echo "🚀 dev-start - Development Environment Starter"
        echo "Description: Starts Ollama, LocalAI, and VS Code"
        echo "Usage: dev-start [path]"
        echo "Examples:"
        echo "  dev-start          # Start in current directory"
        echo "  dev-start ~/myapp  # Start in specific directory"
        ;;
    "create-project")
        echo "📁 create-project - AI-Ready Project Generator"
        echo "Description: Creates a new project with git and opens in VS Code"
        echo "Usage: create-project <name> [type]"
        echo "Types: node, react, python, go"
        echo "Examples:"
        echo "  create-project my-api node"
        echo "  create-project my-app react"
        ;;
    "vibe-check")
        echo "✅ vibe-check - Setup Verification"
        echo "Description: Checks if all AI tools are properly configured"
        echo "Usage: vibe-check"
        echo "Checks:"
        echo "  - Ollama installation and models"
        echo "  - LocalAI status"
        echo "  - VS Code extensions"
        echo "  - Continue.dev configuration"
        echo "  - GitHub Copilot"
        ;;
    "test-continue")
        echo "🧪 test-continue - Continue.dev Tester"
        echo "Description: Tests Continue.dev setup and embeddings"
        echo "Usage: test-continue"
        echo "Tests:"
        echo "  - Model availability"
        echo "  - Embedding functionality"
        echo "  - VS Code integration"
        ;;
    "code-with-certs")
        echo "🔐 code-with-certs - VS Code with Certificates"
        echo "Description: Launches VS Code with proper SSL certificates"
        echo "Usage: code-with-certs [path]"
        echo "Useful for: Corporate networks, proxy environments"
        ;;
    "manage-scripts")
        echo "📝 manage-scripts - Script Manager"
        echo "Description: Create, link, and manage custom scripts"
        echo "Usage: manage-scripts {list|link|create} [name]"
        echo "Examples:"
        echo "  manage-scripts list"
        echo "  manage-scripts create my-tool"
        echo "  manage-scripts link my-tool"
        ;;
    *)
        echo "Unknown command: $1"
        echo "Use 'ai-help' to see available commands"
        ;;
esac
