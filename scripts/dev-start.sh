#!/bin/bash

echo "🚀 Starting Development Environment..."

# Start Ollama if not running
if ! pgrep -x "ollama" > /dev/null; then
    echo "Starting Ollama..."
    ollama serve &
    sleep 3
fi

# List available models
echo -e "\n📦 Available AI Models:"
ollama list

# Start LocalAI in background if needed
if ! curl -s http://localhost:8080/readyz > /dev/null; then
    echo -e "\nStarting LocalAI (optional)..."
    cd ~/localai-models && localai run --models-path . --address :8080 &
    sleep 3
fi

# Open VS Code
echo -e "\n💻 Opening VS Code..."
code-with-certs "$@"

echo -e "\n✅ Development environment ready!"
echo "Tips:"
echo "  • Cmd+L: Open Continue chat"
echo "  • Tab: Accept Copilot suggestions"
echo "  • Cmd+I: Open Copilot chat"
echo "  • @codebase: Search your code with Continue"
