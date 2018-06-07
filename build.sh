#!/usr/bin/env bash
#
# Exit immediately if a command exits with a non-zero status.
set -o nounset

WORKING_DIR=$(mktemp -d)
APP_NAME=$(basename "$PWD")
APP_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

function cleanup() {
    rm -rf "$WORKING_DIR"
}

function main() {
    echo "Building ${APP_NAME} deployment package..."
    echo "----------------------------------------"
    echo "[1] Downloading latest BookStack source..."
    git clone "https://github.com/BookStackApp/BookStack.git" --branch "release" --single-branch "$WORKING_DIR"
    VERSION=$(cat "${WORKING_DIR}/version")
    VERSION=${VERSION:1}
    echo
   
    echo "[2] Copying Elastic Beanstalk files..."
    cp -r . "$WORKING_DIR"
    echo
    
    echo "[3] Cleaning source files..."
    cd "$WORKING_DIR"
    rm -rf ".git"* "build.sh" *".zip" ".DS_Store"
    echo

    echo "[4] Generating filename..."
    FILENAME="${APP_NAME}_${VERSION}_$(date +'%y%m%d-%H%M%S').zip"
    echo "$FILENAME"

    echo "[5] Compressing files..."
    zip -9 -r "${APP_DIR}/${FILENAME}" .
    echo
    
    echo "Output file: ${FILENAME}"

    cleanup
    exit 0
}


# Set a trap for calling the cleanup fuction in case
# the script does not exit normally.
trap "cleanup; exit 1" HUP INT QUIT PIPE TERM

# Start the main function
main "$@"