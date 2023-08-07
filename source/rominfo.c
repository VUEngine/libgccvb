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
    GAME_TITLE,
    {0x00, 0x00, 0x00, 0x00, 0x00},
    MAKER_CODE,
    GAME_CODE,
    ROM_VERSION
};
