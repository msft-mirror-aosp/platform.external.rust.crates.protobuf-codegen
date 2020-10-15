#!/bin/bash

# $1 Path to the new version.
# $2 Path to the old version.

set -x
set -e

# replace CARGO_PKG_VERSION with version string from METADATA
SRCFILE=src/lib.rs
VERSION=`grep version: METADATA | sed -e 's/^.*version: *//'`
echo "VERSION=$VERSION"
OLDSTR='env!("CARGO_PKG_VERSION"));'
NEWSTR="$VERSION); // ANDROID ported version"
sed -i -e "s:$OLDSTR:$NEWSTR:" $SRCFILE
# Make sure that sed replaced $OLDSTR with $NEWSTR
grep "$NEWSTR" $SRCFILE > /dev/null
