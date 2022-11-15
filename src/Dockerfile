FROM ubuntu:22.10

ENV userName app
ENV groupName $userName
ENV userId 1000
ENV groupId $userId
ENV userHome /$userName

WORKDIR $userHome
ADD *.bash /bin
RUN ["/usr/bin/bash", "-o", "errexit", "-o", "pipefail", "-o", "xtrace", "/bin/init.bash"]
ONBUILD ADD *.bash /bin
ONBUILD RUN ["/usr/bin/bash", "-o", "errexit", "-o", "pipefail", "-o", "xtrace", "-c", "if [[ -f /bin/prepare.bash ]]; then /usr/bin/bash -o errexit -o pipefail -o xtrace /bin/prepare.bash; rm /bin/prepare.bash; fi"]
ONBUILD RUN chown --recursive $userId:$groupId .
ENTRYPOINT ["/usr/bin/bash", "-o", "errexit", "-o", "pipefail", "-o", "xtrace", "/bin/entrypoint.bash"]
HEALTHCHECK --interval=60s CMD ["/usr/bin/bash", "-o", "errexit", "-o", "pipefail", "-o", "xtrace", "/bin/healthCheck.bash"]