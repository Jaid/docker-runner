ARG image=ubuntu:rolling
ARG builderVersion=4.5.0
ARG builderFlavor=

FROM jaidchen/builder:$builderVersion$builderFlavor AS build

FROM $image

SHELL [ "/bin/bash", "-o", "errexit", "-o", "pipefail", "-o", "xtrace", "-c" ]
ENV userName app
ENV groupName $userName
ENV userId 1000
ENV groupId $userId
ENV userHome /$userName
WORKDIR $userHome

COPY --from=build /build/tini/tini-static /tini
COPY --from=build /bin/aptGet /bin/aptGet
COPY --from=build /bin/installPackages /bin/installPackages
COPY --from=build /bin/installPackagesMinified /bin/installPackagesMinified
ADD *.bash /bin
RUN /bin/bash -o xtrace /bin/init.bash
ONBUILD ADD *.bash /bin
ONBUILD RUN ["/bin/bash", "-o", "errexit", "-o", "pipefail", "-o", "xtrace", "-c", "if [[ -f /bin/prepare.bash ]]; then /bin/bash -o errexit -o pipefail -o xtrace /bin/prepare.bash; rm /bin/prepare.bash; fi"]
ONBUILD RUN chown --recursive $userId:$groupId $userHome
ENTRYPOINT ["/tini", "--"]
CMD ["/bin/bash", "-o", "errexit", "-o", "pipefail", "-o", "xtrace", "/bin/entrypoint.bash"]
HEALTHCHECK --interval=60s CMD ["/bin/bash", "-o", "errexit", "-o", "pipefail", "-o", "xtrace", "/bin/healthCheck.bash"]