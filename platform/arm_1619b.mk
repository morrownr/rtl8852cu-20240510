ifeq ($(CONFIG_PLATFORM_RTK16XXB), y)
ccflags-y += -DCONFIG_LITTLE_ENDIAN
ccflags-y += -DCONFIG_IOCTL_CFG80211 -DRTW_USE_CFG80211_STA_EVENT
ccflags-y += -DCONFIG_RADIO_WORK
ccflags-y += -DCONFIG_CONCURRENT_MODE
ccflags-y += -DRTK_1619B_PLATFORM

# CONFIG_RTW_ANDROID - 0: no Android, 4/5/6/7/8/9/10/11 : Android version
CONFIG_RTW_ANDROID = $(PLTFM_VER)

ifeq ($(shell test $(CONFIG_RTW_ANDROID) -gt 0; echo $$?), 0)
ccflags-y += -DCONFIG_RTW_ANDROID=$(CONFIG_RTW_ANDROID)
endif

ifeq ($(shell test $(CONFIG_RTW_ANDROID) -ge 11; echo $$?), 0)
ccflags-y += -DCONFIG_IFACE_NUMBER=3
endif

ARCH ?= arm

CROSS_COMPILE := $(CROSS)
KSRC := $(LINUX_KERNEL_PATH)

ifeq ($(CONFIG_PCI_HCI), y)
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
