#!/bin/bash
INPUT=$1
OUTPUT=$2
OPTION=${@:3}

RRNA_DB_DIR=/home/okuda/data/db/rrna/20090220

CONTAINER_ID=`cat /proc/1/cpuset`
CONTAINER_ID="${CONTAINER_ID##*/}"

INPUT_FNAME="${INPUT##*/}"

DATA_DIR_TMP="${INPUT%/*}"
DATA_DIR="/tmp/files/${CONTAINER_ID}/${DATA_DIR_TMP##*/}"

OUTPUT_FNAME="${OUTPUT##*/}"

#IMG="yookuda/blast-2.2.29plus:1.0"
IMG="yookuda/blast_plus"

docker run \
    -v $DATA_DIR:/data \
    -v $RRNA_DB_DIR:/db \
    --rm \
    $IMG \
        blastn \
            -db /db/16srna \
            -query /data/${INPUT_FNAME} \
            -out /data/${OUTPUT_FNAME} \
            -outfmt "0" \
            $OPTION

