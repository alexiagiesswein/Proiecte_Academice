#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main()
{
    clock_t start, end;
    double cpu_time_used;

    start = clock();
    for (int i = 0; i < 100000000; i++)
    {
        int vec[10000];
        long long int vec2[10000];
        int vec3[10000];
        float vec4[10000];
        char c;
        char s[1000];
        double d;
    }
    end = clock();
    cpu_time_used = (((double)(end - start)) / CLOCKS_PER_SEC)/7 ;
    printf("Static memory allocation took %.10f * 10^(-8) seconds to execute \n", cpu_time_used);

    FILE* pointer = fopen("AlocareDeMemorieStaticaC.txt", "a");
    fprintf(pointer, "%.12lf ", cpu_time_used);

    fclose(pointer);
    return 0;
}