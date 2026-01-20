#!/bin/sh
set -e

on_exit () {
	[ $? -eq 0 ] && exit
	echo 'ERROR: Feature "starship.rs" (ghcr.io/devcontainer-community/devcontainer-features/starship.rs) failed to install! Look at the documentation at ${documentation} for help troubleshooting this error.'
}

trap on_exit EXIT

set -a
. ../devcontainer-features.builtin.env
. ./devcontainer-features.env
set +a

echo ===========================================================================

echo 'Feature       : starship.rs'
echo 'Description   : Install "starship" binary'
echo 'Id            : ghcr.io/devcontainer-community/devcontainer-features/starship.rs'
echo 'Version       : 1.0.0'
echo 'Documentation : https://github.com/devcontainer-community/devcontainer-features/tree/main/src/starship.rs'
echo 'Options       :'
echo '    VERSION="latest"'
echo 'Environment   :'
printenv
echo ===========================================================================

chmod +x ./install.sh
./install.sh
