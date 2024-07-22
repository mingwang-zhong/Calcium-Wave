#!/bin/bash

J=$(awk "BEGIN {printf 10 }")
H=$(awk "BEGIN {printf 7 }")
alpha=$(awk "BEGIN {printf 0.2 }")
beta=$(awk "BEGIN {printf 0.004 }")
custar=$(awk "BEGIN {printf 1.1 }")
cbstar=$(awk "BEGIN {printf ${custar} }")

ci=$(awk "BEGIN {printf 0.3 }")
cj=$(awk "BEGIN {printf 800 }")

if [ -f "submit.sh" ]; then
	rm submit.sh
fi

echo 	"#!/bin/bash" >> submit.sh
echo 	"#SBATCH --job-name=H${H}c${i}" >> submit.sh
echo 	"#SBATCH --partition=multigpu" >> submit.sh
echo 	"#SBATCH --gres=gpu:v100-sxm2:1" >> submit.sh
echo 	"#SBATCH --nodes=1" >> submit.sh
echo 	"#SBATCH --output=out.txt" >> submit.sh
echo 	"#SBATCH --error=error.txt" >> submit.sh
echo 	"#SBATCH --time=0:4:00" >> submit.sh
echo 	"#SBATCH --exclude=d1008" >> submit.sh

echo 	"cd $(pwd)" >> submit.sh
echo 	"module load cuda/11.1" >> submit.sh
echo 	"module load gcc/6.4.0" >> submit.sh
echo 	"nvcc cell.cu -O3 -lm -arch sm_70  -o cell -lfftw3 -I/shared/centos7/fftw/3.3.8/include -L/shared/centos7/fftw/3.3.8/lib" >> submit.sh
echo 	"./cell  0  ${ci}  ${cj} ${J} ${H} ${alpha} ${beta} ${custar} ${cbstar}" >> submit.sh

sbatch submit.sh
