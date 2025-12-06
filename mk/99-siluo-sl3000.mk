define Device/siluo_sl3000
  DEVICE_VENDOR := Siluo
  DEVICE_MODEL := SL3000
  DEVICE_DTS := mt7981-siluo-sl3000
  DEVICE_PACKAGES := kmod-mt76 kmod-mt7981-firmware
  SUPPORTED_DEVICES := sl3000
  IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata
endef
TARGET_DEVICES += siluo_sl3000
