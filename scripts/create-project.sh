#!/bin/bash

PROJECT_NAME=$1
PROJECT_TYPE=${2:-"node"}

if [ -z "$PROJECT_NAME" ]; then
    echo "Usage: create-project <name> [type]"
    echo "Types: node, react, python, go"
    exit 1
fi

mkdir -p ~/Projects/$PROJECT_NAME
cd ~/Projects/$PROJECT_NAME

case $PROJECT_TYPE in
    "node")
        npm init -y
        echo "node_modules/" > .gitignore
        echo "# $PROJECT_NAME" > README.md
        ;;
    "react")
        npx create-react-app . --template typescript
        ;;
    "python")
        python3 -m venv venv
        echo "venv/" > .gitignore
        echo "# $PROJECT_NAME" > README.md
        touch requirements.txt
        ;;
    "go")
        go mod init $PROJECT_NAME
        echo "# $PROJECT_NAME" > README.md
        ;;
esac

# Initialize git
git init
git add .
git commit -m "Initial commit"

# Open in VS Code
dev-start .

echo "Project $PROJECT_NAME created and opened!"
