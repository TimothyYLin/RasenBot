#!/bin/sh

MONGO_HOST="mongodb"
MONGO_PORT=27017
MAX_WAIT=30  # Time in seconds before giving up

echo "Waiting up to $MAX_WAIT seconds for MongoDB to be ready..."
TIME_WAITED=0

while ! nc -z $MONGO_HOST $MONGO_PORT; do
  sleep 2
  TIME_WAITED=$((TIME_WAITED + 2))
  if [ "$TIME_WAITED" -ge "$MAX_WAIT" ]; then
    echo "MongoDB is still not ready after $MAX_WAIT seconds. Starting bot anyway..."
    break
  fi
done

echo "Waited $TIME_WAITED seconds to connect to MongoDB..."
echo "Starting Discord bot..."
python -u main.py