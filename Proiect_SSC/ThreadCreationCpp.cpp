#include <iostream>
#include <time.h>
#include <thread>
using namespace std;

int main()
{
    clock_t start, end1;
    double cpu_time_used;

    pthread_t id;
    pthread_t id2;
    pthread_t id3;
    pthread_t id4;
    pthread_t id5;
    pthread_t id6;


    start = clock();
    for (int i = 0; i < 10000; i++)
    {

        pthread_create(&id, NULL, NULL, NULL);
        pthread_create(&id2, NULL, NULL, NULL);
        pthread_create(&id3, NULL, NULL, NULL);
        pthread_create(&id4, NULL, NULL, NULL);
        pthread_create(&id5, NULL, NULL, NULL);
        pthread_create(&id6, NULL, NULL, NULL);
    }
    end1 = clock();
    cpu_time_used = (((double)(end1 - start)) / CLOCKS_PER_SEC) / 10000;
    cout.precision(20);
    cout<<"Thread creation took "<<cpu_time_used<<" seconds to execute \n";

    FILE* pointer = fopen("ThreadCreationCpp.txt", "a");
    fprintf(pointer, "%.12lf ", cpu_time_used);

    fclose(pointer);
    return 0;
}
