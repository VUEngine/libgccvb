#include "types.h"
#include "audio.h"


volatile u8* const WAVEDATA1 =		(u8*)0x01000000;
volatile u8* const WAVEDATA2 =		(u8*)0x01000080;
volatile u8* const WAVEDATA3 =		(u8*)0x01000100;
volatile u8* const WAVEDATA4 =		(u8*)0x01000180;
volatile u8* const WAVEDATA5 =		(u8*)0x01000200;
volatile u8* const MODDATA =		(u8*)0x01000280;
volatile SOUNDREG* const SND_REGS =	(SOUNDREG*)0x01000400;