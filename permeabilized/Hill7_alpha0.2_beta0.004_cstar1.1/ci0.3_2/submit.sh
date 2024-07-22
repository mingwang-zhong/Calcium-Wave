#!/bin/bash
#SBATCH --job-name=H7c12
#SBATCH --partition=karma
#SBATCH --gres=gpu:v100-sxm2:1 # v100-sxm2
#SBATCH --nodes=1
#SBATCH --output=out.txt
#SBATCH --error=error.txt
#SBATCH --time=2:50:00
#SBATCH --exclude=d1008
cd /work/karmalab/mingwang/DAD/try2021_final/permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/ci0.3_2
module load cuda/11.1
module load gcc/6.4.0
nvcc cell.cu -O3 -lm -arch sm_70  -o cell -lfftw3 -I/shared/centos7/fftw/3.3.8/include -L/shared/centos7/fftw/3.3.8/lib
./cell  0  0.3  750 10 7 0.2 0.004 1.1 1.1
