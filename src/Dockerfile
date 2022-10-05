FROM ubuntu:22.10

ENV userName app
ENV groupName $userName
ENV userId 1000
ENV groupId $userId
ENV userHome /$userName

RUN addgroup --system --gid $groupId $groupName
RUN adduser --disabled-password --gecos '' --uid $userId --ingroup $groupName --home $userHome --no-create-home --shell /bin/bash $userName
RUN mkdir --parents $userHome/bin
RUN chown --recursive $userId:$groupId $userHome
RUN DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --option APT::Get::Install-Recommends=false --option APT::Get::Install-Suggests=false --yes update && DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --option APT::Get::Install-Recommends=false --option APT::Get::Install-Suggests=false --yes upgrade && DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --option APT::Get::Install-Recommends=false --option APT::Get::Install-Suggests=false --yes autoclean && DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --option APT::Get::Install-Recommends=false --option APT::Get::Install-Suggests=false --yes autoremove
RUN rm -rf /var/log/* /var/lib/apt/lists/* /var/cache/apt/archives/* /usr/share/doc /usr/share/man

WORKDIR $userHome
ONBUILD ADD . .
ONBUILD RUN chown --recursive $userId:$groupId .
ONBUILD RUN chmod --recursive o+x bin
ONBUILD ARG autobuild
ONBUILD RUN /usr/bin/bash -o errexit -o xtrace -c 'if [[ -f $userHome/bin/build ]]; then if [[ $autobuild -eq 1 ]]; then "$userHome/bin/build"; fi; rm "$userHome/bin/build"; fi'
ENTRYPOINT ["/usr/bin/sh", "-c", "/usr/bin/su --command bin/run $userName"]