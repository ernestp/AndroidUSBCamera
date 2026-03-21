#include $(call all-subdir-makefiles)
PROJ_PATH	:= $(call my-dir)
include $(CLEAR_VARS)
LOCAL_CFLAGS += -fPIC
LOCAL_ASFLAGS += -DPIC
include $(PROJ_PATH)/UVCCamera/Android.mk
include $(PROJ_PATH)/libjpeg-turbo-3.1.3/Android.mk
include $(PROJ_PATH)/libusb/android/jni/Android.mk
include $(PROJ_PATH)/libuvc/android/jni/Android.mk