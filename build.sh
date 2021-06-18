#!/bin/bash
  
set -e

BUILD_NUMBER=`date +%s`

rpmbuild \
  --define "_topdir `pwd`" \
  -bs \
  SPECS/*.spec

mkdir -p packages/"$BUILD_NUMBER"

mock \
    -r epel-7-x86_64 \
    --define 'dist .el7' \
    --rebuild `find SRPMS/ -type f | tail -1` \
  && mv -i /var/lib/mock/epel-7-x86_64/result/*.rpm packages/"$BUILD_NUMBER"/
