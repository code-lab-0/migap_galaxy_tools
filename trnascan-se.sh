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
    yookuda/trnascan-se-1.23:1.0 \
        tRNAscan-SE \
            $OPTION \
            -Q \
            -f /data/$OUTPUT_FNAME /data/$INPUT_FNAME \
            > ${DATA_DIR_TMP}/trnascan-se.out \
            2> ${DATA_DIR_TMP}/trnascan-se.err

