#define SIZE 11
#include <stdio.h>

int media(int array[], int size) {
    int sum = 0;
    for(int i = 0; i < size; i++) {
        sum += array[i];
    }

    return sum / size;
}

int ascii_to_int(char number[]) {
   int num = 0;
   for (int i = 0; number[i] != '\0'; i++) {
      num = num * 10 + (number[i] - '0');
   }
   return num;
}

int main() {
    int numbers[SIZE];
    for(int i = 0; i < SIZE; i++) {
        numbers[i] = 0;
    }
    int out = media(numbers, SIZE);
    return ascii_to_int("12");
}