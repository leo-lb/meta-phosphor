SUMMARY = "Logging DBUS Object"
DESCRIPTION = "Logging DBUS Object"
HOMEPAGE = "https://github.com/openbmc/phosphor-logging"
PR = "r1"

inherit autotools pkgconfig
inherit pythonnative
inherit obmc-phosphor-license
inherit obmc-phosphor-dbus-service

DBUS_SERVICE_${PN} += "xyz.openbmc_project.Logging.service"

DEPENDS += "autoconf-archive-native"
DEPENDS += "systemd"
DEPENDS += "python-mako-native"
DEPENDS += "python-pyyaml-native"
PROVIDES += "virtual/obmc-logging-mgmt"
RPROVIDES_${PN} += "virtual-obmc-logging-mgmt"

SRC_URI += "git://github.com/openbmc/phosphor-logging"
SRCREV = "c830e0f492c50e712c2bf1589e0282eebb4107ab"

S = "${WORKDIR}/git"

