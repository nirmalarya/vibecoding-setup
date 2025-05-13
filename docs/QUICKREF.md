# AI Dev Quick Reference

## 🚀 Essential Commands

\`\`\`bash
dev-start          # Open VS Code with AI
ai                 # Dashboard
create-project     # New project
vibe-check         # Quick status
\`\`\`

## ⌨️ VS Code Shortcuts

| Action | Key | Description |
|--------|-----|-------------|
| Continue Chat | \`Cmd+L\` | Local AI chat |
| Copilot Chat | \`Cmd+I\` | Cloud AI chat |
| Accept | \`Tab\` | Accept suggestion |
| Next | \`Cmd+]\` | Next suggestion |
| Previous | \`Cmd+[\` | Previous suggestion |

## 💬 AI Chat Commands

### Continue.dev (Local)
\`\`\`
@codebase find functions
/explain this code
/refactor for performance
/test this function
/types add annotations
\`\`\`

### GitHub Copilot (Cloud)
\`\`\`
@workspace how does auth work?
/fix this error
/generate API endpoint
/docs for this class
\`\`\`

## 🤖 Model Selection

| Task | Model | Why |
|------|-------|-----|
| Code | CodeLlama 7B | Optimized for code |
| Logic | DeepSeek R1 | Best reasoning |
| Quick | Llama 3.2 3B | Fast responses |
| General | Gemma 3 4B | Balanced |

## 📁 Project Types

\`\`\`bash
create-project my-api node
create-project my-app react  
create-project ml-tool python
create-project my-svc go
\`\`\`

## 🔍 Status Checks

\`\`\`bash
vibe-check         # Quick overview
ollama list        # Models loaded
make verify        # Full check
dev-dashboard      # Detailed status
\`\`\`

## 🛠️ Troubleshooting

\`\`\`bash
ollama serve       # Start Ollama
make models        # Import models
make symlinks      # Fix commands
make clean         # Reset links
\`\`\`

## 📚 Get Help

\`\`\`bash
ai-help            # List commands
ai-help <command>  # Command help
man <command>      # Manual page
\`\`\`

## 🔐 Privacy Tips

- Use Continue for sensitive code
- Use Copilot for general tasks
- Check ~/.continue/config.json
- Disable telemetry in settings

---
*Keep this handy for quick reference!*
