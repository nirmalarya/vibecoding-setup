# AI Development Environment for macOS

Complete AI-powered development environment with local LLMs, VS Code integration, GitHub Copilot, and custom productivity tools.

## 🚀 Quick Start

\`\`\`bash
# Install everything
make install

# Verify installation
make verify

# Check status
vibe-check
\`\`\`

## 📋 What's Included

### AI Models (Local)
- **CodeLlama 7B** (\`codellama-7b\`) - Code generation and completion
- **DeepSeek R1 1.5B** (\`deepseek-r1\`) - Advanced reasoning 
- **Gemma 3 4B** (\`gemma3-4b\`) - General purpose model
- **Llama 3.2 3B** (\`llama32-3b\`) - Fast responses
- **Nomic Embed** (\`nomic-embed-text\`) - Text embeddings for code search

### Development Tools
- **Ollama** - Local LLM runtime
- **VS Code** - Configured with AI extensions
- **Continue.dev** - AI-powered coding assistant (local)
- **GitHub Copilot** - Cloud-based code suggestions
- **Custom Scripts** - 15 productivity tools

### Key Features
- 🔒 Privacy-first with local models
- 🌐 Cloud AI when needed (Copilot)
- 🛠️ Custom automation scripts
- 📊 Development dashboard
- 🚀 Quick project scaffolding

## 💾 System Requirements

- **macOS**: Monterey (12.0) or later
- **Processor**: Apple Silicon (M1-M4) or Intel
- **RAM**: 8GB minimum, 16GB recommended
- **Storage**: 15GB for models
- **Tools**: Homebrew, Git

## 📦 Installation

### Complete Installation
\`\`\`bash
make install
\`\`\`

### Individual Components
\`\`\`bash
make models      # Install AI models
make scripts     # Install utility scripts  
make vscode      # Setup VS Code
make continue    # Configure Continue.dev
\`\`\`

### Verify Installation
\`\`\`bash
make verify      # Detailed check
vibe-check       # Quick status
\`\`\`

## 🛠️ Available Commands

### Core Commands
- \`dev-start [path]\` - Start VS Code with AI
- \`create-project <name> [type]\` - Create new project (node/react/python/go)
- \`dev-dashboard\` or \`ai\` - Show system status
- \`vibe-check\` - Quick environment check

### AI Commands
- \`ai-help [command]\` - Get help for any command
- \`test-ai-models\` - Test model responses
- \`manage-scripts\` - Manage utility scripts

### Service Commands
- \`start-ollama\` - Start Ollama service
- \`start-localai\` - Start LocalAI service

## ⌨️ VS Code Integration

### Continue.dev (Local AI)
- \`Cmd+L\` - Open Continue chat
- \`@codebase\` - Search entire project
- \`/explain\` - Explain selected code
- \`/refactor\` - Refactor code
- \`/test\` - Generate tests

### GitHub Copilot (Cloud AI)
- \`Cmd+I\` - Open Copilot Chat
- \`Tab\` - Accept suggestion
- \`@workspace\` - Ask about codebase
- \`/fix\` - Fix code issues
- \`/generate\` - Generate code

## 📁 Directory Structure

```
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
```

## 🎯 Usage Examples

### Create New Project
\`\`\`bash
create-project my-api node
create-project my-app react
create-project ml-tool python
\`\`\`

### Using AI Chat
\`\`\`bash
# In VS Code
Cmd+L              # Continue (local)
@codebase find auth functions
/explain this function

Cmd+I              # Copilot (cloud)
@workspace what does the API do?
/generate REST endpoint
\`\`\`

### Quick Checks
\`\`\`bash
vibe-check         # System status
ollama list        # Installed models
ai-help            # Command help
\`\`\`

## 🔄 Updating

\`\`\`bash
cd ~/workspace/ai-dev-setup
git pull           # If using git
make install       # Update everything
\`\`\`

## 📦 Distribution

\`\`\`bash
./distribute.sh    # Create package
# Creates ai-dev-setup-latest.zip
\`\`\`

## 🚨 Troubleshooting

### Common Issues

1. **Ollama not running**
   \`\`\`bash
   ollama serve     # Start manually
   make verify      # Check status
   \`\`\`

2. **Models not loaded**
   \`\`\`bash
   make models      # Re-import models
   ollama list      # Check loaded models
   \`\`\`

3. **VS Code extensions missing**
   \`\`\`bash
   make vscode      # Reinstall extensions
   \`\`\`

4. **Symlinks broken**
   \`\`\`bash
   make clean       # Remove old links
   make symlinks    # Create new ones
   \`\`\`

## 📊 Model Information

| Model | Size | Purpose | Context |
|-------|------|---------|---------|
| CodeLlama 7B | 4.1GB | Code completion | 4096 |
| DeepSeek R1 | 1.1GB | Reasoning | 4096 |
| Gemma 3 4B | 2.5GB | General | 8192 |
| Llama 3.2 3B | 2.0GB | Fast chat | 8192 |
| Nomic Embed | 78MB | Embeddings | - |

## 🔐 Privacy & Security

- Local models run entirely on your machine
- No code sent to cloud (except Copilot when used)
- Continue.dev telemetry disabled
- All data stays local

## 📚 Documentation

- [AI Features Guide](docs/AI_FEATURES.md) - Detailed AI usage
- [Quick Reference](docs/QUICKREF.md) - Keyboard shortcuts
- [Setup Info](SETUP_INFO.md) - Configuration details

## 🤝 Contributing

Feel free to submit issues or pull requests to improve the setup.

## 📝 License

MIT License - Use freely!

---

**Happy AI-Powered Coding! 🚀**
