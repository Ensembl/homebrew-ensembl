#!/bin/bash

set -euo pipefail


# Enable Ctrl+C if run interactively
test -t 1 && USE_TTY="-t"

# Test each changed file independently
for filename in $(git diff --name-only "$TRAVIS_COMMIT_RANGE")
do
    # Notes:
    # - Mount the whole tap to use the new version of each formula
    # - Don't upgrade the formulae already installed as this image is expected to be updated regularly
    docker run ${USE_TTY:-} -i \
               -v "$PWD:/home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/ensembl/homebrew-ensembl" \
               muffato/ensembl-basic-dependencies-linuxbrew \
               brew install --build-from-source "ensembl/ensembl/$(basename "${filename%.rb}")"
               #/bin/bash
done

