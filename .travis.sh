#!/bin/bash

# rules of our build:
# - build/test everything on master/development, don't use any profile
# - use code coverage plug-in on everything from master/development
# - NEVER deploy pull requests to maven
# - deploy to maven using profile "release-build" if pushed to master branch 
# - deploy to maven using profile "development-build" if pushed to development branch

if [ -z "$1" ]; then
    export POM_FILE="pom.xml"
else
    export POM_FILE=$1
fi

echo "[INFO] installing in local repository (compile, test, verify (integration tests), install)"
mvn --activate-profiles !development-build,!release-build --settings .travis.settings.xml --file $POM_FILE clean cobertura:cobertura install
if [ "$TRAVIS_EVENT_TYPE" = "push" ]; then
    if [ "$TRAVIS_BRANCH" = "master" ]; then
        echo "[INFO] deploying release to maven repository (version string will be validated)"
        mvn --activate-profiles !development-build,release-build --settings .travis.settings.xml --file $POM_FILE deploy
    elif [ "$TRAVIS_BRANCH" = "development" ]; then
        echo "[INFO] deploying SNAPSHOT to maven repository (version string will be validated)"
        mvn --activate-profiles development-build,!release-build --settings .travis.settings.xml --file $POM_FILE deploy
    else
        echo "[WARN] Only 'push' events from master/development branches are deployed (TRAVIS_EVENT_TYPE: '$TRAVIS_EVENT_TYPE'; TRAVIS_BRANCH: '$TRAVIS_BRANCH')"
    fi
else
    echo "[WARN] Non-push events (e.g., pull requests) are not deployed (TRAVIS_EVENT_TYPE: '$TRAVIS_EVENT_TYPE'; TRAVIS_BRANCH: '$TRAVIS_BRANCH')"
fi