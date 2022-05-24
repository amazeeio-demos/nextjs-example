#!/bin/bash

BRANCH=$(echo $LAGOON_GIT_BRANCH | tr '/' '-')
LAGOON_ENV_FILE=".lagoon.env"

echo $BRANCH
echo $LAGOON_ENV_FILE

if grep -q NEXT_PUBLIC_CLIENTSIDE_ENV_VAR "$LAGOON_ENV_FILE"; then
    echo "NEXT_PUBLIC_CLIENTSIDE_ENV_VAR exists"
else
    echo '' >> .lagoon.env
    echo "# Adding NEXT_PUBLIC_CLIENTSIDE_ENV_VAR dynamically based on current branch" >> .lagoon.env
    echo "NEXT_PUBLIC_CLIENTSIDE_ENV_VAR=clientside-env-for-$BRANCH" >> .lagoon.env
    echo '' >> .lagoon.env
fi
