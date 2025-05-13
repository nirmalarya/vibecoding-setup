#!/bin/bash

echo "📦 Checking AI models..."

MODELS_DIR="$HOME/localai-models"

# Your actual model files
REQUIRED_MODELS=(
    "codellama-7b-instruct-q4_k_m.gguf"
    "deepseek-r1-distill-qwen-1.5b-q4_k_m.gguf"
    "gemma-3-4b-instruct-q4_k_m.gguf"
    "llama-3.2-3b-instruct-q4_k_m.gguf"
    "nomic-embed-text-v1.5.Q4_K_S.gguf"
)

# Expected Ollama model names
OLLAMA_NAMES=(
    "codellama-7b"
    "deepseek-r1"
    "gemma3-4b"
    "llama32-3b"
    "nomic-embed-text"
)

# Check if models directory exists
if [ ! -d "$MODELS_DIR" ]; then
    echo "Models directory not found at $MODELS_DIR"
    exit 1
fi

# Check each model file
echo "Checking model files:"
for model in "${REQUIRED_MODELS[@]}"; do
    if [ -f "$MODELS_DIR/$model" ]; then
        echo "✅ $model ($(du -h "$MODELS_DIR/$model" | cut -f1))"
    else
        echo "❌ $model (missing)"
    fi
done

# Check Ollama models
echo
echo "Checking Ollama models:"
if command -v ollama >/dev/null 2>&1; then
    for model in "${OLLAMA_NAMES[@]}"; do
        if ollama list | grep -q "^$model"; then
            echo "✅ $model"
        else
            echo "❌ $model (not in Ollama)"
        fi
    done
else
    echo "Ollama not found"
fi

# Map GGUF files to your Ollama names
echo
echo "Checking if models need to be imported..."
cd "$MODELS_DIR"

declare -A MODEL_MAP
MODEL_MAP["codellama-7b-instruct-q4_k_m.gguf"]="codellama-7b"
MODEL_MAP["deepseek-r1-distill-qwen-1.5b-q4_k_m.gguf"]="deepseek-r1"
MODEL_MAP["gemma-3-4b-instruct-q4_k_m.gguf"]="gemma3-4b"
MODEL_MAP["llama-3.2-3b-instruct-q4_k_m.gguf"]="llama32-3b"
MODEL_MAP["nomic-embed-text-v1.5.Q4_K_S.gguf"]="nomic-embed-text"

for gguf_file in "${!MODEL_MAP[@]}"; do
    ollama_name="${MODEL_MAP[$gguf_file]}"
    if [ -f "$gguf_file" ] && ! ollama list | grep -q "^$ollama_name"; then
        echo "Need to import $gguf_file as $ollama_name"
        
        # Check if Modelfile exists
        modelfile="Modelfile-${ollama_name//[-:]/_}"
        if [ ! -f "$modelfile" ]; then
            # Use simple Modelfile
            cat > "$modelfile" << MODELFILE
FROM ./$gguf_file
PARAMETER temperature 0.7
MODELFILE
        fi
        
        echo "Creating $ollama_name from $gguf_file..."
        ollama create "$ollama_name" -f "$modelfile"
    fi
done

echo
echo "✅ Model check complete"
echo
echo "Summary:"
ollama list
