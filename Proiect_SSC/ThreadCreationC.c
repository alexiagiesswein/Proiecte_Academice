#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

void* thread_func(void* arg) {
    printf("Inside thread function\n");
    return NULL;
}

int main()
{

    clock_t start, end;
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
    end = clock();
    cpu_time_used = (((double)(end - start)) / CLOCKS_PER_SEC) / 10000;
    printf("Thread create took %.20f seconds to execute \n", cpu_time_used);

    FILE* pointer = fopen("ThreadCreationC.txt", "a");
    fprintf(pointer, "%.12lf ", cpu_time_used);

    fclose(pointer);


    return 0;
}

