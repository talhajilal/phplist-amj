#!/bin/bash

cd $(dirname $0)

FILE=${1:-phplist-3.3.5.yml}

# Sourcing the configuration file.
# NOTE One can override default compose file here
sh .env

# Check if any of the DEV settings are found
if [[ -n $THEME_DEV_PATH ]] && [[ -n $CODE_PATH ]] && [[ -n $PLUGIN_DEV_PATH ]]; then
    FILE=-phplist-3.3.5.yml
    echo Using the DEV version
fi

if [[ $FORCE_STOP_ALL_BEFORE =~ (y(es)?|true|1) ]]; then
    docker stop $(docker ps -q)
fi

docker-compose -f $FILE down --remove-orphans
docker-compose -f $FILE pull
docker-compose -f $FILE up -d --build -V
