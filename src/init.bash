#!/bin/env bash

# shellcheck disable=SC2154

userId=${userId:-1000}
userName=${userName:-}
groupId=${groupId:-1000}
groupName=${groupName:-$userName}
userHome=${userHome:-}

existingUser=$(id --name --user "$userId" || true)
existingGroup=$(id --name --group "$groupId" || true)
if [[ -n "$existingUser" ]]; then
  usermod --uid 1001 "$existingUser"
fi
if [[ -n "$existingGroup" ]]; then
  groupmod --gid 1001 "$existingGroup"
fi
userAddArguments=()
if [[ -n "$userHome" ]]; then
  userAddArguments+=(--home)
  userAddArguments+=("$userHome")
  if [[ -d "$userHome" ]]; then
    userAddArguments+=(--no-create-home)
  fi
else
  userAddArguments+=(--no-create-home)
fi
bashPath=$(command -v bash || true)
if [[ -n "$bashPath" ]]; then
  userAddArguments+=(--shell)
  userAddArguments+=("$bashPath")
fi
if [[ -n "$groupName" ]]; then
  groupadd --system --gid "$groupId" "$groupName"
  userAddArguments+=(--gid)
  userAddArguments+=("$groupName")
fi
useradd --uid "$userId" --home "$userHome" "$userName" "${userAddArguments[@]}"

DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --option APT::Get::Install-Recommends=false --option APT::Get::Install-Suggests=false --yes update
DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --option APT::Get::Install-Recommends=false --option APT::Get::Install-Suggests=false --yes upgrade
DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --option APT::Get::Install-Recommends=false --option APT::Get::Install-Suggests=false --yes autoclean
DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --option APT::Get::Install-Recommends=false --option APT::Get::Install-Suggests=false --yes autoremove

rm -rf /var/log/* /var/lib/apt/lists/* /var/cache/apt/archives/* /usr/share/doc /usr/share/man

rm /bin/init.bash
