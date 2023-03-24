#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <pthread.h>
#include <windows.h>
#include <iostream>


void* thread_func(void* arg)
{

    HANDLE thread = GetCurrentThread();
    DWORD_PTR threadAffinityMask = (DWORD_PTR)arg;

    BOOL success = SetProcessAffinityMask(thread, threadAffinityMask);

    return NULL;

}

int main()
{

    DWORD_PTR mask;

    clock_t start, end;
    double cpu_time_used;

    pthread_t id[100];

    start = clock();

    for(int j=0; j<100;j++){
    for(int i = 0; i < 4; i++){

            mask = 1 << i;
            pthread_create(&id[i], NULL, thread_func, (LPVOID)mask);
    }

    end = clock();
    }

  // for(int i = 0; i < 100; i++){
           // pthread_join(&id[i], NULL);

  // }


    cpu_time_used = (((double)(end - start)) / (double) CLOCKS_PER_SEC );

    std::cout << "Execution time of thread migration: " << cpu_time_used << " seconds" << std::endl;


    FILE* pointer = fopen("ThreadMigrationCpp.txt", "a");
    fprintf(pointer, "%.12lf ", cpu_time_used);

    fclose(pointer);


    return 0;
}


