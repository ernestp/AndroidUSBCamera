/* jconfig.h - Android NDK build configuration for libjpeg-turbo 3.1.3 */

/* Version ID for the JPEG library. */
#define JPEG_LIB_VERSION  62

/* libjpeg-turbo version */
#define LIBJPEG_TURBO_VERSION  3.1.3

/* libjpeg-turbo version in integer form */
#define LIBJPEG_TURBO_VERSION_NUMBER  3001003

/* Support arithmetic encoding when using 8-bit samples */
#define C_ARITH_CODING_SUPPORTED 1

/* Support arithmetic decoding when using 8-bit samples */
#define D_ARITH_CODING_SUPPORTED 1

/* Support in-memory source/destination managers */
#define MEM_SRCDST_SUPPORTED  1

/* Use accelerated SIMD routines when using 8-bit samples */
#define WITH_SIMD 1

/* This version of libjpeg-turbo supports run-time selection of data precision */
#ifndef BITS_IN_JSAMPLE
#define BITS_IN_JSAMPLE  8
#endif

/* Define if your (broken) compiler shifts signed values as if they were unsigned. */
/* #undef RIGHT_SHIFT_IS_UNSIGNED */
