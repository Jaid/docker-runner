#!/usr/bin/env bash

chmod ugo+x /bin/run.bash
/usr/bin/su --command '/usr/bin/bash -o errexit -o pipefail -o xtrace /bin/run.bash' "${userName:=$(id -nu 1000)}"
