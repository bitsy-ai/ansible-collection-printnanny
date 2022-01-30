#!/usr/bin/env bash

echo "💜 Found video sources"
libcamera-vid --list-cameras
gst-device-monitor-1.0 Video/Source