#!/bin/sh

rbw get hosting --full | sed -n '4p' | awk '{print $2}' | tail -1
