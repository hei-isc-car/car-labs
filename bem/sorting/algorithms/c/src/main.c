// Axam - 24.05.2023

#include "fct.hpp"

#include <time.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdlib.h>

int main(int argc, char** argv)
{
  setbuf(stdout, NULL);

  // Read file
  printf("Checking args\n");
  if(argc < 2)
  {
    perror("Please give a filename as first arguments");
    return -1;
  }

  // Read data
  printf("Reading data into memory\n");
  size_t values_length = 0;
  uint16_t* values = readFileToMem(argv[1], &values_length);
  if(values == NULL)
  {
    perror("Cannot continue with no values - exiting");
    return -1;
  }
  printf(" * Found %llu data\n", values_length);
  // Copy for opti algo
  printf("Copying data for opti. algo\n");
  uint16_t* values2 = (uint16_t*)calloc(values_length, sizeof(uint16_t));
  if(values2 == NULL)
  {
    perror("Could not duplicate data for opti. algo - exiting");
    free(values);
    return -1;
  }
  for(size_t i = 0; i < values_length; i++)
  {
    values2[i] = values[i];
  }

  // Sort
  printf("Sorting\n");
  clock_t begin = clock();
  bubbleSort(values, values_length, 0);
  clock_t end = clock();
  double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
  printf(" * Bubble sort (non-opti) done in %llu [ms]\n", (uint64_t)(time_spent*1000));

  begin = clock();
  bubbleSort(values2, values_length, 1);
  end = clock();
  time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
  printf(" * Bubble sort (optimized) done in %llu [ms]\n", (uint64_t)(time_spent*1000));

  //Free pointers
  free(values);
  free(values2);
}
