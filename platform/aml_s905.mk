ifeq ($(CONFIG_PLATFORM_AML_S905), y)
ccflags-y += -DCONFIG_PLATFORM_AML_S905
ccflags-y += -DCONFIG_LITTLE_ENDIAN
ccflags-y += -DCONFIG_IOCTL_CFG80211 -DRTW_USE_CFG80211_STA_EVENT
ccflags-y += -DCONFIG_RADIO_WORK
ccflags-y += -DCONFIG_CONCURRENT_MODE
ifeq ($(shell test $(CONFIG_RTW_ANDROID) -ge 11; echo $$?), 0)
ccflags-y += -DCONFIG_IFACE_NUMBER=3
endif

# default setting for Android
# config CONFIG_RTW_ANDROID in main Makefile

ARCH ?= arm64
CROSS_COMPILE ?= /home/Jimmy/amlogic_905x4+8852AS/skw-rtk/cross_compile_toolchain/gcc-linaro-6.3.1-2017.02-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-
ifndef KSRC
#KSRC := /home/sd4ce/sdk/amlogic_905x4_8852ae/kernel_headers
#KSRC += O=/home/sd4ce/sdk/amlogic_905x4_8852ae/KERNEL_OBJ
KSRC := $(KERNEL_SRC)
endif

#Add by amlogic
ccflags-y += -w -Wno-return-type
ccflags-y += $(foreach d,$(shell test -d $(KERNEL_SRC)/$(M) && find $(shell cd $(KERNEL_SRC)/$(M);pwd) -type d),$(shell echo " -I$(d)"))
ifeq ($(CONFIG_PCI_HCI), y)
ccflags-y += -DUSE_AML_PCIE_TEE_MEM
endif

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

ifeq ($(CONFIG_RTL8852B), y)
ifeq ($(CONFIG_SDIO_HCI), y)
CONFIG_RTL8852BS ?= m
USER_MODULE_NAME := 8852bs
endif
ifeq ($(CONFIG_PCI_HCI), y)
CONFIG_RTL8852BE ?= m
USER_MODULE_NAME := 8852be
endif
endif
_PLATFORM_FILES += platform/platform_ops.o
endif
