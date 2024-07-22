#!/bin/bash
#SBATCH --job-name=9c4H5
#SBATCH --partition=multigpu
#SBATCH --gres=gpu:v100-sxm2:1
#SBATCH --nodes=1
#SBATCH --output=out.txt
#SBATCH --error=error.txt
#SBATCH --time=2:40:00
#SBATCH	--exclude=d1008
cd /work/karmalab/mingwang/DAD/try2021_final/DAD_2Hz/Hill5_alpha0.2_beta0.001_cstar1.6
module load cuda/11.1
module load gcc/6.4.0
nvcc cell.cu -O3 -lm -arch sm_70  -o cell -lfftw3 -I/shared/centos7/fftw/3.3.8/include -L/shared/centos7/fftw/3.3.8/lib
stdbuf -oL ./cell  0  0.14  600 10 5 0.2 0.001 1.6 1.6 &> out.txt
