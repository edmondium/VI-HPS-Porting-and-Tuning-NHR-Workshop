#!/bin/sh

export VIHPS_ROOT=/projects/p_nhr_vihps

workspace_name=vihps-tws44
if ! VIHPS_WORKSPACE=$(ws_find $workspace_name 2>/dev/null)
then
    ws_allocate $workspace_name 30
    VIHPS_WORKSPACE=$(ws_find $workspace_name 2>/dev/null)
fi
export VIHPS_WORKSPACE

cd "$VIHPS_WORKSPACE"

ml -q purge 2>/dev/null
#ml -q intel/2022b 2>/dev/null

export NPB_MZ_BLOAD=0

export SBATCH_ACCOUNT=p_nhr_vihps
export SBATCH_RESERVATION=VI-HPS-Workshop

export __INTEL_PRE_CFLAGS=-diag-disable=10441

exec newgrp p_nhr_vihps 
