# Assembly Coding Solutions

This repository contains solutions for the assembly coding challenges found at [Guyett's Coding Challenges](https://github.com/guyett92/coding-challenges?tab=readme-ov-file).

## Repository Structure

- Each challenge has its own directory named after the challenge.
- Each directory contains the following:
  - Assembly source code files (`*.s`).
  - Test cases and output files if applicable.

## Compiling each program

To compile each program I used the following commands:
```console
nasm -f elf64 program.s -o program.o
gcc -nostartfiles -no-pie -o program program.o -lc
```
