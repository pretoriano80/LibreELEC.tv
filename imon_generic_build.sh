#!/bin/sh
PROJECT=Generic ARCH=x86_64 ADDON_OVERWRITE=yes scripts/create_addon lcdd && make image
