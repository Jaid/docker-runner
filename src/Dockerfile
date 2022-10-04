FROM ubuntu:22.10

ENV userName app
ENV groupName $userName
ENV userId 1000
ENV groupId $userId
ENV userHome /$userName

# https://github.com/nodejs/docker-node/blob/main/docs/BestPractices.md#non-root-user
RUN addgroup --system --gid $groupId $groupName
RUN adduser --disabled-password --gecos '' --uid $userId --ingroup $groupName --home $userHome --no-create-home --shell /bin/bash $userName
RUN mkdir --parents $userHome
RUN chown $userId:$groupId $userHome

RUN apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes update
RUN apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes upgrade
RUN apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes autoclean
RUN apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes autoremove

RUN rm -rf /var/log/*
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /var/cache/apt/archives/*
RUN rm -rf /usr/share/doc
RUN rm -rf /usr/share/

WORKDIR $userHome
ENTRYPOINT /usr/bin/sh -c "su --command $userHome/run $userName"