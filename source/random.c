#include "types.h"
#include "random.h"

// Returns a random number in the requested range from the random seed
u32 rng(u32 *seed, u32 max) {
    *seed = *seed * 0x41C64E6D + 12345;
    return (*seed >> 16 & 0x7FFF) * (max + 1) / 0x8000;
}
