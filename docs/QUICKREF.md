# Quick Reference Guide

## Command Line Tools

### Core Commands

| Command | Description | Example |
|---------|-------------|---------|
| `dev-start [path]` | Start VS Code with AI | `dev-start ~/projects/myapp` |
| `create-project <name> [type]` | Create new project | `create-project myapi node` |
| `dev-dashboard` or `ai` | Show system status | `ai` |
| `vibe-check` | Quick environment check | `vibe-check` |

### AI Commands

| Command | Description | Example |
|---------|-------------|---------|
| `ai-help [command]` | Get help for any command | `ai-help create-project` |
| `test-ai-models` | Test model responses | `test-ai-models` |
| `manage-scripts` | Manage utility scripts | `manage-scripts` |

### Service Commands

| Command | Description | Example |
|---------|-------------|---------|
| `start-ollama` | Start Ollama service | `start-ollama` |
| `start-localai` | Start LocalAI service | `start-localai` |
| `ollama list` | List installed models | `ollama list` |
| `ollama pull [model]` | Download a model | `ollama pull codellama:7b` |
| `ollama run [model]` | Run a model | `ollama run codellama:7b` |

### Makefile Commands

| Command | Description | Example |
|---------|-------------|---------|
| `make install` | Install everything | `make install` |
| `make verify` | Verify installation | `make verify` |
| `make models` | Install AI models | `make models` |
| `make scripts` | Install utility scripts | `make scripts` |
| `make vscode` | Setup VS Code | `make vscode` |
| `make continue` | Configure Continue.dev | `make continue` |
| `make clean` | Remove temporary files | `make clean` |

## VS Code Keyboard Shortcuts

### Continue.dev (Local AI)

| Shortcut | Description |
|----------|-------------|
| `Cmd+L` | Open Continue chat |
| `Cmd+Shift+L` | Send selection to Continue |
| `Cmd+Alt+L` | Generate code in current position |

#### Continue Commands

| Command | Description |
|---------|-------------|
| `@codebase [query]` | Search entire project |
| `/explain` | Explain selected code |
| `/refactor` | Refactor code |
| `/test` | Generate tests |
| `/fix` | Fix code issues |
| `/document` | Generate documentation |
| `/improve` | Suggest improvements |

### GitHub Copilot (Cloud AI)

| Shortcut | Description |
|----------|-------------|
| `Cmd+I` | Open Copilot Chat |
| `Tab` | Accept suggestion |
| `Cmd+]` | Next suggestion |
| `Cmd+[` | Previous suggestion |
| `Esc` | Dismiss suggestion |

#### Copilot Chat Commands

| Command | Description |
|---------|-------------|
| `@workspace [query]` | Ask about codebase |
| `/fix` | Fix code issues |
| `/explain` | Explain code |
| `/tests` | Generate tests |
| `/doc` | Generate documentation |

## Model Selection Guide

| Task | Recommended Model | Activation |
|------|------------------|------------|
| Code generation | `codellama-7b` | Default in VS Code |
| Quick responses | `llama32-3b` | Default in terminal |
| General knowledge | `gemma3-4b` | Available in Continue |
| Complex reasoning | `deepseek-r1` | Available in Continue |
| Code search | `nomic-embed-text` | Used automatically |

## Project Types

| Type | Languages | Frameworks | Command |
|------|-----------|------------|---------|
| `node` | JavaScript/TypeScript | Express, Node.js | `create-project myapi node` |
| `react` | JavaScript/TypeScript | React | `create-project myapp react` |
| `python` | Python | Flask, FastAPI | `create-project myservice python` |
| `go` | Go | Gin, Echo | `create-project mytools go` |

## Common Tasks

### Testing AI Models

```bash
test-ai-models
```

This will run a standard prompt through each model and display the results for comparison.

### Checking System Status

```bash
vibe-check
```

Shows:
- Running services
- Loaded models
- System resources
- Environment health

### Updating Models

```bash
make models
```

Updates all AI models to the latest versions.

### Getting Help

```bash
ai-help [command]
```

Provides detailed help for any command in the development environment.
