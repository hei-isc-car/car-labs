// Axam - 24.05.2023

#ifndef FCT_HPP
#define FCT_HPP

#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>

uint16_t* readFileToMem(char* fileName, size_t* rdSize)
{
  if (fileName == NULL)
  {
    perror("Filename is NULL");
    return NULL;
  }
  if (rdSize == NULL)
  {
    perror("ReadSize pointer is NULL");
    return NULL;
  }

  FILE *fp;
  // Count lines (could use realloc but meh)
  fp = fopen(fileName, "r");
  if (fp == NULL)
  {
    perror("Could not open given file");
    return NULL;
  }
  size_t lineNb = 0;
  char chunk[32];
  while(fgets(chunk, sizeof(chunk), fp) != NULL)
  {
    if (strlen(chunk) >= 31) // not counting null char
    {
      perror("Read too much - multi chunks not handled");
      return NULL;
    }
    lineNb ++;
  }
  fclose(fp);

  // Reserve memory
  uint16_t* values = (uint16_t*)calloc(lineNb, sizeof(uint16_t));
  if(values == NULL)
  {
    perror("Could not pre-allocate memory");
    return NULL;
  }
    // from here, values MUST BE FREED in case of error

  // Read values
  fp = fopen(fileName, "r");
  if (fp == NULL)
  {
    perror("Could not open given file");
    free(values);
    return NULL;
  }
  lineNb = 0;
  char* endPtr;
  while(fgets(chunk, sizeof(chunk), fp) != NULL)
  {
    values[lineNb++] = strtol(chunk, &endPtr, 10);
    if(endPtr == chunk)
    {
      perror("Could not convert string to integer");
      free(values);
      return NULL;
    }
  }
  fclose(fp);

  // All ok - return values (free handled by caller)
  *rdSize = lineNb;
  return values;
}

inline void bubbleSort(uint16_t* dta, size_t dta_len, bool useOpti)
{
  uint16_t temp;
  bool isSwapped = 0;
  size_t i,j;

  for(i=0; i < dta_len; i++)
  {
    isSwapped = 0;
    for(j=0; j < dta_len - 1; j++)
    {
      if(dta[j] > dta[j+1])
      {
        temp = dta[j+1];
        dta[j+1] = dta[j];
        dta[j] = temp;
        isSwapped = 1;
      }
    }
    if(useOpti && !isSwapped)
    {
      break;
    }
  }
}

#endif /* FCT_HPP */
