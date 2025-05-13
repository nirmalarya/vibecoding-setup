#!/bin/bash

echo "Setting up Continue.dev..."

mkdir -p ~/.continue

# Check if Continue config already exists and is valid
if [ -f ~/.continue/config.json ]; then
    echo "Found existing Continue config"
    
    # Verify it has the right models
    if grep -q "codellama-7b" ~/.continue/config.json && \
       grep -q "deepseek-r1" ~/.continue/config.json && \
       grep -q "gemma3-4b" ~/.continue/config.json && \
       grep -q "llama32-3b" ~/.continue/config.json; then
        echo "✓ Continue.dev already configured with correct models"
        exit 0
    else
        echo "Config exists but may need updating"
        cp ~/.continue/config.json ~/.continue/config.json.backup
    fi
fi

# Use the same config as your existing setup
cat > ~/.continue/config.json << 'CONTINUE_CONFIG'
{
  "models": [
    {
      "model": "codellama-7b",
      "title": "CodeLlama 7B",
      "provider": "ollama",
      "contextLength": 4096
    },
    {
      "model": "deepseek-r1",
      "title": "DeepSeek R1",
      "provider": "ollama",
      "contextLength": 4096
    },
    {
      "model": "gemma3-4b",
      "title": "Gemma 3 4B",
      "provider": "ollama",
      "contextLength": 8192
    },
    {
      "model": "llama32-3b",
      "title": "Llama 3.2 3B",
      "provider": "ollama",
      "contextLength": 8192
    }
  ],
  "tabAutocompleteModel": {
    "model": "codellama-7b",
    "title": "CodeLlama 7B",
    "provider": "ollama"
  },
  "embeddingsProvider": {
    "provider": "ollama",
    "model": "nomic-embed-text"
  },
  "contextProviders": [
    {
      "name": "codebase",
      "params": {
        "nRetrieve": 20,
        "nFinal": 5,
        "useReranking": true,
        "displayName": "Codebase"
      }
    },
    {
      "name": "diff",
      "params": {
        "displayName": "Git Diff"
      }
    },
    {
      "name": "terminal",
      "params": {
        "displayName": "Terminal Output"
      }
    },
    {
      "name": "docs",
      "params": {
        "displayName": "Documentation"
      }
    },
    {
      "name": "problems",
      "params": {
        "displayName": "VS Code Problems"
      }
    },
    {
      "name": "folder",
      "params": {
        "displayName": "Current Folder"
      }
    },
    {
      "name": "browser",
      "params": {
        "displayName": "Browser Context"
      }
    }
  ],
  "slashCommands": [
    {
      "name": "edit",
      "description": "Edit selected code"
    },
    {
      "name": "comment",
      "description": "Add comments to code"
    },
    {
      "name": "share",
      "description": "Share code to Continue"
    },
    {
      "name": "cmd",
      "description": "Generate a shell command"
    },
    {
      "name": "test",
      "description": "Generate tests for code"
    },
    {
      "name": "explain",
      "description": "Explain how code works"
    },
    {
      "name": "refactor",
      "description": "Refactor code"
    },
    {
      "name": "optimize",
      "description": "Optimize code for performance"
    }
  ],
  "customCommands": [
    {
      "name": "docstring",
      "description": "Generate docstring",
      "prompt": "Generate a comprehensive docstring for this function/class"
    },
    {
      "name": "debug",
      "description": "Add debug logging",
      "prompt": "Add helpful debug logging to this code"
    },
    {
      "name": "types",
      "description": "Add type annotations",
      "prompt": "Add comprehensive type annotations to this code"
    },
    {
      "name": "clean",
      "description": "Clean up code",
      "prompt": "Clean up this code: fix formatting, remove unused imports, improve variable names"
    }
  ],
  "allowAnonymousTelemetry": false,
  "experimental": {
    "contextMenuCommands": true,
    "quickActions": true,
    "codebaseIndexing": true,
    "modelRoles": {
      "inlineEdit": "codellama-7b",
      "applyCodeBlock": "codellama-7b",
      "repoMapGeneration": "gemma3-4b",
      "editAutoDetectPromptTemplate": "llama32-3b"
    }
  },
  "ui": {
    "fontSize": 14,
    "theme": "dark",
    "diffViewMode": "split"
  },
  "analytics": {
    "provider": "none"
  }
}
CONTINUE_CONFIG

echo "✓ Continue.dev configured"
