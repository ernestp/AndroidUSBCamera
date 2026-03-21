######################################################################
# libjpeg-turbo 3.1.3 static library for Android NDK
######################################################################
LOCAL_PATH		:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE    := jpeg-turbo3130_static

LOCAL_C_INCLUDES := \
        $(LOCAL_PATH)/src \
        $(LOCAL_PATH)/simd \
        $(LOCAL_PATH)/simd/arm \

LOCAL_EXPORT_C_INCLUDES := \
        $(LOCAL_PATH)/src \
        $(LOCAL_PATH)/simd \
        $(LOCAL_PATH)/simd/arm \

LOCAL_CFLAGS := $(LOCAL_C_INCLUDES:%=-I%)
LOCAL_CFLAGS += -DANDROID_NDK
LOCAL_CFLAGS += -DBMP_SUPPORTED -DPPM_SUPPORTED

LOCAL_ARM_MODE := arm

LOCAL_ASMFLAGS += -DELF

LOCAL_SRC_FILES += \
	src/jcapimin.c \
	src/wrapper/jcapistd-8.c \
	src/wrapper/jcapistd-12.c \
	src/wrapper/jccoefct-8.c \
	src/wrapper/jccoefct-12.c \
	src/wrapper/jccolor-8.c \
	src/wrapper/jccolor-12.c \
	src/wrapper/jcdctmgr-8.c \
	src/wrapper/jcdctmgr-12.c \
	src/wrapper/jcdiffct-8.c \
	src/wrapper/jcdiffct-12.c \
	src/jchuff.c \
	src/jcicc.c \
	src/jcinit.c \
	src/jclhuff.c \
	src/wrapper/jclossls-8.c \
	src/wrapper/jclossls-12.c \
	src/wrapper/jcmainct-8.c \
	src/wrapper/jcmainct-12.c \
	src/jcmarker.c \
	src/jcmaster.c \
	src/jcomapi.c \
	src/jcparam.c \
	src/jcphuff.c \
	src/wrapper/jcprepct-8.c \
	src/wrapper/jcprepct-12.c \
	src/wrapper/jcsample-8.c \
	src/wrapper/jcsample-12.c \
	src/jctrans.c \
	src/jdapimin.c \
	src/wrapper/jdapistd-8.c \
	src/wrapper/jdapistd-12.c \
	src/jdatadst.c \
	src/jdatasrc.c \
	src/wrapper/jdcoefct-8.c \
	src/wrapper/jdcoefct-12.c \
	src/wrapper/jdcolor-8.c \
	src/wrapper/jdcolor-12.c \
	src/wrapper/jddctmgr-8.c \
	src/wrapper/jddctmgr-12.c \
	src/wrapper/jddiffct-8.c \
	src/wrapper/jddiffct-12.c \
	src/jdhuff.c \
	src/jdicc.c \
	src/jdinput.c \
	src/jdlhuff.c \
	src/wrapper/jdlossls-8.c \
	src/wrapper/jdlossls-12.c \
	src/wrapper/jdmainct-8.c \
	src/wrapper/jdmainct-12.c \
	src/jdmarker.c \
	src/jdmaster.c \
	src/wrapper/jdmerge-8.c \
	src/wrapper/jdmerge-12.c \
	src/jdphuff.c \
	src/wrapper/jdpostct-8.c \
	src/wrapper/jdpostct-12.c \
	src/wrapper/jdsample-8.c \
	src/wrapper/jdsample-12.c \
	src/jdtrans.c \
	src/jerror.c \
	src/jfdctflt.c \
	src/wrapper/jfdctfst-8.c \
	src/wrapper/jfdctfst-12.c \
	src/wrapper/jfdctint-8.c \
	src/wrapper/jfdctint-12.c \
	src/wrapper/jidctflt-8.c \
	src/wrapper/jidctflt-12.c \
	src/wrapper/jidctfst-8.c \
	src/wrapper/jidctfst-12.c \
	src/wrapper/jidctint-8.c \
	src/wrapper/jidctint-12.c \
	src/wrapper/jidctred-8.c \
	src/wrapper/jidctred-12.c \
	src/jmemmgr.c \
	src/jmemnobs.c \
	src/jpeg_nbits.c \
	src/wrapper/jquant1-8.c \
	src/wrapper/jquant1-12.c \
	src/wrapper/jquant2-8.c \
	src/wrapper/jquant2-12.c \
	src/wrapper/jutils-8.c \
	src/wrapper/jutils-12.c \
	src/wrapper/jutils-16.c \
	src/wrapper/jcapistd-16.c \
	src/wrapper/jccolor-16.c \
	src/wrapper/jcdiffct-16.c \
	src/wrapper/jclossls-16.c \
	src/wrapper/jcmainct-16.c \
	src/wrapper/jcprepct-16.c \
	src/wrapper/jcsample-16.c \
	src/wrapper/jdapistd-16.c \
	src/wrapper/jdcolor-16.c \
	src/wrapper/jddiffct-16.c \
	src/wrapper/jdlossls-16.c \
	src/wrapper/jdmainct-16.c \
	src/wrapper/jdpostct-16.c \
	src/wrapper/jdsample-16.c \

