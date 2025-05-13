#!/bin/bash
echo "Starting Ollama..."
ollama serve &
sleep 3
echo "Available models:"
ollama list
