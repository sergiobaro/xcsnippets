#!/usr/bin/env bash

swift build -c release
cp .build/release/xcsnippets /usr/local/bin/xcsnippets