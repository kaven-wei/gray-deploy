#!/bin/bash

# User Service Docker Build and Push Script
# Usage: ./build-push.sh <version>
# Example: ./build-push.sh 1.0.0

# 检查版本号参数
if [ -z "$1" ]; then
    echo "Error: Version number is required"
    echo "Usage: ./build-push.sh <version>"
    echo "Example: ./build-push.sh 1.0.0"
    exit 1
fi

VERSION=$1
IMAGE_NAME="xxx.xxx.com/gray/user-service"
HARBOR_REGISTRY="xxx.xxx.com"
HARBOR_USER="xxx"
HARBOR_PASSWORD="xxx"

echo "=========================================="
echo "Building User Service Docker Image"
echo "Version: ${VERSION}"
echo "Image: ${IMAGE_NAME}:${VERSION}"
echo "=========================================="

# Step 1: Build Maven project
echo ""
echo "[Step 1/4] Building Maven project..."
mvn clean package -DskipTests
if [ $? -ne 0 ]; then
    echo "Error: Maven build failed"
    exit 1
fi
echo "✓ Maven build completed"

# Step 2: Build Docker image
echo ""
echo "[Step 2/4] Building Docker image..."
docker build -t ${IMAGE_NAME}:${VERSION} .
if [ $? -ne 0 ]; then
    echo "Error: Docker build failed"
    exit 1
fi
echo "✓ Docker image built successfully"

# Step 3: Login to Harbor registry
echo ""
echo "[Step 3/4] Logging in to Harbor registry..."
docker login -u ${HARBOR_USER} -p ${HARBOR_PASSWORD} ${HARBOR_REGISTRY}
if [ $? -ne 0 ]; then
    echo "Error: Docker login failed"
    exit 1
fi
echo "✓ Logged in to Harbor registry"

# Step 4: Push Docker image
echo ""
echo "[Step 4/4] Pushing Docker image to registry..."
docker push ${IMAGE_NAME}:${VERSION}
if [ $? -ne 0 ]; then
    echo "Error: Docker push failed"
    exit 1
fi
echo "✓ Docker image pushed successfully"

# Tag and push as latest
echo ""
echo "Tagging and pushing as 'latest'..."
docker tag ${IMAGE_NAME}:${VERSION} ${IMAGE_NAME}:latest
docker push ${IMAGE_NAME}:latest
if [ $? -ne 0 ]; then
    echo "Warning: Failed to push 'latest' tag"
else
    echo "✓ 'latest' tag pushed successfully"
fi

echo ""
echo "=========================================="
echo "✓ All steps completed successfully!"
echo "Image: ${IMAGE_NAME}:${VERSION}"
echo "Image: ${IMAGE_NAME}:latest"
echo "=========================================="
