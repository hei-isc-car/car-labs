#!/bin/bash
hyperfine -i './bubbleSort ../../data/1k.txt' './bubbleSort ../../data/10k.txt' './bubbleSort ../../data/50k.txt' --export-markdown hypefine-results.md
