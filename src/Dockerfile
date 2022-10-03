# syntax=docker/dockerfile:1

FROM ubuntu:22.10

ENV userName app
ENV groupName $userName
ENV userId 1000
ENV groupId $userId
ENV userHome /$userName

ENV tiniVersion v0.19.0

# https://github.com/nodejs/docker-node/blob/main/docs/BestPractices.md#non-root-user
RUN addgroup --system --gid $groupId $groupName
RUN adduser --disabled-password --gecos '' --uid $userId --ingroup $groupName --home $userHome --no-create-home --shell /bin/bash $userName
RUN mkdir --parents $userHome
RUN chown $userId:$groupId $userHome

RUN apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes --quiet update
RUN apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes --quiet upgrade
RUN apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes --quiet autoclean
RUN apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes --quiet autoremove

ADD https://github.com/krallin/tini/releases/download/${tiniVersion}/tini /tini

ENV debugBash=false
WORKDIR $userHome

ENTRYPOINT ["/tini", "--"]
CMD bash