LOCAL_SRC_FILES += \
	src/jaricom.c \
	src/jcarith.c \
	src/jdarith.c \

LOCAL_SRC_FILES += \
	src/turbojpeg.c \
	src/transupp.c \
	src/jdatadst-tj.c \
	src/jdatasrc-tj.c \
	src/rdbmp.c \
	src/wrbmp.c \
	src/wrapper/rdppm-8.c \
	src/wrapper/rdppm-12.c \
	src/wrapper/rdppm-16.c \
	src/wrapper/wrppm-8.c \
	src/wrapper/wrppm-12.c \
	src/wrapper/wrppm-16.c \

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_SRC_FILES += \
	simd/arm/aarch32/jsimd.c \
	simd/arm/jcgray-neon.c \
	simd/arm/jcphuff-neon.c \
	simd/arm/jcsample-neon.c \
	simd/arm/jdmerge-neon.c \
	simd/arm/jdsample-neon.c \
	simd/arm/jfdctfst-neon.c \
	simd/arm/jidctred-neon.c \
	simd/arm/jquanti-neon.c \
	simd/arm/jccolor-neon.c \
	simd/arm/jidctint-neon.c \
	simd/arm/jidctfst-neon.c \
	simd/arm/aarch32/jchuff-neon.c \
	simd/arm/jdcolor-neon.c \
	simd/arm/jfdctint-neon.c \

LOCAL_CFLAGS += -DNEON_INTRINSICS
LOCAL_CFLAGS += -DSIZEOF_SIZE_T=4
LOCAL_CFLAGS += -mfpu=neon -mfloat-abi=softfp

else ifeq ($(TARGET_ARCH_ABI),arm64-v8a)
LOCAL_SRC_FILES += \
	simd/arm/aarch64/jsimd.c \
	simd/arm/jcgray-neon.c \
	simd/arm/jcphuff-neon.c \
	simd/arm/jcsample-neon.c \
	simd/arm/jdmerge-neon.c \
	simd/arm/jdsample-neon.c \
	simd/arm/jfdctfst-neon.c \
	simd/arm/jidctred-neon.c \
	simd/arm/jquanti-neon.c \
	simd/arm/jccolor-neon.c \
	simd/arm/jidctint-neon.c \
	simd/arm/jidctfst-neon.c \
	simd/arm/aarch64/jchuff-neon.c \
	simd/arm/jdcolor-neon.c \
	simd/arm/jfdctint-neon.c \

LOCAL_CFLAGS += -DNEON_INTRINSICS
LOCAL_CFLAGS += -DSIZEOF_SIZE_T=8

