#!/bin/bash

# Script to prepare release package for Swift Package Manager
# Usage: ./release.sh [version]
# Example: ./release.sh 1.0.0

set -e

VERSION=${1:-"1.0.0"}
ZIP_FILE="RKFoundation.xcframework.zip"
CHECKSUM_FILE="${ZIP_FILE}.checksum"

echo "🚀 Preparing release for version: $VERSION"
echo ""

# Check if xcframework exists
if [ ! -d "RKFoundation.xcframework" ]; then
    echo "❌ Error: RKFoundation.xcframework directory not found!"
    exit 1
fi

# Create zip file if it doesn't exist or force recreate
if [ -f "$ZIP_FILE" ]; then
    read -p "⚠️  $ZIP_FILE already exists. Recreate? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -f "$ZIP_FILE"
    else
        echo "Using existing $ZIP_FILE"
    fi
fi

if [ ! -f "$ZIP_FILE" ]; then
    echo "📦 Creating zip file..."
    zip -r "$ZIP_FILE" RKFoundation.xcframework > /dev/null
    echo "✅ Created: $ZIP_FILE"
fi

# Generate checksum
echo "🔐 Generating checksum..."
CHECKSUM=$(shasum -a 256 "$ZIP_FILE" | awk '{print $1}')
echo "$CHECKSUM" > "$CHECKSUM_FILE"
echo "✅ Checksum: $CHECKSUM"
echo ""

# Display release information
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 Release Information"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Version:     $VERSION"
echo "Zip File:    $ZIP_FILE ($(du -h "$ZIP_FILE" | cut -f1))"
echo "Checksum:    $CHECKSUM"
echo ""
echo "📝 Next Steps:"
echo ""
echo "1. Create a GitHub Release:"
echo "   - Go to: https://github.com/YOUR_USERNAME/YOUR_REPO/releases/new"
echo "   - Tag: v$VERSION"
echo "   - Title: Release $VERSION"
echo "   - Upload: $ZIP_FILE"
echo ""
echo "2. Update Package.swift with:"
echo "   url: \"https://github.com/YOUR_USERNAME/YOUR_REPO/releases/download/v$VERSION/$ZIP_FILE\""
echo "   checksum: \"$CHECKSUM\""
echo ""
echo "3. Or use this command to update Package.swift automatically:"
echo "   ./update-package-url.sh YOUR_USERNAME YOUR_REPO $VERSION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

