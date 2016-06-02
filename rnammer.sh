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

docker run \
    -v $DATA_DIR:/data \
    --rm \
    yookuda/rnammer-1.2:1.0 \
        rnammer \
            $OPTION \
            -gff - /data/$INPUT_FNAME \
            > $OUTPUT
