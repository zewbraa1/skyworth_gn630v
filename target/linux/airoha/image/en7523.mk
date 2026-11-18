#
# EN7523 Profile
#

define Device/airoha_en7523-evb
  $(Device/FitImage)
  DEVICE_VENDOR := Airoha
  DEVICE_MODEL := EN7523 Evaluation Board
  DEVICE_DTS := en7523-evb
endef
TARGET_DEVICES += airoha_en7523-evb

define Device/askey_rtf8225vw
  $(Device/Uboot-FitImage)
  DEVICE_VENDOR := Askey
  DEVICE_MODEL := RTF8225VW
  DEVICE_PACKAGES += hostapd-mbedtls wpa-supplicant-mbedtls \
                     kmod-mt7915e kmod-mt7915-firmware kmod-mt7915-firmware \
                     airoha-en7571-firmware airoha-en7523-kite-npu-firmware
endef
TARGET_DEVICES += askey_rtf8225vw

define Device/genexis_arcee
  $(Device/FitImage)
  DEVICE_VENDOR := Heimgard
  DEVICE_MODEL := CX20
  DEVICE_ALT0_VENDOR := Genexis
  DEVICE_ALT0_MODEL := CX20
  DEVICE_ALT1_VENDOR := Genexis
  DEVICE_ALT1_MODEL := Arcee
  DEVICE_PACKAGES += hostapd-mbedtls wpa-supplicant-mbedtls \
                     kmod-mt7915e kmod-mt7916-firmware airoha-en7523-kite-npu-firmware
endef
TARGET_DEVICES += genexis_arcee

define Device/genexis_e650
  $(Device/FitImage)
  DEVICE_VENDOR := Genexis
  DEVICE_MODEL := Aura E650
  DEVICE_PACKAGES += kmod-usb-ohci kmod-usb2 \
                     hostapd-mbedtls wpa-supplicant-mbedtls \
                     kmod-mt7915e kmod-mt7916-firmware \
                     kmod-mdio-gpio kmod-phy-realtek mdio-tools
endef
TARGET_DEVICES += genexis_e650

define Device/genexis_laxy
  $(Device/FitImage)
  DEVICE_VENDOR := Heimgard
  DEVICE_MODEL := Laxy
  DEVICE_ALT0_VENDOR := Genexis
  DEVICE_ALT0_MODEL := Laxy
  DEVICE_PACKAGES += kmod-usb-ohci kmod-usb2 \
                     hostapd-mbedtls wpa-supplicant-mbedtls \
                     kmod-mt7915e kmod-mt7916-firmware airoha-en7523-kite-npu-firmware
endef
TARGET_DEVICES += genexis_laxy

define Device/genexis_pixly_r1
  $(Device/Uboot-FitImage)
  DEVICE_VENDOR := Heimgard
  DEVICE_MODEL := CX30
  DEVICE_ALT0_VENDOR := Genexis
  DEVICE_ALT0_MODEL := CX30
  DEVICE_ALT1_VENDOR := Heimgard
  DEVICE_ALT1_MODEL := Pixly R1
  DEVICE_PACKAGES += hostapd-mbedtls wpa-supplicant-mbedtls \
                     kmod-mt7915e kmod-mt7916-firmware airoha-en7523-kite-npu-firmware
endef
TARGET_DEVICES += genexis_pixly_r1

define Device/genexis_rodimus_r1
  $(Device/FitImage)
  DEVICE_VENDOR := Heimgard
  DEVICE_MODEL := HX40
  DEVICE_ALT0_VENDOR := Genexis
  DEVICE_ALT0_MODEL := HX40
  DEVICE_ALT1_VENDOR := Genexis
  DEVICE_ALT1_MODEL := Rodimus R1
  DEVICE_PACKAGES += kmod-usb-ohci kmod-usb2 \
                     hostapd-mbedtls wpa-supplicant-mbedtls \
                     kmod-mt7915e kmod-mt7916-firmware \
                     kmod-mdio-gpio kmod-phy-realtek
endef
TARGET_DEVICES += genexis_rodimus_r1

define Device/genexis_zephyr
  $(Device/FitImage)
  DEVICE_VENDOR := Heimgard
  DEVICE_MODEL := HX30
  DEVICE_ALT0_VENDOR := Genexis
  DEVICE_ALT0_MODEL := HX30
  DEVICE_ALT1_VENDOR := Genexis
  DEVICE_ALT1_MODEL := Zephyr
  DEVICE_PACKAGES += kmod-usb-ohci kmod-usb2 \
                     hostapd-mbedtls wpa-supplicant-mbedtls \
                     kmod-mt7915e kmod-mt7916-firmware \
                     kmod-mdio-gpio kmod-phy-realtek
endef
TARGET_DEVICES += genexis_zephyr

