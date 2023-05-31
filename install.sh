#!/bin/bash
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation version 2.1
# of the License.
#
# Copyright(c) 2023 Huawei Device Co., Ltd.

set -e
cd $1
flock -x "README" -c "tar xvf bzip2-1.0.8.tar.gz &&
    cd bzip2-1.0.8 &&
    cp * .."
exit 0