#!/bin/bash

# Script to generate checksum for RKFoundation.xcframework.zip
# Usage: ./generate-checksum.sh

ZIP_FILE="RKFoundation.xcframework.zip"
CHECKSUM_FILE="${ZIP_FILE}.checksum"

if [ ! -f "$ZIP_FILE" ]; then
    echo "Error: $ZIP_FILE not found!"
    exit 1
fi

CHECKSUM=$(shasum -a 256 "$ZIP_FILE" | awk '{print $1}')
echo "$CHECKSUM" > "$CHECKSUM_FILE"

echo "Checksum generated: $CHECKSUM"
echo "Saved to: $CHECKSUM_FILE"
echo ""
echo "Update Package.swift with this checksum:"
echo "checksum: \"$CHECKSUM\""

