#include <stdio.h>

extern unsigned int min(unsigned int a, unsigned int b);

int main()
{
    unsigned int a, b;
    a = 1;
    b = 2;
	printf("min(%d,%d)=%d\n", a, b, min(a, b));

	return 0;
}
