#!/bin/bash

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
