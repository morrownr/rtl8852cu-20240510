ifeq ($(CONFIG_PLATFORM_RTK1319), y)
ccflags-y += -DCONFIG_LITTLE_ENDIAN
ccflags-y += -DCONFIG_IOCTL_CFG80211 -DRTW_USE_CFG80211_STA_EVENT
ccflags-y += -DCONFIG_RADIO_WORK
ccflags-y += -DCONFIG_CONCURRENT_MODE
ifeq ($(shell test $(CONFIG_RTW_ANDROID) -ge 11; echo $$?), 0)
ccflags-y += -DCONFIG_IFACE_NUMBER=3
endif

ccflags-y += -DRTK_1319_PLATFORM -DCONFIG_RF4CE_COEXIST
#ccflags-y += -Wno-error=date-time

ARCH ?= arm
# For Android 10
#CROSS_COMPILE :=/sweethome/zhenrc/Workshop/1619/atv-9.0/phoenix/toolchain/asdk-6.4.1-a53-EL-4.9-g2.26-a32nut-180831/bin/arm-linux-gnueabi-
#KSRC :=/sweethome/zhenrc/Workshop/1619/atv-9.0/hydra/linux-kernel-1319
# For TV image
CROSS_COMPILE :=/sweethome/zhenrc/Workshop/1619/atv-9.0/phoenix/toolchain/asdk-6.4.1-a53-EL-4.9-g2.26-a32nut-180831/bin/arm-linux-gnueabi-
KSRC := /sweethome/zhenrc/Workshop/1319/q_tv_kernel_ax

ifeq ($(CONFIG_PCI_HCI), y)
ccflags-y += -DRTK_1319_PCIE_PORT=2
ccflags-y += -DCONFIG_PLATFORM_OPS
_PLATFORM_FILES := platform/platform_linux_pc_pci.o
OBJS += $(_PLATFORM_FILES)
# Core Config
# CONFIG_RTKM - n/m/y for not support / standalone / built-in
CONFIG_RTKM = m
CONFIG_MSG_NUM = 128
ccflags-y += -DCONFIG_MSG_NUM=$(CONFIG_MSG_NUM)
ccflags-y += -DCONFIG_RXBUF_NUM_1024
ccflags-y += -DCONFIG_TX_SKB_ORPHAN
ccflags-y += -DCONFIG_DIS_DYN_RXBUF
# PHL Config
ccflags-y += -DRTW_WKARD_98D_RXTAG
endif
_PLATFORM_FILES += platform/platform_ops.o
endif
