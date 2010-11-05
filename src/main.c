#include <stdio.h>
#include <stdlib.h>
#include <hellolib.h>

int main(int argc, char* argv[])
{
    int a, b, res;

    if (argc < 3)
    {
        printf("Usage: helloworld <operand1> <operand2>\n");
        return 1;
    }

    a = atoi(argv[1]);
    b = atoi(argv[2]);
    res = mul(a, b);

    printf("The product of %i * %i = %i\n", a, b, res);

    return 0;
}