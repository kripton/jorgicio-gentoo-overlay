# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit eutils pax-utils

DESCRIPTION="Telegram Desktop Messenger (official client) binary version"
HOMEPAGE="https://tdesktop.com/"
SRC_URI="
	amd64?	( http://updates.tdesktop.com/tlinux/tsetup.${PV}.tar.xz )
	x86?	( http://updates.tdesktop.com/tlinux32/tsetup32.${PV}.tar.xz )"

RESTRICT="mirror strip"
LICENSE="GPL-3"
IUSE="updater appindicator gtk3"
KEYWORDS="~x86 ~amd64"
INSTALL_DIR="/opt/telegram"
SLOT="0"
RDEPEND="
	appindicator? (
		!gtk3? (
			x11-libs/gtk+:2
			dev-libs/libappindicator:2
		)
		gtk3? (
			x11-libs/gtk+:3
			dev-libs/libappindicator:3
		)
	)"
DEPEND="${RDEPEND}
	!net-im/telegram
	!net-im/telegram-desktop
	!net-im/telegram-dev"

S="${WORKDIR}/Telegram"

src_install() {
	pax-mark m Telegram
    insinto "${INSTALL_DIR}"
	insopts -m755
    doins -r Telegram
	if use updater; then
		pax-mark m Updater
		doins -r Updater
	fi
	doicon "${FILESDIR}/telegram.png"
    make_wrapper "telegram" "${INSTALL_DIR}/Telegram"
    make_desktop_entry "telegram" "Telegram Desktop" "telegram" "Network;InstantMessaging;"

}
