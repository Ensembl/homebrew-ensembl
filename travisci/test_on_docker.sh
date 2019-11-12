#!/bin/bash

set -euo pipefail

brew deps --union "$@" | if grep -q ensembl/moonshine/
then
    echo Test skipped because the formulae rely on ensembl/moonshine, which is not available:
    brew deps --union "$@" | grep ensembl/moonshine/
else
    brew install --build-from-source "$@"
fi
