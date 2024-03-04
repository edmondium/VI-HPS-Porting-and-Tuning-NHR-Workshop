#!/bin/bash

#SBATCH --job-name=PIKA-BENCH
#SBATCH --nodes=1
#SBATCH --time=10
#SBATCH --exclusive


module load intel-compilers/2022.2.1 likwid

# Double-precision triad A(i) = B(i) * C(i) + D(i), optimized for AVX
time likwid-bench -t triad_avx -W N:4GB:208 -s 10

# some io
echo "Write and read a file..."


# write 
for i in {1..60}
do
  dd of=big.file count=1 bs=100M if=/dev/zero
  sleep 1
done

# read 
for i in {1..60}
do
  dd of=/dev/zero count=1 bs=100M if=big.file
  sleep 1
done

rm big.file

