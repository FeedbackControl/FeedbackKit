#!/bin/sh
SOURCERY_PATH="Sourcery"
SOURCERY_ZIP_NAME="Sourcery-${SOURCERY_VERSION}.zip"
SOURCERY_ZIP_URL="https://github.com/krzysztofzablocki/Sourcery/releases/download/${SOURCERY_VERSION}/${SOURCERY_ZIP_NAME}"
SOURCERY_ZIP_PATH="${SOURCERY_PATH}/${SOURCERY_ZIP_NAME}"
SOURCERY_UNZIPPED_PATH="${SOURCERY_PATH}/${SOURCERY_VERSION}"

# Create Sourcery/ directory
mkdir -p $SOURCERY_PATH

# Download sourcery zip if needed
if ! [ -f $SOURCERY_ZIP_PATH ]; then
  curl -L "${SOURCERY_ZIP_URL}" -o "${SOURCERY_ZIP_PATH}"
fi

# Unzip if needed
if ! [ -d $SOURCERY_UNZIPPED_PATH ]; then
  unzip -q "${SOURCERY_ZIP_PATH}" -d "${SOURCERY_UNZIPPED_PATH}"
fi
