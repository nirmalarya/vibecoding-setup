# Corporate Certificate Setup Guide

This guide explains how to configure VS Code and other development tools to work with corporate proxy certificates.

## Quick Start

```bash
# Export certificates from macOS Keychain
./scripts/vscode-with-certs.sh --export-system

# Or use your existing certificate bundle
cp /path/to/your/corporate/certs.pem ~/.corp-certs/allCAbundle.pem
./scripts/vscode-with-certs.sh
```

## Understanding Corporate Certificates

In corporate environments, SSL inspection is often used for security. This means:
- Your company's proxy intercepts HTTPS traffic
- It presents its own certificates instead of the original site's
- Tools like VS Code, npm, git, etc. need to trust these corporate certificates

## Setup Methods

### Method 1: Export from macOS Keychain (Recommended)

If your IT department has already installed certificates in your system:

```bash
./scripts/vscode-with-certs.sh --export-system
```

This will:
1. Export all certificates from your macOS Keychain
2. Save them to `~/.corp-certs/system-certs.pem`
3. Configure VS Code to use them

### Method 2: Use Existing Certificate Bundle

If you already have a certificate bundle file:

```bash
# Copy your certificate bundle
mkdir -p ~/.corp-certs
cp /path/to/your/allCAbundle.pem ~/.corp-certs/

# Launch VS Code with certificates
./scripts/vscode-with-certs.sh
```

### Method 3: Download from Corporate URL

If your company provides a certificate download URL:

```bash
export CORP_CERT_URL="https://internal.company.com/certificates/bundle.pem"
./scripts/vscode-with-certs.sh --force-download
```

## Environment Variables

The script uses these environment variables:

```bash
# Certificate directory (default: ~/.corp-certs)
export PROXY_FIX_BUNDLE_DIR="$HOME/.corp-certs"

# Certificate file path
export CERT_FILE="$HOME/.corp-certs/allCAbundle.pem"

# Corporate certificate download URL (optional)
export CORP_CERT_URL="https://your-corp.com/certs.pem"

# Proxy settings (if needed)
export HTTP_PROXY="http://proxy.company.com:8080"
export HTTPS_PROXY="http://proxy.company.com:8080"
export NO_PROXY="localhost,127.0.0.1,*.company.com"
```

## Configuring Other Tools

Once you have your certificate bundle, configure other tools:

### npm
```bash
npm config set cafile "$HOME/.corp-certs/allCAbundle.pem"
```

### git
```bash
git config --global http.sslCAInfo "$HOME/.corp-certs/allCAbundle.pem"
```

### Python pip
```bash
export PIP_CERT="$HOME/.corp-certs/allCAbundle.pem"
# Or
pip config set global.cert "$HOME/.corp-certs/allCAbundle.pem"
```

### curl
```bash
export CURL_CA_BUNDLE="$HOME/.corp-certs/allCAbundle.pem"
```

## Troubleshooting

### Certificate errors in VS Code
1. Make sure certificates are properly exported/downloaded
2. Restart VS Code after running the script
3. Check certificate environment variables are set

### SSL errors in npm/git
```bash
# Temporary fix (NOT recommended for production)
export NODE_TLS_REJECT_UNAUTHORIZED=0
git config --global http.sslVerify false
```

### Finding your corporate certificates
Ask your IT department for:
1. Certificate bundle file location
2. Certificate download URL
3. Instructions for your specific proxy setup

### Verifying certificates
```bash
# Check if certificate file is valid
openssl x509 -in ~/.corp-certs/allCAbundle.pem -text -noout

# Test HTTPS connection
curl -v --cacert ~/.corp-certs/allCAbundle.pem https://github.com
```

## Security Notes

- Never disable SSL verification in production
- Keep certificate files secure (readable only by you)
- Regularly update certificates as they expire
- Contact IT if you're unsure about certificate sources

## Additional Resources

- [VS Code Proxy Settings](https://code.visualstudio.com/docs/setup/network)
- [npm Proxy Configuration](https://docs.npmjs.com/cli/v7/using-npm/config#https-proxy)
- [Git SSL Configuration](https://git-scm.com/docs/git-config#Documentation/git-config.txt-httpsslCAInfo)
