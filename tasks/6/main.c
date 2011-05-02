#include <stdio.h>
#include <stdlib.h>

int a[100][100], b[100][100], c[100][100];

int main(int argc, char *argv[])
{
    int i, j, k;
    if (argc != 2)
    {
        printf("enter number of iterations\n");
        exit(1);
    }
    int it;
    it = strtol(argv[1], null, 10);
    for (i = 0; i < it; i++)
    {
        for (j = 0; j < 100; j++)
        {
            for (k = 0; k < 100; k++)
            {
                a[j][k] = b[j][k] + c[j][k];
            }
        }
    }

    return 0;
}
