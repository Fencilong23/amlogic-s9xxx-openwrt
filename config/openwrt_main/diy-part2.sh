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
