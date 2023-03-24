#include<iostream>
using namespace std;

int main()
{
	clock_t start, end;
	double cpu_time_used;

    start = clock();
    for (int i = 0; i < 1000000; i++)
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
    cout.precision(10);
    cout << "Static memory allocation took " << cpu_time_used << " * 10^(-8) seconds to execute \n";

    FILE* pointer = fopen("AlocareDeMemorieStaticaCpp.txt", "a");
    fprintf(pointer, "%.12lf ", cpu_time_used);

    fclose(pointer);





	return 0;
}