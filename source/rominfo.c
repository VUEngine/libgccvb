#include <types.h>
#include <rominfo.h>

typedef const struct ROMInfo
{
    // Game Title
    char title[20];

    // Reserved
    BYTE reserved[5];

    // Published ID
    char publisherID[2];

    // Published ID
    char gameID[4];

    // ROM Version
    BYTE version;

} ROMInfo;

ROMInfo romInfo __attribute__((section(".rominfo"))) =
{
    __GAME_TITLE,
    {0x00, 0x00, 0x00, 0x00, 0x00},
    __MAKER_CODE,
    __GAME_CODE,
    __ROM_VERSION
};
