#!/bin/bash -x

image=${IMAGE:-sheepdog:latest}
nodes=${NODES:-"n1"}
docker=${DOCKER:-docker}
expose=7000

echo "Killing old cluster..."
for node in $nodes; do
    $docker kill $node
    $docker rm $node
done

sleep 1

echo "Starting new cluster..."
for node in $nodes; do
    $docker run -p $expose:$expose -h $node -d --name=$node -t $image
done
