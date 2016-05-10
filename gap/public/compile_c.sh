#!/bin/sh

gcc gap.c grader.c -o gap -O2 -static -lm -std=c11
