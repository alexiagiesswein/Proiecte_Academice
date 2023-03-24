#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main()
{
	clock_t start, end;
	double cpu_time_used;

    start = clock();
    for (int i = 0; i < 1000000; i++)
    {
        int* ptr;
        ptr = (int*)malloc(100 * sizeof(int));
    }
    end = clock();
    cpu_time_used = (((double)(end - start)) / CLOCKS_PER_SEC) ;
    printf("Dynamic memory allocation took %.10f * 10^(-6) seconds to execute \n", cpu_time_used);
    FILE* pointer = fopen("AlocareDeMemorieDinamicaC.txt", "a");
    fprintf(pointer, "%.12lf ", cpu_time_used);

    fclose(pointer);


	return 0;
}