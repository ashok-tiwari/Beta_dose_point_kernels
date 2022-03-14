#include <stdio.h>
#include <stdlib.h>
int main (int argc, char **argv)
{
// Use : ./merge img1.raw img2.raw out.raw
// Add img1.raw and img2.raw in out.raw
FILE *pf1,*pf2,*pfh,*pfout;
pf1 = fopen(argv[1], "rb");
pf2 = fopen(argv[2], "rb");
//pfh = fopen(argv[3], "rb");
pfout = fopen(argv[3], "wb");
float tab1,tab2,res;
if(pf1 == NULL)
        {
        printf("Can't open the file\n");
        exit(0);
        }
if(pf2 == NULL)
        {
        printf("Can't open the file\n");
        exit(0);
        }
if(pfout == NULL)
        {
        printf("Can't open the file\n");
        exit(0);
        }

while(fread(&tab1,sizeof(float),1,pf1) == 1)
{
fread(&tab2,sizeof(float),1,pf2);
res = tab1 + tab2;
fwrite(&res,sizeof(float),1,pfout);
}

fclose(pf1);
fclose(pf2);
fclose(pfout);



}
