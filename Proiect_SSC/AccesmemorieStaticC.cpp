#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main()
{
	clock_t start, end;
	double cpu_time_used;

    long long int* p;
    double* p2;
    char* p3;

    long long int x;
    double x2;
    char x3;

    start = clock();
    for (int i = 0; i < 100000000; i++)
    {   
        p = &x;
        p2 = &x2;
        p3 = &x3;
    }
    end = clock();
    cpu_time_used = (((double)(end - start)) / CLOCKS_PER_SEC)/3;
    printf("Static memory access took %.20f * 10^(-8) seconds to execute \n", cpu_time_used);

    FILE* pointer = fopen("AccesulLaMemorieStaticC.txt", "a");
    fprintf(pointer, "%.12lf ", cpu_time_used);

    fclose(pointer);



	return 0;
}