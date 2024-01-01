#!/bin/bash

if [[ -v MPI_LOCALRANKID ]]; then
  _MPI_RANKID=$MPI_LOCALRANKID
elif [[ -v PALS_LOCAL_RANKID ]]; then
  _MPI_RANKID=$PALS_LOCAL_RANKID
else
  echo "could not get RANK"
  exit
fi

num_gpu=$(/usr/bin/udevadm info /sys/module/i915/drivers/pci:i915/* |& grep -v Unknown | grep -c "P: /devices")
num_tile=2
gpu_id=$(((_MPI_RANKID / num_tile) % num_gpu))
tile_id=$((_MPI_RANKID % num_tile))
ZE_AFFINITY_MASK=$gpu_id.$tile_id


echo "$PMIX_RANK PMIX_RANK, \
$PALS_RANKID PALS_RANKID, \
$PALS_LOCAL_RANKID PALS_LOCAL_RANKID, \
$ZE_AFFINITY_MASK ZE_AFFINITY_MASK, \
$(hostname) HOSTNAME, \
$PALS_APID PALS_APID, \
$PALS_RANKID PALS_RANKID, \
$PALS_DEPTH PALS_DEPTH, \
$PALS_NODEID PALS_NODEID"

# setting depth
# 1 rank, 208 cores
# 2 ranks, 104 cores
# 4 ranks, 52 cores
# 8 ranks, 26 cores
# 16 ranks, 13 cores
#
# 12 ranks (one per logical GPU), use 16  cores
