#!/bin/bash

J=$(awk "BEGIN {printf 10 }")
# H=$(awk "BEGIN {printf 7 }")
alpha=$(awk "BEGIN {printf 0.2 }")
beta=$(awk "BEGIN {printf 0.001 }")
custar=$(awk "BEGIN {printf 1.2 }")
cbstar=$(awk "BEGIN {printf ${custar} }")
ci=$(awk "BEGIN {printf 0.14 }")
cj=$(awk "BEGIN {printf 600 }")


if [ ! -d "data" ]; then
	mkdir data
fi



cd data
for ((i=1;i<=5;i=i+1)) do
	for ((H=2;H<=12;H=H+1)) do

		if [ ! -d "H${H}_${i}" ]; then
			printf "H = $H\t${i}\t"
			mkdir -p H${H}_${i}
			cd H${H}_${i}
			cp ../../cell.cu .

			if [ -f "cell" ]; then
				rm cell
			fi

			if [ -f "submit.sh" ]; then
				rm submit.sh
			fi

			echo 	"#!/bin/bash" >> submit.sh
			echo 	"#SBATCH --job-name=H${H}_${i}" >> submit.sh
			echo 	"#SBATCH --partition=multigpu" >> submit.sh
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
			echo 	"stdbuf -oL ./cell  0  ${ci}  ${cj} ${J} ${H} ${alpha} ${beta} ${custar} ${cbstar} ${i} &> out.txt" >> submit.sh

			# sbatch submit.sh
			RES=$( sbatch submit.sh )
			printf "i = ${i}, ${RES}\n"

			cd ../
		fi
	done
done
cd ../