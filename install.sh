#!/usr/bin/env bash

swiftlint lint 2>/dev/null || exit 1

swift build -c release || exit 1
cp .build/release/xcsnippets /usr/local/bin/xcsnippets