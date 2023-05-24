#!/bin/env bash
set -o errexit -o pipefail

cd tini
cmake -DCMAKE_C_FLAGS=-O3 .
make
strip --strip-debug --verbose tini-static
ls -l --all --time-style full-iso --block-size 1 tini-static