define Device/mikrotik_e50ug
  $(Device/RouterBoot)
  DEVICE_MODEL := E50UG (hEX refresh)
  ARTIFACT/uboot-bootloader.bin += | fill-zero 0x100000
  DEVICE_PACKAGES += kmod-usb-ohci kmod-usb2 kmod-usb3
endef
TARGET_DEVICES += mikrotik_e50ug

define Device/mikrotik_e60iugs
  $(Device/RouterBoot)
  DEVICE_MODEL := E60iUGS (hEX S 2025)
  ARTIFACT/uboot-bootloader.bin += | fill-zero 0x100000
  DEVICE_PACKAGES += kmod-usb-ohci kmod-usb2 kmod-usb3 kmod-sfp kmod-pse-gpio
endef
TARGET_DEVICES += mikrotik_e60iugs

define Device/mikrotik_e62iugs-2axd5axt
  $(Device/RouterBoot)
  DEVICE_MODEL := E62iUGS-2axD5axT (hAP ax S)
  ARTIFACT/uboot-bootloader.bin += | fill-zero 0x100000
  DEVICE_PACKAGES += kmod-usb-ohci kmod-usb2 kmod-usb3 kmod-sfp kmod-pse-gpio \
                     kmod-crypto-hw-eip93 kmod-mt7915e kmod-mt7916-firmware
endef
TARGET_DEVICES += mikrotik_e62iugs-2axd5axt

define Device/mitrastar_gpt-2742gx4x5v6
  $(Device/Uboot-FitImage)
  DEVICE_VENDOR := MitraStar
  DEVICE_MODEL := GPT-2742GX4X5v6
  DEVICE_PACKAGES += hostapd-mbedtls wpa-supplicant-mbedtls \
                     kmod-mt7915e kmod-mt7915-firmware airoha-en7523-kite-npu-firmware \
                     airoha-en7571-firmware
endef
TARGET_DEVICES += mitrastar_gpt-2742gx4x5v6

define Build/ecnt-hdr2
	$(STAGING_DIR_HOST)/bin/python3 -c 'import struct, sys, zlib; p = sys.argv; data = open(p, "rb").read(); crc = (~zlib.crc32(data)) & 0xffffffff; hdr = struct.pack("<4sIII32s32sIII32s132x", b"HDR2", 0x100, len(data) + 0x100, crc, b"7.3.267.700_v013\n", b"V1.0.0.1\n", len(data), 0, 0, b"EN7523,GN630\n"); open(p, "wb").write(hdr + data)' $@
endef

define Build/ecnt-factory
	$(STAGING_DIR_HOST)/bin/python3 $(TOPDIR)/target/linux/airoha/image/mk-ecnt-factory.py $(IMAGE_KERNEL) $(KDIR)/image-$(firstword $(DEVICE_DTS)).dtb $(IMAGE_ROOTFS) $(STAGING_DIR_HOST)/bin/mkimage $@
endef

define Device/skyworth_gn630v
  $(Device/FitImage)
  DEVICE_VENDOR := Skyworth
  DEVICE_MODEL := GN630V
  KERNEL := kernel-bin | gzip | save-raw-gz | fit gzip $$(KDIR)/image-$$(firstword $$(DEVICE_DTS)).dtb | ecnt-hdr2
  IMAGES := sysupgrade.bin tclinux-factory.bin
  IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata
  IMAGE/tclinux-factory.bin := ecnt-factory
  DEVICE_PACKAGES += kmod-usb-ohci kmod-usb3 \
                     hostapd-mbedtls wpa-supplicant-mbedtls \
                     kmod-mt7915e kmod-mt7916-firmware \
                     fit-check-image
endef
TARGET_DEVICES += skyworth_gn630v


define Device/tplink_ex530v-v1
  $(Device/Uboot-FitImage)
  DEVICE_VENDOR := TP-Link
  DEVICE_MODEL := ex530v
  DEVICE_VARIANT := v1
  DEVICE_PACKAGES += kmod-usb-ohci kmod-usb3 \
                     hostapd-mbedtls wpa-supplicant-mbedtls \
                     kmod-mt7915e kmod-mt7916-firmware  airoha-en7523-kite-npu-firmware
endef
TARGET_DEVICES += tplink_ex530v-v1

define Device/tplink_xx230v-v1
  $(Device/Uboot-FitImage)
  DEVICE_VENDOR := TP-Link
  DEVICE_MODEL := xx230v
  DEVICE_VARIANT := v1
  DEVICE_ALT0_VENDOR := TP-Link
  DEVICE_ALT0_MODEL := xx530v
  DEVICE_ALT0_VARIANT := v1
  DEVICE_PACKAGES += kmod-usb-ohci kmod-usb2 \
                     hostapd-mbedtls wpa-supplicant-mbedtls \
                     kmod-mt7915e kmod-mt7915-firmware kmod-mt7916-firmware \
                     airoha-en7571-firmware airoha-en7523-kite-npu-firmware
endef
TARGET_DEVICES += tplink_xx230v-v1
