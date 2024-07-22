#!/bin/bash

J=$(awk "BEGIN {printf 10 }")
H=$(awk "BEGIN {printf 7 }")
alpha=$(awk "BEGIN {printf 0.2 }")
beta=$(awk "BEGIN {printf 0.004 }")
custar=$(awk "BEGIN {printf 1.1 }")
cbstar=$(awk "BEGIN {printf ${custar} }")
ci=$(awk "BEGIN {printf 0.14 }")
cj=$(awk "BEGIN {printf 800 }")
vup=$(awk "BEGIN {printf 200 }")

((x=0))

for ((i=1;i<=40;i=i+1)) do
	for ((v=1;v<=2;v=v+1)) do
		cSR=$(awk "BEGIN {printf 0.0 }")

		if [ ! -d "cSR${cSR}_${i}" ]; then
			printf "cSR = $cSR\t${i}\t"
			mkdir -p cSR${cSR}_${i}
			cd cSR${cSR}_${i}
			cp ../cell.cu .

			if [ -f "cell" ]; then
				rm cell
			fi

			if [ -f "submit.sh" ]; then
				rm submit.sh
			fi
			echo 	"#!/bin/bash" >> submit.sh
			echo 	"#SBATCH --job-name=${cSR}i${i}" >> submit.sh
			echo 	"#SBATCH --partition=gpu" >> submit.sh
			echo 	"#SBATCH --gres=gpu:v100-sxm2:1" >> submit.sh
			echo 	"#SBATCH --nodes=1" >> submit.sh
			echo 	"#SBATCH --output=out.txt" >> submit.sh
			echo 	"#SBATCH --error=error.txt" >> submit.sh
			echo 	"#SBATCH --time=1:0:00" >> submit.sh
			echo 	"#SBATCH --exclude=d1008" >> submit.sh
			# if [[ (1 -eq "$(echo "${x} > 0" | bc)") ]]; then
			# 	echo 	"#SBATCH --dependency=afterok:${RES##* }" >> submit.sh
			# fi
			echo 	"cd $(pwd)" >> submit.sh
			echo 	"module load cuda/11.1" >> submit.sh
			echo 	"module load gcc/6.4.0" >> submit.sh
			echo 	"nvcc cell.cu -O3 -lm -arch sm_70  -o cell -lfftw3 -I/shared/centos7/fftw/3.3.8/include -L/shared/centos7/fftw/3.3.8/lib" >> submit.sh
			echo 	"stdbuf -oL ./cell  0  ${ci}  ${cj} ${J} ${H} ${alpha} ${beta} ${custar} ${cbstar} ${i} ${vup} ${cSR} &> out.txt" >> submit.sh

			# sbatch submit.sh
			RES=$( sbatch submit.sh )
			printf "i = ${i}, ${RES}\n"

			cd ../
		fi
	done
done