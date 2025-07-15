#!/bin/bash
# Re-run tuning after kernel updates or boot
echo "Running MacBook reoptimization..."
powertop --auto-tune
tlp start
