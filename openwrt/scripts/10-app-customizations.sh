# use geoip
sed -i 's/geoip-only-cn-private.dat/geoip.dat/g' package/new/helloworld/v2ray-geodata/Makefile

# disable docker option iptables
sed -i "s/iptables '1'/iptables '0'/g" feeds/packages/utils/dockerd/files/etc/config/dockerd

# remove ssr_plus
rm -rf package/new/helloworld/luci-app-ssr-plus
rm -rf package/new/helloworld/patch-luci-app-ssr-plus.patch

# distfeeds.conf settings
sed -i 's/openwrt\/luci/pmkol\/openwrt-plus/g' package/new/luci-theme-argon/luci-theme-argon/luasrc/view/themes/argon/footer.htm
sed -i 's/openwrt\/luci/pmkol\/openwrt-plus/g' package/new/luci-theme-argon/luci-theme-argon/luasrc/view/themes/argon/footer_login.htm
sed -i 's/openwrt\/luci/pmkol\/openwrt-plus/g' feeds/luci/themes/luci-theme-bootstrap/ucode/template/themes/bootstrap/footer.ut
sed -i 's/openwrt\/luci/pmkol\/openwrt-plus/g' feeds/luci/themes/luci-theme-material/ucode/template/themes/material/footer.ut
sed -i 's/openwrt\/luci/pmkol\/openwrt-plus/g' feeds/luci/themes/luci-theme-openwrt-2020/ucode/template/themes/openwrt2020/footer.ut
sed -i '/# timezone/i sed -i "s/\\(DISTRIB_DESCRIPTION=\\).*/\\1'\''OpenWrt-Plus $(sed -n "s/DISTRIB_DESCRIPTION='\''OpenWrt \\([^ ]*\\) .*/\\1/p" /etc/openwrt_release)'\'',/" /etc/openwrt_release\nsource /etc/openwrt_release \&\& sed -i -e "s/distversion\\s=\\s\\".*\\"/distversion = \\"$DISTRIB_ID $DISTRIB_RELEASE ($DISTRIB_REVISION)\\"/g" -e '\''s/distname    = .*$/distname    = ""/g'\'' /usr/lib/lua/luci/version.lua\nsed -i "s/luciname    = \\".*\\"/luciname    = \\"Linux Kernel-Enhanced\\"/g" /usr/lib/lua/luci/version.lua\nsed -i "s/luciversion = \\".*\\"/luciversion = \\"v$(date +%Y%m%d)\\"/g" /usr/lib/lua/luci/version.lua\necho "export const revision = '\''v$(date +%Y%m%d)'\'', branch = '\''Linux Kernel-Enhanced'\'';" > /usr/share/ucode/luci/version.uc\ngrep -q '\''/tmp/sysinfo/model'\'' /etc/rc.local || sudo sed -i '\''/exit 0/i [ "$(cat /sys\\/class\\/dmi\\/id\\/sys_vendor 2>\\/dev\\/null)" = "Default string" ] \&\& echo "Industrial Router" > \\/tmp\\/sysinfo\\/model'\'' /etc/rc.local\n' package/new/default-settings/default/zzz-default-settings
sed -i '/# opkg mirror/a echo -e '\''src/gz immortalwrt_luci https://mirrors.pku.edu.cn/immortalwrt/releases/packages-23.05/x86_64/luci\\nsrc/gz immortalwrt_packages https://mirrors.pku.edu.cn/immortalwrt/releases/packages-23.05/x86_64/packages'\'' >> /etc/opkg/distfeeds.conf' package/new/default-settings/default/zzz-default-settings
sed -i '/# opkg mirror/a echo -e '\''untrusted comment: Public usign key for 23.05 release builds\\nRWRoKXAGS4epF5gGGh7tVQxiJIuZWQ0geStqgCkwRyviQCWXpufBggaP'\'' > /etc/opkg/keys/682970064b87a917' package/new/default-settings/default/zzz-default-settings
sed -i 's#raw.cooluc.com/sbwml/kmod-x86_64/main#gh-proxy.com/https://raw.githubusercontent.com/sbwml/kmod-x86_64/main#g' package/new/default-settings/default/zzz-default-settings
