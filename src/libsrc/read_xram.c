#include <loci.h>

int __fastcall__ read_xram (unsigned buf, unsigned count, int fildes)
{
    mia_push_int (buf);
    mia_push_int (count);
    mia_set_ax (fildes);
    return mia_call_int_errno (MIA_OP_READ_XRAM);
}
