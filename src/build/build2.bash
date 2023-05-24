#!/bin/env bash
set -o errexit -o pipefail

cd tini
cmake -G Ninja -DCMAKE_C_FLAGS=-O3 .
ninja
strip --strip-debug --verbose tini-static
ls -l --all --time-style full-iso --block-size 1 tini tini-static
