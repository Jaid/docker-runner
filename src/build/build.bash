#!/bin/env bash
set -o errexit -o pipefail

tiniCommit=0b44d3665869e46ccbac7414241b8256d6234dc4

downloadGithubArchive krallin/tini tini sha $tiniCommit
