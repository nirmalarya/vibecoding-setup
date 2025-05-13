# AI Dev Setup - Configuration Details

## Model Configuration

### Installed Models

| GGUF File | Ollama Name | Size | Purpose |
|-----------|-------------|------|---------|
| codellama-7b-instruct-q4_k_m.gguf | codellama-7b | 4.1GB | Code completion |
| deepseek-r1-distill-qwen-1.5b-q4_k_m.gguf | deepseek-r1 | 1.1GB | Reasoning |
| gemma-3-4b-instruct-q4_k_m.gguf | gemma3-4b | 2.5GB | General purpose |
| llama-3.2-3b-instruct-q4_k_m.gguf | llama32-3b | 2.0GB | Fast responses |
| nomic-embed-text-v1.5.Q4_K_S.gguf | nomic-embed-text | 78MB | Embeddings |

### Model Parameters

\`\`\`json
{
  "temperature": 0.7,
  "top_p": 0.95,
  "context_length": {
    "codellama-7b": 4096,
    "deepseek-r1": 4096,
    "gemma3-4b": 8192,
    "llama32-3b": 8192
  }
}
\`\`\`

## Continue.dev Configuration

### Features Enabled
- Multiple context providers
- Custom commands
- Experimental features
- Model-specific roles
- Tab autocomplete
- Codebase indexing

### Context Providers
1. Codebase - Full project search
2. Diff - Git changes
3. Terminal - Command output
4. Docs - Documentation
5. Problems - VS Code issues
6. Folder - Current directory
7. Browser - Web context

### Custom Commands
- \`/docstring\` - Generate documentation
- \`/debug\` - Add debug logging
- \`/types\` - Type annotations
- \`/clean\` - Code cleanup

## VS Code Configuration

### Extensions Installed
- Continue.continue
- GitHub.copilot
- GitHub.copilot-chat
- dbaeumer.vscode-eslint
- esbenp.prettier-vscode

### Key Bindings
\`\`\`json
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
    "command": "github.copilot.acceptCopilotSuggestion"
  }
]
\`\`\`

## Directory Structure

\`\`\`
~/workspace/ai-dev-setup/
├── scripts/              # 15 utility scripts
├── docs/                 # Documentation
├── models/               # Model configs
├── Makefile             # Installation automation
└── distribute.sh        # Package creator

~/localai-models/        # Model files (10GB+)
├── *.gguf               # GGUF model files
└── Modelfile-*          # Ollama configs

~/.continue/             # Continue settings
└── config.json          # Main configuration

~/.local/bin/            # Command symlinks
└── [15 symlinks]        # Quick access commands
\`\`\`

## Environment Variables

Added to shell config:
\`\`\`bash
export PATH="$HOME/.local/bin:$PATH"
export AI_DEV_HOME="$HOME/workspace/ai-dev-setup"

# Aliases
alias ai="dev-dashboard"
alias aistart="dev-start"
alias ainew="create-project"
\`\`\`

## Script Categories

### Core Scripts
- \`dev-start.sh\` - Launch VS Code
- \`create-project.sh\` - Project scaffolding
- \`dev-dashboard.sh\` - Status display
- \`vibe-check.sh\` - Quick check

### AI Management
- \`check-models.sh\` - Verify models
- \`test-ai-models.sh\` - Test responses
- \`manage-scripts.sh\` - Script management

### Service Scripts
- \`start-ollama.sh\` - Ollama service
- \`start-localai.sh\` - LocalAI service

### Setup Scripts
- \`install-scripts.sh\` - Install utilities
- \`setup-continue.sh\` - Configure Continue
- \`setup-vscode.sh\` - VS Code setup
- \`verify-installation.sh\` - Check setup

## Network Considerations

For corporate environments:
- Models can be downloaded manually
- Proxy settings may be needed
- Copilot requires internet
- Continue works offline

## Maintenance

### Regular Tasks
\`\`\`bash
make verify        # Check health
ollama list       # Verify models
vibe-check        # Quick status
\`\`\`

### Updates
\`\`\`bash
cd ~/workspace/ai-dev-setup
git pull          # Update scripts
make install      # Reinstall
\`\`\`

### Troubleshooting
\`\`\`bash
make clean        # Reset symlinks
make models       # Reimport models
ollama serve      # Start service
\`\`\`

## Version Information

- Setup Version: 1.0.0
- Ollama: Latest via Homebrew
- Continue: Latest VS Code extension
- Models: Quantized GGUF format

---

*This document contains technical details for troubleshooting and customization.*
