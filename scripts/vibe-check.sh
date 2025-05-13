#!/bin/bash

echo "🚀 Vibecoding Setup Check"
echo "========================"

# Check Ollama
echo -n "✓ Ollama: "
if ollama list &>/dev/null; then
  model_count=$(ollama list | tail -n +2 | wc -l)
  echo "Running ($model_count models)"
else
  echo "Not running"
fi

# Check VS Code
echo -n "✓ VS Code: "
if command -v code > /dev/null 2>&1; then
  echo "Installed"
else
  echo "Not installed"
fi

# Check Continue
echo -n "✓ Continue: "
if code --list-extensions 2>/dev/null | grep -qi continue.continue; then
  echo "Installed"
else
  echo "Not installed"
fi

# Check Scripts
echo -n "✓ Scripts: "
scripts_dir="$HOME/workspace/ai-dev-setup/scripts"
if [ -d "$scripts_dir" ]; then
  script_count=$(ls -1 $scripts_dir/*.sh | wc -l)
  echo "Installed ($script_count scripts)"
else
  echo "Not found"
fi

# Check symlinks
echo -n "✓ Symlinks: "
symlink_count=$(ls -la ~/.local/bin | grep -E "dev-|ai-|create-" | wc -l)
echo "$symlink_count configured"

echo "========================"
echo "Ready to vibe! 🎉"
