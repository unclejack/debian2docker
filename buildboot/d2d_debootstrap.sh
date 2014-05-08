#!/bin/bash
set -e

#debootstrap
echo "---> debootstrapping"
debootstrap --include="$PACKAGES" --variant=minbase $SUITE $BUILDDIR $MIRROR
