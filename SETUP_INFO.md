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

```json
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
```

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
- `/docstring` - Generate documentation
- `/debug` - Add debug logging
- `/types` - Type annotations
- `/clean` - Code cleanup

## VS Code Configuration

### Extensions Installed
- Continue.continue
- GitHub.copilot
- GitHub.copilot-chat
- dbaeumer.vscode-eslint
- esbenp.prettier-vscode

### Key Bindings
```json
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
```

## Directory Structure

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

## Environment Variables

Added to shell config:
```bash
export PATH="$HOME/.local/bin:$PATH"
export AI_DEV_HOME="$HOME/workspace/ai-dev-setup"

# Aliases
alias ai="dev-dashboard"
alias aistart="dev-start"
alias ainew="create-project"
```

## Script Categories

### Core Scripts
- `dev-start.sh` - Launch VS Code
- `create-project.sh` - Project scaffolding
- `dev-dashboard.sh` - Status display
- `vibe-check.sh` - Quick check

### AI Management
- `check-models.sh` - Verify models
- `test-ai-models.sh` - Test responses
- `manage-scripts.sh` - Script management

### Service Scripts
- `start-ollama.sh` - Ollama service
- `start-localai.sh` - LocalAI service

### Setup Scripts
- `install-scripts.sh` - Install utilities
- `setup-continue.sh` - Configure Continue
- `setup-vscode.sh` - VS Code setup
- `verify-installation.sh` - Check setup

## Network Considerations

For corporate environments:
- Models can be downloaded manually
- Proxy settings may be needed
- Copilot requires internet
- Continue works offline

## Maintenance

### Regular Tasks
```bash
make verify        # Check health
ollama list       # Verify models
vibe-check        # Quick status
```

### Updates
```bash
cd ~/workspace/ai-dev-setup
git pull          # Update scripts
make install      # Reinstall
```

### Troubleshooting
```bash
make clean        # Reset symlinks
make models       # Reimport models
ollama serve      # Start service
```

## Version Information

- Setup Version: 1.0.0
- Ollama: Latest via Homebrew
- Continue: Latest VS Code extension
- Models: Quantized GGUF format

---

*This document contains technical details for troubleshooting and customization.*

---

# AI Development Environment Setup Information

This document provides detailed information about the configuration and setup of the AI development environment.

## System Configuration

### Environment Variables

The following environment variables are automatically set during installation:

```bash
OLLAMA_HOST=127.0.0.1:11434
OLLAMA_MODELS_PATH=~/.ollama/models
CONTINUE_DEV_CONFIG=~/.config/continue/config.json
```

### Installation Details

The installation process (`make install`) performs the following operations:

1. Installs Homebrew packages (if not already installed)
2. Sets up Ollama runtime
3. Downloads and imports AI models
4. Configures VS Code with recommended extensions
5. Sets up Continue.dev with local model configuration
6. Creates utility scripts and adds them to PATH
7. Configures environment variables

## Directory Structure Details

```
ai-dev-setup/
├── .devcontainer/           # Development container configuration
│   └── devcontainer.json    # Container configuration file
├── .github/                 # GitHub related configurations
│   └── workflows/           # GitHub Actions workflows
│       └── ci.yml           # CI/CD workflow definition
├── scripts/                 # Utility scripts
│   ├── docker/              # Docker related scripts
│   │   └── nvidia.sh        # NVIDIA setup script
│   ├── setup.sh             # General setup script
│   ├── ubuntu-setup.sh      # Ubuntu specific setup
│   ├── macos-setup.sh       # macOS specific setup
│   ├── dev-start            # VS Code launcher script
│   ├── vibe-check           # Environment status checker
│   ├── ai-help              # Command help utility
│   ├── create-project       # Project scaffolding utility
│   └── dev-dashboard        # Development dashboard launcher
├── dotfiles/                # Configuration dotfiles
│   ├── .bashrc              # Bash configuration
│   ├── .zshrc               # Zsh configuration
│   ├── .gitconfig           # Git configuration
│   └── .vimrc               # Vim configuration
├── configs/                 # Application configurations
│   ├── vscode/              # VSCode configurations
│   │   ├── settings.json    # VSCode settings
│   │   └── extensions.json  # Recommended extensions
│   ├── continue/            # Continue.dev configurations
│   │   └── config.json      # Continue config with local models
│   └── jupyter/             # Jupyter configurations
│       └── jupyter_notebook_config.py
├── models/                  # Model configuration files
│   ├── codellama.yaml       # CodeLlama model config
│   ├── deepseek.yaml        # DeepSeek model config
│   ├── gemma.yaml           # Gemma model config
│   ├── llama.yaml           # Llama model config
│   └── nomic.yaml           # Nomic Embed model config
├── environments/            # Environment definitions
│   ├── requirements.txt     # Python package requirements
│   └── environment.yml      # Conda environment definition
├── docs/                    # Documentation
│   ├── AI_FEATURES.md       # Detailed AI usage documentation
│   └── QUICKREF.md          # Quick reference guide
├── Makefile                 # Installation and management commands
├── SETUP_INFO.md            # This file
└── README.md                # Main documentation file
```

## Configuration Details

### VS Code Extensions

The environment automatically installs these key extensions:

- GitHub Copilot
- GitHub Copilot Chat
- Continue.dev
- Jupyter
- Python
- Docker
- Remote - Containers
- GitLens

### Continue.dev Configuration

Continue.dev is configured to use local models via Ollama with this priority:

1. `codellama-7b` (code generation)
2. `llama32-3b` (fast responses)  
3. `gemma3-4b` (general knowledge)

### Model Specifications

| Model | RAM Usage | Disk Size | Startup Time | Response Time |
|-------|----------|-----------|--------------|--------------|
| CodeLlama 7B | ~2.5GB | 4.1GB | ~3s | 0.5-2s |
| DeepSeek R1 | ~1GB | 1.1GB | ~1s | 0.3-1s |
| Gemma 3 4B | ~2GB | 2.5GB | ~2s | 0.5-1.5s |
| Llama 3.2 3B | ~1.5GB | 2.0GB | ~1.5s | 0.4-1.2s |
| Nomic Embed | ~100MB | 78MB | <1s | <0.1s |

## Path Configuration

During installation, the following paths are added to your system PATH:

```bash
export PATH="$PATH:$HOME/workspace/ai-dev-setup/scripts"
```

## Makefile Commands

The Makefile provides these commands:

- `make install` - Install everything
- `make verify` - Verify installation
- `make models` - Install AI models
- `make scripts` - Install utility scripts
- `make vscode` - Configure VS Code
- `make continue` - Configure Continue.dev
- `make clean` - Remove temporary files
- `make symlinks` - Create symlinks to scripts
- `make uninstall` - Remove everything
