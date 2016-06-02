#!/bin/bash
INPUT=$1
OUTPUT=$2
OPTION=${@:3}

CONTAINER_ID=`cat /proc/1/cpuset`
CONTAINER_ID="${CONTAINER_ID##*/}"

INPUT_FNAME="${INPUT##*/}"

DATA_DIR_TMP="${INPUT%/*}"
DATA_DIR="/tmp/files/${CONTAINER_ID}/${DATA_DIR_TMP##*/}"

OUTPUT_FNAME="${OUTPUT##*/}"
IMG="yookuda/mga"

docker run \
    -v $DATA_DIR:/data \
    --rm \
    $IMG \
        mga /data/$INPUT_FNAME $OPTION > $OUTPUT

