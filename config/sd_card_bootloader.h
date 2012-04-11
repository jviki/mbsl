/**
 * parameters.h
 *
 * Default SD Card Bootloader configuration.
 */

/**
 * Filesystem settings.
 * At least one of FAT16 or FAT32 must be uncommented
 */

// Padded 8.3 image file name - always upper case
#define IMAGE_FILE "IMG00000BIN"

// partition containing the image
#define PARTITION 3

// Uncomment to allow FAT16
#define FAT16_SUPPORT
// Uncomment to allow FAT32
#define FAT32_SUPPORT

/**
 * Debugging & testing.
 */

// Uncomment to allow printing debug information on stdout, enlarge the bootloader by ~3.5kB
#define DEBUG

// Uncomment to allow (DDR2) memory test on start.
//#define MEMORY_TEST

/**
 * SD Card settings.
 */

// Select which SPI instance will be used for communication with SD card.
// Defaults to 0. Set another value only if you have more than one SPI
// bus in your design.
#define SD_SPI_INSTANCE 0

// Slave select mask. Defaults to 1. Set another value only if more than one device
// is connected to the SPI bus selected by SD_SPI_INSTANCE and SD card is not on
// signal SS<0>. This value is bitmask, only one '1' in word is allowed.
// Example: if SD card is on SS<1> set this mask to 2.
#define SD_SPI_SS_MASK 1

/**
 * Additional features.
 */

// Uncomment to allow encrypted srec files, enlarge the bootloader by ~0.5kB
#define CRYPTO

// Uncomment to disable CRC16 check of readed SD block.
// In this case we relay only on SREC record checksum to detect errors. Use this to speed up reading of the image file.
#define NO_CRC_16

// Exclude this last bytes from memory test to protect stack and heap.
// Uncomment this if stack or heap is in DDR SDRAM and set it to correct value.
#define MEM_PROTECT_BYTES 0x100000
