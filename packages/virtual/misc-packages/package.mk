# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="misc-packages"
PKG_VERSION=""
PKG_LICENSE="GPL"
PKG_SITE="https://libreelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain $ADDITIONAL_PACKAGES kodi"
PKG_SECTION="virtual"
PKG_LONGDESC="misc-packages: Metapackage for miscellaneous packages"

post_install() {
  mkdir -p $INSTALL/usr/share/kodi/storage_addons
  cp ${TARGET_IMG}/${ADDONS}/${ADDON_VERSION}/${DEVICE:-${PROJECT}}/${TARGET_ARCH}/service.lcdd/*.zip $INSTALL/usr/share/kodi/storage_addons

  mkdir -p $INSTALL/usr/lib/libreelec
  cp -PR $PKG_DIR/scripts/* $INSTALL/usr/lib/libreelec
  mkdir -p $INSTALL/usr/config/sleep.d
  cp -PR $PKG_DIR/sleep.d/* $INSTALL/usr/config/sleep.d
  cp -PR $PKG_DIR/modprobe.d/* $INSTALL/usr/config/modprobe.d
  cp -PR $PKG_DIR/settings.xml $INSTALL/usr/share/kodi/storage_addons
  
 
  enable_service storage-addons-copy.service
  enable_service service.lcdd.service

  # update addon manifest / enable addon in Kodi
  ADDON_MANIFEST=$INSTALL/usr/share/kodi/system/addon-manifest.xml
  xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "service.lcdd" $ADDON_MANIFEST
}
