#!/usr/bin/env bash

# requirments
# - download trayer from nixpkgs

# todo
# - no border, not count as window -> picom?
# - bat indicator -> standard input (config?)

# toggle behavior
# - put into "invisible tag"
# - ability to toggle tag with mod + a

trayer \
--transparent true \
--expand true \
--widthtype request \
--alpha 255 \
--edge top \
--align right \
--width 50 \
--height 20 \
--monitor primary

# -------
# alternative tray: download stalonetray
# -> man stalonetray / github readme
