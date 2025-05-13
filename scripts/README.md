# Development Scripts

This directory contains useful scripts for my development environment.

## Available Scripts

- `vscode-with-certs.sh` - Launch VS Code with proper certificates
- `start-ollama.sh` - Start Ollama AI service
- `start-localai.sh` - Start LocalAI service
- `test-ai-models.sh` - Test all AI models
- `manage-scripts.sh` - Manage these scripts

## Usage

All scripts are symlinked to `~/.local/bin` for easy access:

```bash
# Start VS Code with certificates
code-with-certs

# Start AI services
start-ollama
start-localai

# List all scripts
manage-scripts list

# Create a new script
manage-scripts create my-new-script
