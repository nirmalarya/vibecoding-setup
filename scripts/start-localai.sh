#!/bin/bash
echo "Starting LocalAI..."
cd ~/localai-models
localai run --models-path . --address :8080
