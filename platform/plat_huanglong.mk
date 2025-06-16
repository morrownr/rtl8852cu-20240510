ifeq ($(CONFIG_PLATFORM_HUANGLONG), y)
ccflags-y += -DCONFIG_LITTLE_ENDIAN -fno-pic
ccflags-y += -DCONFIG_IOCTL_CFG80211 -DRTW_USE_CFG80211_STA_EVENT
ccflags-y += -DCONFIG_RADIO_WORK
ccflags-y += -DCONFIG_CONCURRENT_MODE

ccflags-y += -DCONFIG_PLATFORM_HUANGLONG
#ccflags-y += -Wno-error=date-time

# CONFIG_RTW_ANDROID - 0: no Android, 4/5/6/7/8/9/10/11 : Android version
CONFIG_RTW_ANDROID = 11

ifeq ($(shell test $(CONFIG_RTW_ANDROID) -gt 0; echo $$?), 0)
ccflags-y += -DCONFIG_RTW_ANDROID=$(CONFIG_RTW_ANDROID)
endif

ifeq ($(shell test $(CONFIG_RTW_ANDROID) -ge 11; echo $$?), 0)
ccflags-y += -DCONFIG_IFACE_NUMBER=3
endif

KSRC := $(LINUX_DIR)
ARCH := $(CFG_SOCT_CPU_ARCH)
CROSS_CONPILE := $(SOCT_KERNEL_TOOLCHAINS_MAME)-


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
