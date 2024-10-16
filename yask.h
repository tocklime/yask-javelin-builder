//---------------------------------------------------------------------------

#pragma once
#include "main_flash_layout.h"
#include <stddef.h>
#include <stdint.h>

//---------------------------------------------------------------------------

#define JAVELIN_USE_EMBEDDED_STENO 1
#define JAVELIN_USE_USER_DICTIONARY 1
#define JAVELIN_USB_MILLIAMPS 100

#define JAVELIN_RGB 0
#define JAVELIN_RGB_COUNT 1
#define JAVELIN_RGB_PIN 23

#define JAVELIN_BUTTON_MATRIX 0
#define JAVELIN_BUTTON_PINS 1

// clang-format off
constexpr uint8_t BUTTON_PINS[] = {
    17, 1, 3,  5,  9, /**/  16, 18, 20, 22, 27, 15,  // Top row
    0,  2, 4,  6,     /**/      19, 21, 26, 28, 14,  // Middle row
            7, 8, 10,  /**/     13, 11, 12,          // Thumb row
};
constexpr uint32_t BUTTON_PIN_MASK = 0x1c7fffff;
//                                   0b0001_1100_0111_1111_1111_1111_1111_1111;


// #define BOOTSEL_BUTTON_INDEX 26

//
// Button indexes
// 0  1  2  3  4  |  5  6  7  8  9 10 
//11 12 13 14     |    15 16 17 18 19
//      20 21 22  | 23 24 25         
// clang-format on




#define JAVELIN_SCRIPT_CONFIGURATION                                           \
  R"({"name":"YASK","layout":[ {"x":0,"y":0}, {"x":1,"y":0}, {"x":2,"y":0}, {"x":3,"y":0}, {"x":4,"y":0}, {"x":6,"y":0}, {"x":7,"y":0}, {"x":8,"y":0}, {"x":9,"y":0}, {"x":10,"y":0}, {"x":11,"y":0}, {"x":0,"y":1}, {"x":1,"y":1}, {"x":2,"y":1}, {"x":3,"y":1}, {"x":7,"y":1}, {"x":8,"y":1}, {"x":9,"y":1}, {"x":10,"y":1}, {"x":11,"y":1}, {"x":2,"y":2}, {"x":3,"y":2}, {"x":4,"y":2}, {"x":6,"y":2}, {"x":7,"y":2}, {"x":8,"y":2}]})"

const size_t BUTTON_COUNT = 26;

const char *const MANUFACTURER_NAME = "ttempe";
const char *const PRODUCT_NAME = "YASK (Javelin)";
const int VENDOR_ID = 0xFEED;
const int PRODUCT_ID = 0xABCD;

//---------------------------------------------------------------------------
