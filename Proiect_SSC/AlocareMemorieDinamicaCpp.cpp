#include<iostream>
using namespace std;


int main()
{
	clock_t start, end;
	double cpu_time_used;

    int* ptr;

    start = clock();
    for (int i = 0; i < 1000000; i++)
    {
        
        ptr = (int*)malloc(100 * sizeof(int));
    }
    end = clock();
    cpu_time_used = (((double)(end - start)) / CLOCKS_PER_SEC);
    cout.precision(20);
    cout << "Dynamic memory allocation took " << cpu_time_used << " * 10^(-6) seconds to execute \n";

    FILE* pointer = fopen("AlocareDeMemorieDinamicaCpp.txt", "a");
    fprintf(pointer, "%.12lf ", cpu_time_used);

    fclose(pointer);



	return 0;
}