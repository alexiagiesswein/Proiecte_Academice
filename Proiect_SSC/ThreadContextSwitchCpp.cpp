#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <time.h>
#include <iostream>

pthread_mutex_t mutex;
double execution_time = 0;

void* thread_func1(void* arg)
{
    pthread_mutex_lock(&mutex);

    pthread_mutex_unlock(&mutex);
    return NULL;
}

void* thread_func2(void* arg)
{
    clock_t start, end;
    double cpu_time_used;

    start = clock();

    pthread_mutex_lock(&mutex);

    end = clock();

    cpu_time_used = (((double)(end - start)) / (double) CLOCKS_PER_SEC );
    execution_time += cpu_time_used;

    std::cout << "Lock and unlock: " << execution_time/10000 << " seconds" << std::endl;
    pthread_mutex_unlock(&mutex);
    return NULL;
}

int main(void)
{
     pthread_t id;
     pthread_t id2;

    for(int i = 0; i<1000; i++){

        pthread_create(&id, NULL, thread_func1, NULL);
        pthread_create(&id2, NULL, thread_func2, NULL);

    }



    pthread_join(id, NULL);
    pthread_join(id2, NULL);

    std::cout << "Execution time of thread context switch: " << execution_time/10000 << " seconds" << std::endl;

    FILE* pointer = fopen("ThreadContextSwitchCpp.txt", "a");
    fprintf(pointer, "%.12lf ", execution_time/1000.0f);

    fclose(pointer);
    return 0;
}




