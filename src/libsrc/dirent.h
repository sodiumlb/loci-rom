/*****************************************************************************/
/*                                                                           */
/*                                 dirent.h                                  */
/*                                                                           */
/*                        Directory entries for cc65                         */
/*                                                                           */
/*                                                                           */
/*                                                                           */
/* (C) 2005  Oliver Schmidt, <ol.sc@web.de>                                  */
/*                                                                           */
/*                                                                           */
/* This software is provided 'as-is', without any expressed or implied       */
/* warranty.  In no event will the authors be held liable for any damages    */
/* arising from the use of this software.                                    */
/*                                                                           */
/* Permission is granted to anyone to use this software for any purpose,     */
/* including commercial applications, and to alter it and redistribute it    */
/* freely, subject to the following restrictions:                            */
/*                                                                           */
/* 1. The origin of this software must not be misrepresented; you must not   */
/*    claim that you wrote the original software. If you use this software   */
/*    in a product, an acknowledgment in the product documentation would be  */
/*    appreciated but is not required.                                       */
/* 2. Altered source versions must be plainly marked as such, and must not   */
/*    be misrepresented as being the original software.                      */
/* 3. This notice may not be removed or altered from any source              */
/*    distribution.                                                          */
/*                                                                           */
/*****************************************************************************/



#ifndef _DIRENT_H
#define _DIRENT_H

#include <target.h>



/*****************************************************************************/
/*                                   Data                                    */
/*****************************************************************************/



typedef struct DIR DIR;

// File attributes bits for directory entry
#define	DIR_ATTR_RDO	0x01	/* Read only */
#define DIR_ATTR_SYS    0x04    /* System files (devices) */
#define DIR_ATTR_DIR	0x10	/* Directory */

struct dirent {
    int d_fd;
    char d_name[64];
    unsigned char d_attrib;
    unsigned char reserved;
    unsigned long d_size;
};

#define _DE_ISREG(t)    ((t) & DIR_ATTR_DIR == 0)
#define _DE_ISDIR(t)    ((t) & DIR_ATTR_DIR != 0)
#define _DE_ISLBL(t)    (0)
#define _DE_ISLNK(t)    (0)



/*****************************************************************************/
/*                                   Code                                    */
/*****************************************************************************/



DIR* __fastcall__ opendir (const char* name);

struct dirent* __fastcall__ readdir (DIR* dir);

int __fastcall__ closedir (DIR* dir);

long __fastcall__ telldir (DIR* dir);

void __fastcall__ seekdir (DIR* dir, long offs);

void __fastcall__ rewinddir (DIR* dir);



/* End of dirent.h */
#endif