else ifeq ($(TARGET_ARCH_ABI),x86_64)
LOCAL_SRC_FILES += \
	simd/x86_64/jsimd.c \
	simd/x86_64/jsimdcpu.asm \
	simd/x86_64/jfdctflt-sse.asm \
	simd/x86_64/jccolor-sse2.asm \
	simd/x86_64/jcgray-sse2.asm \
	simd/x86_64/jcsample-sse2.asm \
	simd/x86_64/jdcolor-sse2.asm \
	simd/x86_64/jdmerge-sse2.asm \
	simd/x86_64/jdsample-sse2.asm \
	simd/x86_64/jfdctfst-sse2.asm \
	simd/x86_64/jfdctint-sse2.asm \
	simd/x86_64/jidctflt-sse2.asm \
	simd/x86_64/jidctfst-sse2.asm \
	simd/x86_64/jidctint-sse2.asm \
	simd/x86_64/jidctred-sse2.asm \
	simd/x86_64/jquantf-sse2.asm \
	simd/x86_64/jquanti-sse2.asm \
	simd/x86_64/jchuff-sse2.asm \

LOCAL_CFLAGS += -DSIZEOF_SIZE_T=8
LOCAL_ASMFLAGS += -D__x86_64__

else ifeq ($(TARGET_ARCH_ABI),x86)
LOCAL_SRC_FILES += \
	simd/i386/jsimd.c \
	simd/i386/jsimdcpu.asm \
	simd/i386/jfdctflt-3dn.asm \
	simd/i386/jidctflt-3dn.asm \
	simd/i386/jquant-3dn.asm \
	simd/i386/jccolor-mmx.asm \
	simd/i386/jcgray-mmx.asm \
	simd/i386/jcsample-mmx.asm \
	simd/i386/jdcolor-mmx.asm \
	simd/i386/jdmerge-mmx.asm \
	simd/i386/jdsample-mmx.asm \
	simd/i386/jfdctfst-mmx.asm \
	simd/i386/jfdctint-mmx.asm \
	simd/i386/jidctfst-mmx.asm \
	simd/i386/jidctint-mmx.asm \
	simd/i386/jidctred-mmx.asm \
	simd/i386/jquant-mmx.asm \
	simd/i386/jfdctflt-sse.asm \
	simd/i386/jidctflt-sse.asm \
	simd/i386/jquant-sse.asm \
	simd/i386/jccolor-sse2.asm \
	simd/i386/jcgray-sse2.asm \
	simd/i386/jcsample-sse2.asm \
	simd/i386/jdcolor-sse2.asm \
	simd/i386/jdmerge-sse2.asm \
	simd/i386/jdsample-sse2.asm \
	simd/i386/jfdctfst-sse2.asm \
	simd/i386/jfdctint-sse2.asm \
	simd/i386/jidctflt-sse2.asm \
	simd/i386/jidctfst-sse2.asm \
	simd/i386/jidctint-sse2.asm \
	simd/i386/jidctred-sse2.asm \
	simd/i386/jquantf-sse2.asm \
	simd/i386/jquanti-sse2.asm \
	simd/i386/jchuff-sse2.asm \

LOCAL_CFLAGS += -DSIZEOF_SIZE_T=4

endif

LOCAL_CPPFLAGS += -Wno-incompatible-pointer-types

LOCAL_DISABLE_FATAL_LINKER_WARNINGS := true

include $(BUILD_STATIC_LIBRARY)

######################################################################
# jpeg-turbo3130.so
######################################################################
include $(CLEAR_VARS)
LOCAL_EXPORT_C_INCLUDES := \
        $(LOCAL_PATH)/src \

LOCAL_DISABLE_FATAL_LINKER_WARNINGS := true

LOCAL_LDLIBS := -L$(SYSROOT)/usr/lib -ldl

LOCAL_WHOLE_STATIC_LIBRARIES = jpeg-turbo3130_static

LOCAL_MODULE := jpeg-turbo3130
include $(BUILD_SHARED_LIBRARY)

