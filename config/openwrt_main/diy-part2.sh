 #!/bin/bash
    # ====== HAPUS PAKET BIANG KEROK ======
    sed -i '/bmx7/d' .config
    sed -i '/babeld/d' .config
    sed -i '/dcwapd/d' .config
    sed -i '/prometheus-node-exporter-lua/d' .config
    sed -i '/kmod-dummy/d' .config

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

# ====== BOM NUKLIR ANTI DOCKER ======
echo "=== HAPUS DOCKER DARI AKAR ==="

# 1. Paksa semua varian docker jadi =n
sed -i 's/CONFIG_PACKAGE_dockerd=.*/CONFIG_PACKAGE_dockerd=n/g' .config
sed -i 's/CONFIG_PACKAGE_docker=.*/CONFIG_PACKAGE_docker=n/g' .config
sed -i 's/CONFIG_PACKAGE_luci-app-dockerman=.*/CONFIG_PACKAGE_luci-app-dockerman=n/g' .config
sed -i 's/CONFIG_PACKAGE_luci-i18n-dockerman-.*/d' .config

# 2. Kalau belum ada, paksa tambahin =n
grep -q "CONFIG_PACKAGE_dockerd=" .config || echo "CONFIG_PACKAGE_dockerd=n" >> .config
grep -q "CONFIG_PACKAGE_docker=" .config || echo "CONFIG_PACKAGE_docker=n" >> .config
grep -q "CONFIG_PACKAGE_luci-app-dockerman=" .config || echo "CONFIG_PACKAGE_luci-app-dockerman=n" >> .config

# 3. Hapus semua bahasa docker biar gak nyampah
sed -i '/CONFIG_PACKAGE_luci-i18n-dockerman/d' .config

echo "=== DOCKER SUDAH DIMUSNAHKAN ==="
