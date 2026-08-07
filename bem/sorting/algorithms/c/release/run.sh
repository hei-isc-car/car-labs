#!/bin/bash

while true; do
   clear
   dta_arg=""
   echo "Bubble Sort - C version"
   echo "    Data Selection"
   echo
   echo "1. 20"
   echo "2. 1k"
   echo "3. 5k"
   echo "4. 10k"
   echo "5. 10k (sorted)"
   echo "6. 50k"
   echo "7. 50k (sorted)"
   echo "8. 100k"
   echo "0. Exit"
   echo
   read -p "Enter your choice: " sel

   case $sel in
      1) dta_arg="../../../data/20.txt";;
      2) dta_arg="../../../data/1k.txt";;
      3) dta_arg="../../../data/5k.txt";;
      4) dta_arg="../../../data/10k.txt";;
      5) dta_arg="../../../data/10k_sorted.txt";;
      6) dta_arg="../../../data/50k.txt";;
      7) dta_arg="../../../data/50k_sorted.txt";;
      8) dta_arg="../../../data/100k.txt";;
      0) exit 0;;
      *) continue;;
   esac

   ./bubbleSort "$dta_arg"
   read -p "Press any key to continue..."
done
