#!/bin/bash

for ((v=0;v<=20;v=v+1)) do 

	J=$(awk "BEGIN {printf 10 }")
	H=$(awk "BEGIN {printf 7 }")
	alpha=$(awk "BEGIN {printf 0.2 }")
	beta=$(awk "BEGIN {printf 0.004 }")
	custar=$(awk "BEGIN {printf 1.1 }")
	cbstar=$(awk "BEGIN {printf ${custar} }")
	ci=$(awk "BEGIN {printf 0.1 }")
	cj=$(awk "BEGIN {printf 800 }")
	Vm=$(awk "BEGIN {printf -40+$v*5 }")
	Vmc=$(awk "BEGIN {printf 5 }")
		
	if [ ! -d "Vm${Vm}" ]; then
		printf "Vm = ${Vm}\t"
		mkdir -p Vm${Vm}
		cd ./Vm${Vm}
		cp ../cell.cu .
		
		if [ -f "submit.sh" ]; then
			rm submit.sh
		fi

		if [ "${Vm}" -eq "${Vmc}" ]; then
			Vm=$(awk "BEGIN {printf 4.999 }")
		fi
		
		echo 	"#!/bin/bash" >> submit.sh
		echo 	"#SBATCH --job-name=${Vm}" >> submit.sh
		echo 	"#SBATCH --partition=gpu" >> submit.sh
		echo 	"#SBATCH --gres=gpu:v100-sxm2:1" >> submit.sh
		echo 	"#SBATCH --nodes=1" >> submit.sh
		echo 	"#SBATCH --output=out.txt" >> submit.sh
		echo 	"#SBATCH --error=error.txt" >> submit.sh
		echo 	"#SBATCH --time=0:3:00" >> submit.sh
		echo 	"cd $(pwd)" >> submit.sh
		echo 	"module load cuda/11.1" >> submit.sh
		echo 	"module load gcc/6.4.0" >> submit.sh
		echo 	"nvcc cell.cu -O3 -lm -arch sm_70  -o cell -lfftw3 -I/shared/centos7/fftw/3.3.8/include -L/shared/centos7/fftw/3.3.8/lib" >> submit.sh
		echo 	"stdbuf -oL ./cell  0  ${ci}  ${cj} ${J} ${H} ${alpha} ${beta} ${custar} ${cbstar} ${Vm} &> out.txt" >> submit.sh
		
		sbatch submit.sh

		cd ../
	fi
			
done
