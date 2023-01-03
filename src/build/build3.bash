#!/usr/bin/env bash
set -o errexit -o pipefail

cd tini
cmake .
make
