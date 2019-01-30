#!/bin/bash

if [[ "$1" != "popularity" ]] && [[ "$1" != "quote" ]]; then
	echo "Error: Argument must be either \"popularity\" or \"quote\"."
	exit 1
fi

# export LC_ALL=C.UTF-8
# export LANG=C.UTF-8
export MONGO_HOST=${MONGO_HOST:-ameo.design}
export REDIS_HOST=${REDIS_HOST:-ameo.design}
export RABBITMQ_HOST=${RABBITMQ_HOST:-ameo.design}
export RABBITMQ_PORT=${RABBITMQ_PORT:-5672}

until python src/worker.py \
	--mode $1 \
	--rabbitmq_host=$RABBITMQ_HOST \
	--rabbitmq_port=$RABBITMQ_PORT; do
	echo "Popularities scraper exited with code $?.  Restarting..."
	sleep 1
done