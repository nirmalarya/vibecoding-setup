#!/bin/bash

# VS Code with corporate certificates setup
# This script configures VS Code to work with corporate proxy certificates
# Useful for environments with SSL inspection or corporate firewalls

# Script directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Define certificate directory (can be overridden by environment variable)
CERT_DIR="${PROXY_FIX_BUNDLE_DIR:-$HOME/.corp-certs}"
CERT_FILE="${CERT_FILE:-$CERT_DIR/allCAbundle.pem}"

# Corporate certificate download URL (can be overridden)
CERT_URL="${CORP_CERT_URL:-}"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Function to check if running behind a proxy
check_proxy() {
    if [ -n "$HTTP_PROXY" ] || [ -n "$HTTPS_PROXY" ] || [ -n "$http_proxy" ] || [ -n "$https_proxy" ]; then
        echo -e "${YELLOW}🔒 Corporate proxy detected. Certificate configuration recommended.${NC}"
        return 0
    fi
    return 1
}

# Function to find system certificates
find_system_certs() {
    echo "🔍 Looking for system certificates..."
    
    # Common certificate locations on macOS
    local cert_locations=(
        "/etc/ssl/certs/ca-certificates.crt"
        "/etc/ssl/cert.pem"
        "/usr/local/share/ca-certificates"
        "$HOME/.ssl/certs"
        "/System/Library/Keychains/SystemRootCertificates.keychain"
    )
    
    for location in "${cert_locations[@]}"; do
        if [ -f "$location" ]; then
            echo "  Found: $location"
        fi
    done
}

# Function to export system certificates from macOS Keychain
export_keychain_certs() {
    echo "🔑 Exporting certificates from macOS Keychain..."
    
    local temp_dir=$(mktemp -d)
    local output_file="$CERT_DIR/system-certs.pem"
    
    # Export all certificates from System keychain
    security find-certificate -a -p /System/Library/Keychains/SystemRootCertificates.keychain > "$temp_dir/system.pem"
    security find-certificate -a -p /Library/Keychains/System.keychain > "$temp_dir/library.pem" 2>/dev/null || true
    
    # Combine all certificates
    cat "$temp_dir"/*.pem > "$output_file" 2>/dev/null
    
    # Cleanup
    rm -rf "$temp_dir"
    
    if [ -s "$output_file" ]; then
        echo -e "${GREEN}✅ System certificates exported to: $output_file${NC}"
        CERT_FILE="$output_file"
        return 0
    else
        echo -e "${RED}❌ Failed to export system certificates${NC}"
        return 1
    fi
}

# Function to download certificates from URL
download_certs() {
    if [ -z "$CERT_URL" ]; then
        echo -e "${YELLOW}⚠️  No certificate URL specified${NC}"
        return 1
    fi
    
    echo "📥 Downloading corporate certificates from: $CERT_URL"
    
    # Try with curl first
    if command -v curl &> /dev/null; then
        curl -sL "$CERT_URL" -o "$CERT_FILE"
    # Fall back to wget
    elif command -v wget &> /dev/null; then
        wget -q "$CERT_URL" -O "$CERT_FILE"
    else
        echo -e "${RED}❌ Error: Neither curl nor wget found${NC}"
        return 1
    fi
    
    if [ $? -eq 0 ] && [ -f "$CERT_FILE" ]; then
        echo -e "${GREEN}✅ Certificates downloaded successfully${NC}"
        return 0
    else
        echo -e "${RED}❌ Failed to download certificates${NC}"
        return 1
    fi
}

# Main script
main() {
    # Parse arguments
    FORCE_DOWNLOAD=false
    EXPORT_SYSTEM=false
    
    for arg in "$@"; do
        case $arg in
            --force-download)
                FORCE_DOWNLOAD=true
                shift
                ;;
            --export-system)
                EXPORT_SYSTEM=true
                shift
                ;;
            --help)
                echo "Usage: $0 [options] [vscode-args...]"
                echo ""
                echo "Options:"
                echo "  --force-download    Force download of certificates from CORP_CERT_URL"
                echo "  --export-system     Export system certificates from macOS Keychain"
                echo "  --help              Show this help message"
                echo ""
                echo "Environment variables:"
                echo "  PROXY_FIX_BUNDLE_DIR   Certificate directory (default: ~/.corp-certs)"
                echo "  CERT_FILE              Certificate file path"
                echo "  CORP_CERT_URL          URL to download corporate certificates"
                echo ""
                echo "Examples:"
                echo "  $0                     # Use existing certificates"
                echo "  $0 --export-system     # Export from macOS Keychain"
                echo "  CORP_CERT_URL=http://corp.com/certs.pem $0 --force-download"
                exit 0
                ;;
        esac
    done
    
    # Create certificate directory if it doesn't exist
    if [ ! -d "$CERT_DIR" ]; then
        echo "📁 Creating certificate directory: $CERT_DIR"
        mkdir -p "$CERT_DIR"
    fi
    
    # Handle certificate acquisition
    if [ "$EXPORT_SYSTEM" = true ]; then
        # Export from system keychain
        export_keychain_certs
    elif [ "$FORCE_DOWNLOAD" = true ] && [ -n "$CERT_URL" ]; then
        # Download from URL
        download_certs
    elif [ ! -f "$CERT_FILE" ]; then
        # No certificate file exists
        echo -e "${YELLOW}⚠️  No certificate file found at: $CERT_FILE${NC}"
        echo ""
        echo "You can:"
        echo "  1. Export system certificates: $0 --export-system"
        echo "  2. Download from URL: CORP_CERT_URL=<url> $0 --force-download"
        echo "  3. Copy your certificate bundle to: $CERT_FILE"
        echo ""
        find_system_certs
    else
        echo "📜 Using existing certificates at: $CERT_FILE"
    fi
    
    # Export certificate environment variables if cert file exists
    if [ -f "$CERT_FILE" ]; then
        echo "🔐 Configuring certificate environment variables..."
        export NODE_EXTRA_CA_CERTS="$CERT_FILE"
        export SSL_CERT_FILE="$CERT_FILE"
        export REQUESTS_CA_BUNDLE="$CERT_FILE"
        export CURL_CA_BUNDLE="$CERT_FILE"
        export NODE_TLS_REJECT_UNAUTHORIZED=0  # For strict corporate proxies
        echo -e "${GREEN}✅ Certificate configuration complete${NC}"
        echo "  NODE_EXTRA_CA_CERTS=$CERT_FILE"
        echo "  SSL_CERT_FILE=$CERT_FILE"
    else
        echo -e "${YELLOW}⚠️  No certificate file found, proceeding without cert config${NC}"
    fi
    
    # Launch VS Code with remaining arguments
    echo "🚀 Launching VS Code..."
    if command -v code &> /dev/null; then
        code "$@"
    else
        echo -e "${RED}❌ VS Code command not found${NC}"
        echo "Please install VS Code and ensure 'code' command is in PATH"
        exit 1
    fi
}

# Launch vs code with proper certificates
code "$@"
# Run main function with all arguments
main "$@"