FILES_${PN}-catalog-extralocales = \
            "${exec_prefix}/lib/systemd/catalog/*.*.catalog"
PACKAGES =+ "${PN}-catalog-extralocales"
PACKAGECONFIG = "pam hostnamed networkd randomseed resolved sysusers timedated \
                 timesyncd xz"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://default.network"
SRC_URI += "file://0001-sd-bus-Don-t-automatically-add-ObjectManager.patch"

# Backport from master to fix https://github.com/systemd/systemd/issues/12784
SRC_URI += "file://0001-networkd-fix-link_up-12505.patch"
SRC_URI += "file://0002-network-do-not-send-ipv6-token-to-kernel.patch"

RRECOMMENDS_${PN} += "obmc-targets"
FILES_${PN} += "${systemd_unitdir}/network/default.network"

do_install_append() {
        install -m 644 ${WORKDIR}/default.network ${D}${systemd_unitdir}/network/
}

ALTERNATIVE_${PN} += "init"
ALTERNATIVE_TARGET[init] = "${rootlibexecdir}/systemd/systemd"
ALTERNATIVE_LINK_NAME[init] = "${base_sbindir}/init"
ALTERNATIVE_PRIORITY[init] ?= "300"

# Fallback to more trustworthy NTP and DNS servers (OpenNIC Anycast and NTP Pool Project)
EXTRA_OEMESON += "-Ddns-servers=\"185.121.177.177 169.239.202.202\" \
                  -Dntp-servers=\"0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org 3.pool.ntp.org\" \
                 "
