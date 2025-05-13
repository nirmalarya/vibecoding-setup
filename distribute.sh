#!/bin/bash

echo "📦 Creating distributable package..."

cd ~/workspace
DIR_NAME="ai-dev-setup"

# Clean temp files
find "$DIR_NAME" -name .DS_Store -delete
find "$DIR_NAME" -name "*.log" -delete

# Create version file
cat > "$DIR_NAME/VERSION" << VERSION_EOF
Version: 1.0.0
Built on: $(date)
System: $(uname -a)
Models included: No (download separately)
Scripts included: $(ls -1 $DIR_NAME/scripts/*.sh | wc -l)
VERSION_EOF

# Create a setup guide for Mac Mini
cat > "$DIR_NAME/MAC_MINI_SETUP.md" << SETUP_EOF
# Mac Mini Setup Guide

## Quick Start
1. Extract this package
2. Run: make install
3. Download models separately if needed

## Models
If models are not included, download from:
- CodeLlama: https://huggingface.co/TheBloke/CodeLlama-7B-Instruct-GGUF
- DeepSeek: https://huggingface.co/distillers/DeepSeek-R1-Distill-Qwen-1.5B-GGUF
- Place in ~/localai-models/

## Verify
Run: make verify
SETUP_EOF

# Create zip WITHOUT the large model files
DIST_NAME="ai-dev-setup-$(date +%Y%m%d-%H%M%S).zip"
zip -r "$DIST_NAME" "$DIR_NAME" \
    -x "*.git*" \
    -x "*.swp" \
    -x "*.gguf" \
    -x "*localai-models*"

# Create a latest link
ln -sf "$DIST_NAME" "ai-dev-setup-latest.zip"

echo "✅ Package created: $DIST_NAME"
echo "Size: $(du -h "$DIST_NAME" | cut -f1)"
echo "Location: ~/workspace/$DIST_NAME"
echo
echo "Note: Models NOT included (too large)"
echo "Download them separately on target machine"
