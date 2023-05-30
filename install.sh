#!/bin/bash
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation version 2.1
# of the License.
#
# Copyright(c) 2023 Huawei Device Co., Ltd.

set -e
cd $1
if [ -d "tag" ];then
    exit 0
fi
touch tag
tar xvf bzip2-1.0.8.tar.gz
cd $1/bzip2-1.0.8
patch -p1 < $1/0002-CVE-2019-12900.patch --fuzz=0 --no-backup-if-mismatch
patch -p1 < $1/0001-add-compile-option.patch --fuzz=0 --no-backup-if-mismatch
mv * ..
cd ..
rm -rf bzip2-1.0.8
rm -rf tag
exit 0