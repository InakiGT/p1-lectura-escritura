#define SIZE 11
#include <stdio.h>

int media(int array[], int size) {
    int sum = 0;
    for(int i = 0; i < size; i++) {
        sum += array[i];
    }

    return sum / size;
}


int main() {
    int numbers[SIZE];
    for(int i = 0; i < SIZE; i++) {
        numbers[i] = 0;
    }
    int out = media(numbers, SIZE);
    return 0;
}