#!/bin/bash

set -euo pipefail

# .deps is mounted read-only under Travis, so take a copy of it
LINUXBREW_PATH=$(brew --prefix)
rm -rf "$LINUXBREW_PATH/Homebrew/Library/Taps/ensembl/homebrew-external"
cp -a "$LINUXBREW_PATH/Homebrew/Library/Taps/ensembl/homebrew-ensembl/.deps/homebrew-external" "$LINUXBREW_PATH/Homebrew/Library/Taps/ensembl/homebrew-external"

brew deps --union "$@" | if grep -q ensembl/moonshine/
then
    echo Test skipped because the formulae rely on ensembl/moonshine, which is not available:
    brew deps --union "$@" | grep ensembl/moonshine/
else
    brew install --build-from-source "$@"
fi
