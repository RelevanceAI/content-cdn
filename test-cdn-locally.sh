#!/bin/bash

# Test CDN Locally
# This script starts a local HTTP server and helps you test CDN URLs

PORT=8080
CDN_URL="http://localhost:$PORT"

echo "🚀 Starting Local CDN Server..."
echo "================================"
echo ""
echo "CDN will be available at: $CDN_URL"
echo ""
echo "Test URLs:"
echo "  Collection: $CDN_URL/replicate/collections/text-to-video.mp4"
echo "  Model: $CDN_URL/replicate/models/google__veo-3/cover.webp"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""
echo "================================"
echo ""

# Start Python HTTP server (works on all systems)
if command -v python3 &> /dev/null; then
    python3 -m http.server $PORT
elif command -v python &> /dev/null; then
    python -m SimpleHTTPServer $PORT
else
    echo "❌ Python not found. Install Python or use: npx http-server -p $PORT"
    exit 1
fi
