SOURCERY_VERSION="0.13.1"

.PHONY: test xcodeproj sourcery download-sourcery

test: sourcery
	swift test

# Swift Package Manager
xcodeproj:
	swift package generate-xcodeproj

# Sourcery
sourcery: download-sourcery
	SOURCERY_VERSION=${SOURCERY_VERSION} sh Scripts/execute_sourcery.sh
download-sourcery:
	SOURCERY_VERSION=${SOURCERY_VERSION} sh Scripts/download_sourcery.sh
