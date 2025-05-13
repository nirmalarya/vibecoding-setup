# AI Features Guide

## Overview

This setup includes both local AI (Continue.dev) and cloud AI (GitHub Copilot) for maximum flexibility.

## 🤖 Local AI with Continue.dev

### Available Models
- **CodeLlama 7B** - Best for code generation
- **DeepSeek R1** - Advanced reasoning
- **Gemma 3 4B** - Balanced performance
- **Llama 3.2 3B** - Fast responses
- **Nomic Embed** - Code search

### Chat Interface (Cmd+L)

#### Context Providers
- \`@codebase\` - Search entire project
- \`@diff\` - Current git changes
- \`@terminal\` - Terminal output
- \`@docs\` - Documentation
- \`@problems\` - VS Code problems
- \`@folder\` - Current directory

#### Slash Commands
- \`/edit\` - Edit selected code
- \`/comment\` - Add comments
- \`/test\` - Generate tests
- \`/explain\` - Explain code
- \`/refactor\` - Refactor code
- \`/optimize\` - Optimize performance

#### Custom Commands
- \`/docstring\` - Generate documentation
- \`/debug\` - Add debug logging
- \`/types\` - Add type annotations
- \`/clean\` - Clean up code

## ☁️ Cloud AI with GitHub Copilot

### Copilot Suggestions
- **Tab** - Accept suggestion
- **Esc** - Dismiss
- **Cmd+]** - Next suggestion
- **Cmd+[** - Previous suggestion

### Copilot Chat (Cmd+I)

#### Agents
- \`@workspace\` - Analyze entire codebase
- \`@vscode\` - VS Code help
- \`@terminal\` - Terminal assistance

#### Commands
- \`/explain\` - Explain code
- \`/fix\` - Fix problems
- \`/generate\` - Generate code
- \`/tests\` - Create tests
- \`/docs\` - Generate documentation

## 🎯 Best Practices

### When to Use What

**Use Continue.dev for:**
- Private/sensitive code
- Offline development
- Custom model selection
- Large context understanding

**Use GitHub Copilot for:**
- General development
- Quick suggestions
- Complex code generation
- Latest API knowledge

### Effective Prompting

1. **Be Specific**
   \`\`\`
   # Good
   "Create a REST API endpoint for user authentication with JWT"
   
   # Less Good
   "Make an API"
   \`\`\`

2. **Provide Context**
   \`\`\`
   # Good
   "@codebase How does the auth module work with the user service?"
   
   # Less Good
   "How does auth work?"
   \`\`\`

3. **Use Examples**
   \`\`\`
   # Good
   "Generate tests similar to the ones in auth.test.js"
   
   # Less Good
   "Write tests"
   \`\`\`

## ⚡ Keyboard Shortcuts

| Action | Shortcut | Tool |
|--------|----------|------|
| Continue Chat | Cmd+L | Continue.dev |
| Copilot Chat | Cmd+I | GitHub Copilot |
| Accept suggestion | Tab | Both |
| Next suggestion | Cmd+] | Copilot |
| Previous suggestion | Cmd+[ | Copilot |

## 🔧 Advanced Features

### Model-Specific Roles

Continue.dev assigns different models for different tasks:
- **Inline Edit**: CodeLlama 7B
- **Code Apply**: CodeLlama 7B  
- **Repo Mapping**: Gemma 3 4B
- **Auto-detect**: Llama 3.2 3B

### Custom Contexts

You can create custom context providers:
\`\`\`javascript
// In .continue/config.json
"contextProviders": [
  {
    "name": "custom",
    "params": {
      "query": "specific files or patterns"
    }
  }
]
\`\`\`

## 📈 Performance Tips

1. **Choose the Right Model**
   - CodeLlama for code
   - DeepSeek for logic
   - Llama 3.2 for speed

2. **Limit Context**
   - Use specific paths in @codebase
   - Clear chat history regularly

3. **Optimize Prompts**
   - Start with simple queries
   - Add detail as needed

## 🐛 Debugging

### Continue.dev Issues
\`\`\`bash
# Check Ollama
ollama list
ollama serve

# Check config
cat ~/.continue/config.json
\`\`\`

### Copilot Issues
\`\`\`bash
# Check extensions
code --list-extensions | grep copilot

# Verify authentication
# Sign out and back in via VS Code
\`\`\`

## 🔐 Privacy Considerations

**Continue.dev**
- ✅ Runs locally
- ✅ No telemetry
- ✅ Code stays private

**GitHub Copilot**
- ⚠️ Sends code to cloud
- ⚠️ Uses for training (unless disabled)
- ⚠️ Requires subscription

Choose based on your privacy needs!
