#!/bin/bash
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation version 2.1
# of the License.
#
# Copyright(c) 2023 Huawei Device Co., Ltd.

set -e
cd $1
if [ "$(uname)" == "Linux" ];then
    touch test.lock
    (
        flock -x 200
        for i in 1 2 3; do
            if [ -d "$1/bzip2-1.0.8" ];then
                cp -rf bzip2-1.0.8/* ..
                break
            fi
            tar zxvf bzip2-1.0.8.tar.gz
            sleep 1s
            cd $1/bzip2-1.0.8
            if [ -f "Makefile" ] && [ -f "decompress.c" ] && [ -f "bzip2.c" ] && [ -f "Makefile-libbz2_so" ];then
                patch -p1 < $1/0002-CVE-2019-12900.patch --fuzz=0 --no-backup-if-mismatch
                patch -p1 < $1/0001-add-compile-option.patch --fuzz=0 --no-backup-if-mismatch
                patch -p1 < $1/0003-license-and-version-print-should-output-to-stdout-and-exit-with-code-0.patch --fuzz=0 --no-backup-if-mismatch
                cp -rf * ..
                cd ..
                break
            fi
            cd ..
            sleep 1s
        done
        exit 0
    )200>$1/test.lock
else
    for i in 1 2 3; do
        if [ -d "$1/bzip2-1.0.8" ];then
            cp -rf bzip2-1.0.8/* ..
            break
        fi
        tar zxvf bzip2-1.0.8.tar.gz
        cd $1/bzip2-1.0.8
        if [ -f "Makefile" ] && [ -f "decompress.c" ] && [ -f "bzip2.c" ] && [ -f "Makefile-libbz2_so" ];then
            patch -p1 < $1/0002-CVE-2019-12900.patch --fuzz=0 --no-backup-if-mismatch
            patch -p1 < $1/0001-add-compile-option.patch --fuzz=0 --no-backup-if-mismatch
            patch -p1 < $1/0003-license-and-version-print-should-output-to-stdout-and-exit-with-code-0.patch --fuzz=0 --no-backup-if-mismatch
            cp -rf * ..
            cd ..
            break
        fi
        cd ..
    done
fi
exit 0
