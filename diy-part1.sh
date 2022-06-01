#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# openclash var
OPENCLASH_DIR="openclash"
OPENCLASH_GIT="https://github.com/vernesong/OpenClash.git"
OPENCLASH_BRANCH="dev"

# git shallow clone
shallowClone(){
    mkdir $1
    cd $1
    git init
    git remote add origin $2
    git config core.sparsecheckout true
    echo $3 >> .git/info/sparse-checkout
    git pull --depth 1 origin $4
}

# Print Commands
set -x

# Add a feed source
echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default

# Add openclash
shallowClone $OPENCLASH_DIR $OPENCLASH_GIT $OPENCLASH_BRANCH
mv luci-app-openclash ../package/
cd ..
rm -rf openclash
