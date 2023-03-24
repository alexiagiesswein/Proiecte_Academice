#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <time.h>

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

    printf("Lock and unlock: %lf \n", execution_time);
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

    printf("Thread context switch took: %lf \n", execution_time);

    FILE* pointer = fopen("ThreadContextSwitchC.txt", "a");
    fprintf(pointer, "%.12lf ", execution_time/1000.0f);

    fclose(pointer);
    return 0;
}
