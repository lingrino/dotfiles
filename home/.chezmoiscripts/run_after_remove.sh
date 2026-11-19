#!/usr/bin/env sh
set -euo pipefail

# Remove preinstalled Apple apps. sudo only runs when one is present.
for APP in GarageBand iMovie Keynote Numbers Pages; do
    if [ -e "/Applications/${APP}.app" ]; then
        sudo rm -rf "/Applications/${APP}.app"
        echo "remove: ${APP}"
    fi
done
