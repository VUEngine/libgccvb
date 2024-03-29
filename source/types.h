#ifndef _LIBGCCVB_TYPES_H
#define _LIBGCCVB_TYPES_H


// quick, easy types			Byte(s)           Range
typedef unsigned char 	u8;		/* 1               0 ...           255 */
typedef unsigned short 	u16;	/* 2               0 ...        65,535 */
typedef unsigned long 	u32;	/* 4		       0 ... 4,294,967,295 */

typedef signed char 	s8;		/* 1            -128 ...           127*/
typedef signed short 	s16;	/* 2         -32,768 ...        32,767*/
typedef signed long 	s32;	/* 4  -2,147,483,648 ... 2,147,483,647 */

typedef unsigned char 	BYTE;	/* 1               0 ...           255 */
typedef unsigned short 	HWORD;	/* 2               0 ...        65,535 */
typedef unsigned long 	WORD;	/* 4		       0 ... 4,294,967,295 */

// VUEngine type names for compatiblity
typedef unsigned char 		uint8;
typedef unsigned short 		uint16;
typedef unsigned int 		uint32;
typedef unsigned long long	uint64;

typedef signed char 		int8;
typedef signed short 		int16;
typedef signed int	 		int32;
typedef signed long long 	int64;

// define of boolean type
typedef uint8				bool;
enum { false, true };

// for fixed point math
#define f8 			s8
#define f16 		s16
#define f32 		s32


#endif