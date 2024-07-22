#!/bin/bash
#SBATCH --job-name=fine
#SBATCH --partition=multigpu
#SBATCH --gres=gpu:v100-sxm2:1
#SBATCH --nodes=1
#SBATCH --output=out.txt
#SBATCH --error=error.txt
#SBATCH --time=0:15:00
#SBATCH --exclude=d1008
cd /work/karmalab/mingwang/DAD/try2021_final/permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/ci0.1_fine_taupi0.025_tausi0.01_Vratio_1
module load cuda/11.1
module load gcc/6.4.0
nvcc cell.cu -O3 -lm -arch sm_70  -o cell -lfftw3 -I/shared/centos7/fftw/3.3.8/include -L/shared/centos7/fftw/3.3.8/lib
./cell 0 0.1 689 10 8 0.3 0.006 1.4 1.4
