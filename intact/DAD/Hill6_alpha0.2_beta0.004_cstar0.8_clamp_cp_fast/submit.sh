#!/bin/bash
#SBATCH --job-name=cs0H6
#SBATCH --partition=multigpu
#SBATCH --gres=gpu:v100-sxm2:1
#SBATCH --nodes=1
#SBATCH --output=out.txt
#SBATCH --error=error.txt
#SBATCH --time=0:40:00
cd /work/karmalab/mingwang/DAD/try2021_final/DAD/Hill6_alpha0.2_beta0.004_cstar0.8_clamp_cp_fast
module load cuda/11.1
module load gcc/6.4.0
nvcc cell.cu -O3 -lm -arch sm_70  -o cell -lfftw3 -I/shared/centos7/fftw/3.3.8/include -L/shared/centos7/fftw/3.3.8/lib
stdbuf -oL ./cell  0  0.14  600 10 6 0.2 0.004 0.8 0.8 &> out.txt
