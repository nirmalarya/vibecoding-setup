#!/bin/bash

# Setup git hooks for AI Development Environment

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
HOOKS_DIR="$REPO_ROOT/.git/hooks"

echo "🔧 Setting up git hooks for AI Dev Environment..."

# Create hooks directory if it doesn't exist
if [ ! -d "$HOOKS_DIR" ]; then
    echo "Creating git hooks directory..."
    mkdir -p "$HOOKS_DIR"
fi

# Create pre-commit hook
echo "Installing pre-commit hook..."
cat > "$HOOKS_DIR/pre-commit" << 'EOF'
#!/bin/bash

# Pre-commit hook for AI Development Environment

echo "🔍 Running AI Dev pre-commit checks..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track if any check fails
FAILED=0

# 1. Check for hardcoded paths
echo "📁 Checking for hardcoded paths..."
if grep -r "/Users/[^/]*/" --include="*.sh" --include="*.py" --include="*.js" --include="*.json" . 2>/dev/null | grep -v ".git" | grep -v "example"; then
    echo -e "${RED}❌ Error: Found hardcoded paths. Use environment variables instead.${NC}"
    FAILED=1
fi

# 2. Check for API keys and secrets
echo "🔐 Checking for exposed secrets..."
if grep -rE "(api_key|apikey|api-key|secret|password|token)" --include="*.sh" --include="*.py" --include="*.js" --include="*.json" . 2>/dev/null | grep -v ".git" | grep -vE "(example|sample|test|mock)" | grep -vE "^[[:space:]]*#" | grep -vE "^\s*//"; then
    echo -e "${YELLOW}⚠️  Warning: Possible sensitive data found. Please review.${NC}"
fi

# 3. Validate shell scripts
echo "🐚 Validating shell scripts..."
for script in $(find scripts -name "*.sh" 2>/dev/null); do
    if [ -f "$script" ]; then
        if ! bash -n "$script" 2>/dev/null; then
            echo -e "${RED}❌ Error: Syntax error in $script${NC}"
            FAILED=1
        fi
    fi
done

# 4. Check certificate configuration
echo "📜 Checking certificate configuration..."
if [ -f "scripts/vscode-with-certs.sh" ]; then
    # Check for any hardcoded user paths in certificate script
    if grep -E "/Users/[^/]+/(proxy-fix-bundle|\.ai-dev-certs)" "scripts/vscode-with-certs.sh"; then
        echo -e "${RED}❌ Error: Hardcoded certificate path found in vscode-with-certs.sh${NC}"
        FAILED=1
    fi
fi

# 5. Check for large model files
echo "📦 Checking for large model files..."
for file in $(git diff --cached --name-only); do
    if [[ $file == *.gguf || $file == *.bin || $file == *.safetensors ]]; then
        size=$(wc -c <"$file")
        if [ $size -gt 1000000 ]; then
            echo -e "${RED}❌ Error: Large model file detected: $file ($(numfmt --to=iec-i --suffix=B $size))${NC}"
            echo -e "${RED}   Model files should not be committed to git${NC}"
            FAILED=1
        fi
    fi
done

# 6. Check for proper environment variable usage
echo "🔧 Checking environment variable best practices..."
if grep -r "export.*=.*/Users/" --include="*.sh" . 2>/dev/null | grep -v ".git"; then
    echo -e "${YELLOW}⚠️  Warning: Hardcoded paths in exports. Consider using \$HOME or config variables${NC}"
fi

# 7. Validate JSON configuration files
echo "📋 Validating JSON files..."
for json_file in $(find . -name "*.json" -not -path "./.git/*" -not -path "./node_modules/*"); do
    if [ -f "$json_file" ]; then
        if ! jq empty "$json_file" 2>/dev/null; then
            echo -e "${RED}❌ Error: Invalid JSON in $json_file${NC}"
            FAILED=1
        fi
    fi
done

# 8. Check Makefile syntax
echo "🔨 Checking Makefile..."
if [ -f "Makefile" ]; then
    if ! make -n verify >/dev/null 2>&1; then
        echo -e "${YELLOW}⚠️  Warning: Makefile may have issues${NC}"
    fi
fi

# 9. Check for consistent script permissions
echo "🔐 Checking script permissions..."
for script in scripts/*.sh; do
    if [ -f "$script" ] && [ ! -x "$script" ]; then
        echo -e "${YELLOW}⚠️  Warning: $script is not executable${NC}"
    fi
done

# 10. Check documentation is up to date
echo "📚 Checking documentation..."
if git diff --cached --name-only | grep -q "scripts/"; then
    if ! git diff --cached --name-only | grep -q "README.md\|docs/"; then
        echo -e "${YELLOW}⚠️  Warning: Scripts changed but documentation not updated${NC}"
    fi
fi

# Final result
echo ""
if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✅ Pre-commit checks passed!${NC}"
    exit 0
else
    echo -e "${RED}❌ Pre-commit checks failed. Please fix the issues above.${NC}"
    exit 1
fi
EOF

# Make pre-commit hook executable
chmod +x "$HOOKS_DIR/pre-commit"

# Create pre-push hook
echo "Installing pre-push hook..."
cat > "$HOOKS_DIR/pre-push" << 'EOF'
#!/bin/bash

# Pre-push hook for AI Development Environment

echo "🚀 Running pre-push checks..."

# Run tests if they exist
if [ -f "Makefile" ] && grep -q "^test:" "Makefile"; then
    echo "Running tests..."
    make test
fi

# Verify all models are properly configured
if [ -f "Makefile" ] && grep -q "^verify:" "Makefile"; then
    echo "Verifying installation..."
    make verify
fi

echo "✅ Pre-push checks complete!"
EOF

chmod +x "$HOOKS_DIR/pre-push"

# Create commit-msg hook for conventional commits
echo "Installing commit-msg hook..."
cat > "$HOOKS_DIR/commit-msg" << 'EOF'
#!/bin/bash

# Commit message hook for conventional commits

commit_regex='^(feat|fix|docs|style|refactor|test|chore|build|ci|perf)(\(.+\))?: .{1,50}'

if ! grep -qE "$commit_regex" "$1"; then
    echo "❌ Invalid commit message format!"
    echo "  Format: <type>(<scope>): <subject>"
    echo "  Types: feat|fix|docs|style|refactor|test|chore|build|ci|perf"
    echo "  Example: feat(scripts): add new AI model helper"
    exit 1
fi
EOF

chmod +x "$HOOKS_DIR/commit-msg"

echo "✅ Git hooks installed successfully!"
echo ""
echo "Installed hooks:"
echo "  - pre-commit: Validates code before commit"
echo "  - pre-push: Runs tests before push"
echo "  - commit-msg: Enforces conventional commit format"
echo ""
echo "To bypass hooks (use sparingly):"
echo "  git commit --no-verify"
echo "  git push --no-verify"
