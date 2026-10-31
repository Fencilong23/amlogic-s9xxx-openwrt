 #!/bin/bash
    # ====== HAPUS PAKET BIANG KEROK ======
    sed -i '/bmx7/d' .config
    sed -i '/babeld/d' .config
    sed -i '/dcwapd/d' .config
    sed -i '/prometheus-node-exporter-lua/d' .config
    sed -i '/kmod-dummy/d' .config

# 1. Musnahin paket docker
sed -i 's/CONFIG_PACKAGE_dockerd=.*/CONFIG_PACKAGE_dockerd=n/g' .config
sed -i 's/CONFIG_PACKAGE_docker=.*/CONFIG_PACKAGE_docker=n/g' .config
sed -i 's/CONFIG_PACKAGE_luci-app-dockerman=.*/CONFIG_PACKAGE_luci-app-dockerman=n/g' .config
sed -i '/docker/d' package/base-files/files/etc/config/fstab
sed -i '/CONFIG_PACKAGE_luci-i18n-dockerman/d' .config

# Hapus semua paket ipv6 - versi lengkap
sed -i 's/CONFIG_PACKAGE_ipv6=y/# CONFIG_PACKAGE_ipv6 is not set/' .config
sed -i 's/CONFIG_PACKAGE_kmod-ipv6=y/# CONFIG_PACKAGE_kmod-ipv6 is not set/' .config
sed -i 's/CONFIG_PACKAGE_kmod-ip6tables=y/# CONFIG_PACKAGE_kmod-ip6tables is not set/' .config
sed -i 's/CONFIG_PACKAGE_kmod-nf-conntrack6=y/# CONFIG_PACKAGE_kmod-nf-conntrack6 is not set/' .config
sed -i 's/CONFIG_PACKAGE_odhcp6c=y/# CONFIG_PACKAGE_odhcp6c is not set/' .config
sed -i 's/CONFIG_PACKAGE_odhcpd-ipv6only=y/# CONFIG_PACKAGE_odhcpd-ipv6only is not set/' .config
sed -i 's/CONFIG_PACKAGE_luci-proto-ipv6=y/# CONFIG_PACKAGE_luci-proto-ipv6 is not set/' .config
sed -i 's/CONFIG_PACKAGE_luci-proto-ppp.ipv6.=y/# CONFIG_PACKAGE_luci-proto-ppp is not set/' .config
sed -i 's/CONFIG_PACKAGE_ip6tables=y/# CONFIG_PACKAGE_ip6tables is not set/' .config
sed -i 's/CONFIG_PACKAGE_6in4=y/# CONFIG_PACKAGE_6in4 is not set/' .config
sed -i 's/CONFIG_PACKAGE_6to4=y/# CONFIG_PACKAGE_6to4 is not set/' .config
sed -i 's/CONFIG_PACKAGE_6rd=y/# CONFIG_PACKAGE_6rd is not set/' .config

# Matikan IPv6 di kernel
echo "# CONFIG_PACKAGE_dnsmasq_dhcpv6 is not set" >> .config
echo "# CONFIG_PACKAGE_dnsmasq_full_dhcpv6 is not set" >> .config
echo "# CONFIG_IPV6 is not set" >> .config

    # ====== SETTING CCACHE BIAR CEPET ======
    sed -i '/CONFIG_DEVEL/d' .config
    sed -i '/CONFIG_CCACHE/d' .config
    echo "CONFIG_DEVEL=y" >>.config
    echo "CONFIG_CCACHE=y" >>.config
    echo "CONFIG_CCACHE_DIR=\"\$(TOPDIR)/.ccache\"" >>.config

    # ====== INFO REPO ======
    sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|" package/base-files/files/etc/openwrt_release
    echo "DISTRIB_SOURCEREPO='github.com/openwrt/openwrt'" >>package/base-files/files/etc/openwrt_release
    echo "DISTRIB_SOURCECODE='openwrt'" >>package/base-files/files/etc/openwrt_release
    echo "DISTRIB_SOURCEBRANCH='main'" >>package/base-files/files/etc/openwrt_release
