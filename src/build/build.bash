#!/bin/env bash
set -o errexit -o pipefail

aptGet update
aptGet install cmake
