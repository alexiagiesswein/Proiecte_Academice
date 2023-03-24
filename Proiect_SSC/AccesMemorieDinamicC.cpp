#include <stdio.h>
#include <stdlib.h>
#include <time.h>


int main()
{
	clock_t start, end;
	double cpu_time_used;

    long long int* p;
    double* p2;
    int* p3;

    long long int* x;
    x = (long long int*)malloc(100 * sizeof(long long int));
    double* x2;
    x2 = (double*)malloc(100 * sizeof(double));
    int* x3;
    x3 = (int*)malloc(100 * sizeof(int));

    start = clock();
    for (int i = 0; i < 100000000; i++)
    {    
        p = x;
        p2 = x2;
        p3 = x3;
    }
    end = clock();
    cpu_time_used = (((double)(end - start)) / CLOCKS_PER_SEC)/3 ;
    printf("Dynamic memory access took %.20f * 10^(-8) seconds to execute \n", cpu_time_used);

    FILE* pointer = fopen("AccesLaMemorieDinamicC.txt", "a");
    fprintf(pointer, "%.12lf ", cpu_time_used);

    fclose(pointer);





	return 0;


}