#!/bin/sh

rbw get hosting --full | sed -n '2p' | awk '{print $2}' | tail -1
