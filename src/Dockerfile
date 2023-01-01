ARG image=ubuntu:rolling

FROM $image

ENV userName app
ENV groupName $userName
ENV userId 1000
ENV groupId $userId
ENV userHome /$userName

WORKDIR $userHome
ADD *.bash /bin
RUN ["/bin/bash", "-o", "errexit", "-o", "pipefail", "-o", "xtrace", "/bin/init.bash"]
ONBUILD ADD *.bash /bin
ONBUILD RUN ["/bin/bash", "-o", "errexit", "-o", "pipefail", "-o", "xtrace", "-c", "if [[ -f /bin/prepare.bash ]]; then /bin/bash -o errexit -o pipefail -o xtrace /bin/prepare.bash; rm /bin/prepare.bash; fi"]
ONBUILD RUN chown --recursive $userId:$groupId .
ENTRYPOINT ["/bin/bash", "-o", "errexit", "-o", "pipefail", "-o", "xtrace", "/bin/entrypoint.bash"]
HEALTHCHECK --interval=60s CMD ["/bin/bash", "-o", "errexit", "-o", "pipefail", "-o", "xtrace", "/bin/healthCheck.bash"]