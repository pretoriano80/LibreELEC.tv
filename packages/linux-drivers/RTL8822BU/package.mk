# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RTL8822BU"
PKG_VERSION="f033b6fa139103a49c17cccee298593fb849f8c1"
PKG_SHA256="7f7a9405e68591c3c9ad205b862bc3891c02cca2f19ba25763a2ca9bdb0f170b"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/pretoriano80/88x2bu-20210702"
PKG_URL="https://github.com/pretoriano80/88x2bu-20210702/archive/$PKG_VERSION.tar.gz"


PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="Realtek RTL8822BU Linux 5.x driver"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make V=1 \
       ARCH=$TARGET_KERNEL_ARCH \
       KSRC=$(kernel_path) \
       CROSS_COMPILE=$TARGET_KERNEL_PREFIX \
       CONFIG_POWER_SAVING=n
}

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
    cp *.ko $INSTALL/$(get_full_module_dir)/$PKG_NAME
}
