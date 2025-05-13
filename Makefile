# AI Development Environment Setup

.PHONY: all install clean verify models continue scripts symlinks hooks clean-hooks verify-all install-all dev-setup

# Configuration
HOME_DIR := $(HOME)
PROJECT_DIR := $(HOME_DIR)/workspace/ai-dev-setup
SCRIPTS_DIR := $(PROJECT_DIR)/scripts
MODELS_DIR := $(HOME_DIR)/localai-models

all: install

install: check-system scripts models continue verify
	@echo "✅ AI Development Environment Setup Complete!"
	@echo "   Models: $(MODELS_DIR)"
	@echo "   Scripts: $(SCRIPTS_DIR)"
	@echo "   Continue: ~/.continue/config.json"
	@echo ""
	@echo "💡 Tip: Run 'make hooks' to set up git hooks for better code quality"

check-system:
	@echo "🔍 Checking system..."
	@command -v brew >/dev/null 2>&1 || (echo "❌ Homebrew not found"; exit 1)
	@command -v ollama >/dev/null 2>&1 || (echo "❌ Ollama not found"; exit 1)
	@echo "✓ System check passed"

scripts:
	@echo "📝 Installing utility scripts..."
	@cd $(PROJECT_DIR) && ./scripts/install-scripts.sh

models:
	@echo "📦 Checking models..."
	@$(SCRIPTS_DIR)/check-models.sh

continue:
	@echo "🔧 Setting up Continue..."
	@$(SCRIPTS_DIR)/setup-continue.sh

verify:
	@echo "🔍 Verifying installation..."
	@$(SCRIPTS_DIR)/verify-installation.sh

clean:
	@echo "🧹 Cleaning symlinks..."
	@for link in $(HOME_DIR)/.local/bin/*; do \
		if [ -L "$$link" ]; then \
			target=$$(readlink "$$link"); \
			if echo "$$target" | grep -q "workspace\|Workspace"; then \
				rm -f "$$link"; \
				echo "  Removed: $$(basename $$link)"; \
			fi; \
		fi; \
	done

symlinks: clean
	@echo "🔗 Creating symlinks..."
	@mkdir -p ~/.local/bin
	@for script in $(SCRIPTS_DIR)/*.sh; do \
		if [ -f "$$script" ]; then \
			script_name=$$(basename "$$script" .sh); \
			ln -sf "$$script" "$(HOME_DIR)/.local/bin/$$script_name"; \
			echo "  Linked: $$script_name -> $$script"; \
		fi; \
	done

# Git hooks setup
hooks:
	@echo "🔧 Setting up git hooks..."
	@if [ -f $(SCRIPTS_DIR)/setup-git-hooks.sh ]; then \
		chmod +x $(SCRIPTS_DIR)/setup-git-hooks.sh; \
		$(SCRIPTS_DIR)/setup-git-hooks.sh; \
		echo "✅ Git hooks installed"; \
	else \
		echo "❌ setup-git-hooks.sh not found in $(SCRIPTS_DIR)"; \
		exit 1; \
	fi

# Clean git hooks
clean-hooks:
	@echo "🧹 Removing git hooks..."
	@rm -f .git/hooks/pre-commit
	@rm -f .git/hooks/pre-push
	@rm -f .git/hooks/commit-msg
	@echo "✅ Git hooks removed"

# Full installation including hooks
install-all: install hooks
	@echo "✅ Complete installation with git hooks finished"

# Development setup
dev-setup: install-all
	@echo "🔧 Setting up development environment..."
	@echo "Creating .env file if it doesn't exist..."
	@[ -f .env ] || cp .env.example .env 2>/dev/null || echo "⚠️  No .env.example found"
	@echo "✅ Development environment ready"

# Verification with hooks check
verify-all: verify
	@echo "🔍 Checking git hooks..."
	@if [ -f .git/hooks/pre-commit ]; then \
		echo "✅ Pre-commit hook installed"; \
	else \
		echo "❌ Pre-commit hook missing"; \
	fi
	@if [ -f .git/hooks/pre-push ]; then \
		echo "✅ Pre-push hook installed"; \
	else \
		echo "❌ Pre-push hook missing"; \
	fi
	@if [ -f .git/hooks/commit-msg ]; then \
		echo "✅ Commit-msg hook installed"; \
	else \
		echo "❌ Commit-msg hook missing"; \
	fi

list-scripts:
	@echo "📜 Installed Scripts:"
	@ls -la ~/.local/bin | grep -E "dev-|ai-|start-|test-|manage-|create-|vibe-" | awk '{print $$9 " -> " $$11}'

help:
	@echo "AI Development Environment Setup"
	@echo "==============================="
	@echo "make install     - Complete installation"
	@echo "make verify      - Verify installation"
	@echo "make models      - Check/import models"
	@echo "make scripts     - Install scripts"
	@echo "make symlinks    - Recreate all symlinks"
	@echo "make clean       - Remove symlinks"
	@echo ""
	@echo "Git Hooks Commands:"
	@echo "make hooks       - Install git hooks"
	@echo "make clean-hooks - Remove git hooks"
	@echo "make install-all - Install everything including hooks"
	@echo "make dev-setup   - Complete dev environment setup"
	@echo "make verify-all  - Verify everything including hooks"