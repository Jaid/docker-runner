FROM ubuntu:22.10

ENV userName app
ENV groupName $userName
ENV userId 1000
ENV groupId $userId
ENV userHome /$userName

WORKDIR $userHome
ADD content .
RUN bash -o errexit -o xtrace -o pipefail ./init
ONBUILD ADD content .
ONBUILD RUN chown --recursive $userId:$groupId .
ONBUILD RUN chmod --recursive o+x bin
ONBUILD RUN /usr/bin/bash -c 'if [[ -f $userHome/bin/prepare.bash ]]; then /usr/bin/bash -o errexit -o xtrace -o pipefail "$userHome/bin/prepare.bash"; rm "$userHome/bin/prepare.bash"; fi'
ENTRYPOINT ["/usr/bin/sh", "-c", "/usr/bin/su --command bin/run $userName"]