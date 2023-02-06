#!/usr/bin/env bash

# shellcheck disable=SC2154
addgroup --system --gid "$groupId" "$groupName"
adduser --disabled-password --gecos '' --uid "$userId" --ingroup "$groupName" --home "$userHome" --no-create-home --shell /bin/bash "$userName"
mkdir --parents "$userHome"/bin
chown --recursive "$userId":"$groupId" "$userHome"
aptGet update
aptGet upgrade
aptGet autoclean
aptGet autoremove
rm -rf /var/log/* /var/lib/apt/lists/* /var/cache/apt/archives/* /usr/share/doc /usr/share/man

rm /bin/init.bash
