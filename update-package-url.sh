#!/bin/bash

# Script to update Package.swift with release URL and checksum
# Usage: ./update-package-url.sh <username> <repo> <version>
# Example: ./update-package-url.sh myusername RKFoundation 1.0.0

set -e

if [ $# -lt 3 ]; then
    echo "Usage: $0 <username> <repo> <version>"
    echo "Example: $0 myusername RKFoundation 1.0.0"
    exit 1
fi

USERNAME=$1
REPO=$2
VERSION=$3
ZIP_FILE="RKFoundation.xcframework.zip"
CHECKSUM_FILE="${ZIP_FILE}.checksum"
PACKAGE_FILE="Package.swift"

if [ ! -f "$CHECKSUM_FILE" ]; then
    echo "❌ Error: $CHECKSUM_FILE not found!"
    echo "Run ./release.sh first to generate checksum."
    exit 1
fi

CHECKSUM=$(cat "$CHECKSUM_FILE" | tr -d '\n')
URL="https://github.com/${USERNAME}/${REPO}/releases/download/v${VERSION}/${ZIP_FILE}"

echo "📝 Updating Package.swift..."
echo "   URL: $URL"
echo "   Checksum: $CHECKSUM"

# Use sed to update Package.swift
# This works on macOS (BSD sed)
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s|url: \".*\"|url: \"$URL\"|" "$PACKAGE_FILE"
    sed -i '' "s|checksum: \".*\"|checksum: \"$CHECKSUM\"|" "$PACKAGE_FILE"
else
    sed -i "s|url: \".*\"|url: \"$URL\"|" "$PACKAGE_FILE"
    sed -i "s|checksum: \".*\"|checksum: \"$CHECKSUM\"|" "$PACKAGE_FILE"
fi

echo "✅ Package.swift updated successfully!"

