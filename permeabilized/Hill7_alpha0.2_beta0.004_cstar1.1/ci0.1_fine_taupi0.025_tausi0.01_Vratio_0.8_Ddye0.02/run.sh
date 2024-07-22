#!/bin/bash

if [ -f "submit.sh" ]; then
	rm submit.sh
fi

echo 	"#!/bin/bash" >> submit.sh
echo 	"#SBATCH --job-name=0.02" >> submit.sh
echo 	"#SBATCH --partition=multigpu" >> submit.sh
echo 	"#SBATCH --gres=gpu:v100-sxm2:1" >> submit.sh
echo 	"#SBATCH --nodes=1" >> submit.sh
echo 	"#SBATCH --output=out.txt" >> submit.sh
echo 	"#SBATCH --error=error.txt" >> submit.sh
echo 	"#SBATCH --time=0:15:00" >> submit.sh
echo    "#SBATCH --exclude=d1008" >> submit.sh
echo 	"cd $(pwd)" >> submit.sh
echo 	"module load cuda/11.1" >> submit.sh
echo 	"module load gcc/6.4.0" >> submit.sh
echo 	"nvcc cell.cu -O3 -lm -arch sm_70  -o cell -lfftw3 -I/shared/centos7/fftw/3.3.8/include -L/shared/centos7/fftw/3.3.8/lib" >> submit.sh
echo 	"./cell 0 0.1 689 10 8 0.3 0.006 1.4 1.4" >> submit.sh

sbatch submit.sh
