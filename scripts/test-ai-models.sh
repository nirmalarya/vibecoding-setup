#!/bin/bash
echo "Testing Ollama models..."
ollama run codellama-7b "Write a hello world in Python"
echo "Testing LocalAI API..."
curl -s http://localhost:8080/v1/models | jq .
