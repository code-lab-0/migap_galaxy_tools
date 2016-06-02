#!/bin/bash
INPUT1=$1
shift
INPUT2=$1
shift
INPUT3=$1
shift
OUTPUT1=$1
shift

INPUT_FNAME1="${INPUT1##*/}"
INPUT_FNAME2="${INPUT2##*/}"
INPUT_FNAME3="${INPUT3##*/}"
DATA_DIR_TMP="${INPUT1%/*}"

CONTAINER_ID=`cat /proc/1/cpuset`
CONTAINER_ID="${CONTAINER_ID##*/}"

DATA_DIR="/tmp/files/${CONTAINER_ID}/${DATA_DIR_TMP##*/}"

OUTPUT_FNAME1="${OUTPUT1##*/}"

IMG="yookuda/fa4tr"

docker run -v $DATA_DIR:/data \
       --rm \
       $IMG \
       perl /scripts/fa4tr.pl \
       --fa /data/$INPUT_FNAME1 \
       --cog /data/$INPUT_FNAME2 \
       --ref /data/$INPUT_FNAME3 \
       --out /data/$OUTPUT_FNAME1

