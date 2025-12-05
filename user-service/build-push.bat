@echo off
REM User Service Docker Build and Push Script for Windows
REM Usage: build-push.bat <version>
REM Example: build-push.bat 1.0.0

if "%1"=="" (
    echo Error: Version number is required
    echo Usage: build-push.bat ^<version^>
    echo Example: build-push.bat 1.0.0
    exit /b 1
)

set VERSION=%1
set IMAGE_NAME=xxx.xxx.com/gray/user-service
set HARBOR_REGISTRY=xxx.xxx.com
set HARBOR_USER=xxx
set HARBOR_PASSWORD=xxx

echo ==========================================
echo Building User Service Docker Image
echo Version: %VERSION%
echo Image: %IMAGE_NAME%:%VERSION%
echo ==========================================

REM Step 1: Build Maven project
echo.
echo [Step 1/4] Building Maven project...
call mvn clean package -DskipTests
if errorlevel 1 (
    echo Error: Maven build failed
    exit /b 1
)
echo √ Maven build completed

REM Step 2: Build Docker image
echo.
echo [Step 2/4] Building Docker image...
docker build -t %IMAGE_NAME%:%VERSION% .
if errorlevel 1 (
    echo Error: Docker build failed
    exit /b 1
)
echo √ Docker image built successfully

REM Step 3: Login to Harbor registry
echo.
echo [Step 3/4] Logging in to Harbor registry...
docker login -u %HARBOR_USER% -p %HARBOR_PASSWORD% %HARBOR_REGISTRY%
if errorlevel 1 (
    echo Error: Docker login failed
    exit /b 1
)
echo √ Logged in to Harbor registry

REM Step 4: Push Docker image
echo.
echo [Step 4/4] Pushing Docker image to registry...
docker push %IMAGE_NAME%:%VERSION%
if errorlevel 1 (
    echo Error: Docker push failed
    exit /b 1
)
echo √ Docker image pushed successfully

REM Tag and push as latest
echo.
echo Tagging and pushing as 'latest'...
docker tag %IMAGE_NAME%:%VERSION% %IMAGE_NAME%:latest
docker push %IMAGE_NAME%:latest
if errorlevel 1 (
    echo Warning: Failed to push 'latest' tag
) else (
    echo √ 'latest' tag pushed successfully
)

echo.
echo ==========================================
echo √ All steps completed successfully!
echo Image: %IMAGE_NAME%:%VERSION%
echo Image: %IMAGE_NAME%:latest
echo ==========================================
