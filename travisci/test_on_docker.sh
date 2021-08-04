#!/bin/bash

set -euo pipefail

# directories are mounted read-only under Travis, so take a copy
TARGET_TAP_DIR="$(brew --prefix)/Homebrew/Library/Taps/ensembl"
for d in homebrew-*
do
	rm -rf "$TARGET_TAP_DIR/$d"
	cp -a "$d" "$TARGET_TAP_DIR/$d"
done

brew deps --union "$@" | if grep -q ensembl/moonshine/
then
    echo Test skipped because the formulae rely on ensembl/moonshine, which is not available:
    brew deps --union "$@" | grep ensembl/moonshine/
else
    brew install --build-from-source "$@"
    for F in "$@"; do
      brew test "$F"
    done
fi
