#!/usr/bin/env bash

chmod ugo+x /bin/run.bash
/usr/bin/su --command '/bin/bash -o errexit -o pipefail -o xtrace /bin/run.bash' "${userName:=$(id --name --user 1000)}"
