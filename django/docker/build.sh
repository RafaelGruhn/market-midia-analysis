#!/bin/bash

DEFAULT_PATH=$1

if [ "$MODE" = "production" ]; then
    echo "Installing dependencies"
    pip install -r ${DEFAULT_PATH}/production.txt
    echo "Requirements installed!\n"
else
    echo "Installing dependencies"
    pip install -r ${DEFAULT_PATH}/development.txt
    pip install -r ${DEFAULT_PATH}/ci.txt
fi

exit 0
