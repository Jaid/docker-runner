ARG image=ubuntu:rolling

FROM jaidchen/builder:2.0.1 AS build

FROM $image

ENV userName app
ENV groupName $userName
ENV userId 1000
ENV groupId $userId
ENV userHome /$userName

COPY --from=build /build/tini/tini-static /bin/tini
WORKDIR $userHome
ADD *.bash /bin
RUN ["/bin/bash", "-o", "errexit", "-o", "pipefail", "-o", "xtrace", "/bin/init.bash"]
ONBUILD ADD *.bash /bin
ONBUILD RUN ["/bin/bash", "-o", "errexit", "-o", "pipefail", "-o", "xtrace", "-c", "if [[ -f /bin/prepare.bash ]]; then /bin/bash -o errexit -o pipefail -o xtrace /bin/prepare.bash; rm /bin/prepare.bash; fi"]
ONBUILD RUN chown --recursive $userId:$groupId .
ENTRYPOINT ["/bin/bash", "-o", "errexit", "-o", "pipefail", "-o", "xtrace", "/bin/entrypoint.bash"]
HEALTHCHECK --interval=60s CMD ["/bin/bash", "-o", "errexit", "-o", "pipefail", "-o", "xtrace", "/bin/healthCheck.bash"]