#!/bin/bash
g++ -o line1 -lpthread line1.c
g++ -o line2 -lpthread line2.c
echo Common buffer
time ./line1
echo Different buffer
time ./line2