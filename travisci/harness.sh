#!/bin/bash

set -euo pipefail


# Enable Ctrl+C if run interactively
test -t 1 && USE_TTY="-t"

COMMIT_RANGE="$TRAVIS_COMMIT_RANGE"
if [ -z "$COMMIT_RANGE" ]
then
    # Undo the shallow clone
    git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
    git fetch --unshallow origin master || git fetch origin || echo "Can't update this repository. Moving on, fingers crossed"
    COMMIT_RANGE="origin/master..$TRAVIS_BRANCH"
fi
echo "Testing changed files in $COMMIT_RANGE"

# Get the list of files that have changed
CHANGED_FILES=()
while IFS='' read -r line
do
    CHANGED_FILES+=("$line")
done < <(git --no-pager diff --name-only "$COMMIT_RANGE" | grep '\.rb$')

# Avoid the "unbound variable" error if the array is empty (because of set -u)
if [ ${#CHANGED_FILES[@]} -eq 0 ]
then
    echo "No .rb file changed. See 'git diff' below:"
    git --no-pager diff --name-only "$COMMIT_RANGE"
    exit 0
fi
echo "Changed files:" "${CHANGED_FILES[@]}"

# Tap information
DOCKER_TAP_PATH="/home/linuxbrew"
# The tap being tested
TAP_LOCAL_PATH="$PWD"
TAP_DIR_NAME="$(basename "$TAP_LOCAL_PATH")"
TAP_DOCKER_PATH="$DOCKER_TAP_PATH/$TAP_DIR_NAME"
TAP_NAME="ensembl/${TAP_DIR_NAME#homebrew-}"
echo "Tap name is $TAP_NAME"
# The other main Ensembl tap (needs to be downloaded)
OTHER_TAP_NAME="homebrew-external"
OTHER_TAP_URL="https://github.com/Ensembl/$OTHER_TAP_NAME"
OTHER_TAP_LOCAL_PATH="$PWD/.deps/$OTHER_TAP_NAME"
OTHER_TAP_DOCKER_PATH="$DOCKER_TAP_PATH/$OTHER_TAP_NAME"
rm -rf "$OTHER_TAP_LOCAL_PATH"
mkdir -p "$OTHER_TAP_LOCAL_PATH"
git clone --branch feature/codon_cluster --depth 1 "$OTHER_TAP_URL" "$OTHER_TAP_LOCAL_PATH"

# List the mount points
MOUNTS=()
MOUNTS+=("-v" "$TAP_LOCAL_PATH:$TAP_DOCKER_PATH")
MOUNTS+=("-v" "$OTHER_TAP_LOCAL_PATH:$OTHER_TAP_DOCKER_PATH")

# Transform the files into formula names
ALL_FORMULAE=()
for filename in "${CHANGED_FILES[@]}"
do
    ALL_FORMULAE+=("$TAP_NAME/${filename%.rb}")
done

# Get the list of formulae they are a dependency of
for filename in "${CHANGED_FILES[@]}"
do
    while IFS='' read -r line
    do
        ALL_FORMULAE+=("$TAP_NAME/$(basename "$line")")
    done < <(grep -l "\<depends_on[[:space:]]\+.$TAP_NAME/${filename%.rb}\>" ./*.rb | sed 's/\.rb$//')
done
echo "Formulae to test (incl. reverse dependencies):" "${ALL_FORMULAE[@]}"

#echo \
docker run ${USE_TTY:-} -i \
       "${MOUNTS[@]}" \
       --env HOMEBREW_NO_AUTO_UPDATE=1 \
       thibauthourlier/ensembl-linuxbrew-basic-dependencies \
       "$TAP_DOCKER_PATH/travisci/test_on_docker.sh" "${ALL_FORMULAE[@]}"
       #/bin/bash

