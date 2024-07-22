#!/bin/bash


stoptime=(0 100001 100001 50001  25001 10001 3001  2001  60     60    50    50   40   30   20   20)
minute=(0   150    150    75     40    20    8     8     8      8      8     5    5    5    5    5)
Cai=(   0   0.1    0.2    0.4    0.6   0.8   1.0   1.2   1.4    1.6    1.8   2    2.2  2.4  2.6  2.8)
Cai2=(  0   0.096  0.169  0.275  0.354 0.415 0.466 0.506 0.543  0.576  0.604 0.7  0.8  0.9   1   1.1)
#       0    1     2      3      4     5       6    7     8      9     10    11    12   13  14   15


J=$(awk "BEGIN {printf 10 }")
H=$(awk "BEGIN {printf 7 }")
alpha=$(awk "BEGIN {printf 0.2 }")
beta=$(awk "BEGIN {printf 0.004 }")
custar=$(awk "BEGIN {printf 1.1 }")
cbstar=$(awk "BEGIN {printf ${custar} }")



## output the result every 1 ms
for ((i=1;i<=7;i=i+1)) do # ci

	ci=$(awk "BEGIN {printf ${Cai[$i]} }")
	cj=$(awk "BEGIN {printf 800 }")

	if [ ! -d "ci${ci}_cj${cj}" ]; then

		printf "ci = ${ci}\tcj = ${cj}\t"
		mkdir -p ci${ci}_cj${cj}
		cd ci${ci}_cj${cj}
		cp ../cell.cu .
		
		if [ -f "submit.sh" ]; then
			rm submit.sh
		fi

		echo 	"#!/bin/bash" >> submit.sh
		echo 	"#SBATCH --job-name=ci${ci}" >> submit.sh
		echo 	"#SBATCH --partition=gpu" >> submit.sh
		echo 	"#SBATCH --gres=gpu:v100-sxm2:1" >> submit.sh
		echo 	"#SBATCH --nodes=1" >> submit.sh
		echo 	"#SBATCH --output=out.txt" >> submit.sh
		echo 	"#SBATCH --error=error.txt" >> submit.sh
		echo 	"#SBATCH --time=0:${minute[$i]}:00" >> submit.sh
		echo 	"#SBATCH --exclude=d1008" >> submit.sh
		# if [[ (1 -eq "$(echo "${x} > 0" | bc)") ]]; then
		# 	echo 	"#SBATCH --dependency=afterok:${RES##* }" >> submit.sh
		# fi
		echo 	"cd $(pwd)" >> submit.sh
		echo 	"module load cuda/11.1" >> submit.sh
		echo 	"module load gcc/6.4.0" >> submit.sh
		echo 	"nvcc cell.cu -O3 -lm -arch sm_70  -o cell -lfftw3 -I/shared/centos7/fftw/3.3.8/include -L/shared/centos7/fftw/3.3.8/lib" >> submit.sh
		echo 	"./cell  0  ${ci}  ${cj} ${J} ${H} ${alpha} ${beta} ${custar} ${cbstar} ${stoptime[$i]} ${Cai2[$i]} " >> submit.sh
		
		sbatch submit.sh

		cd ../
	fi

done # ci


## output the result every 1 step
for ((i=8;i<=10;i=i+1)) do # ci

	ci=$(awk "BEGIN {printf ${Cai[$i]} }")
	cj=$(awk "BEGIN {printf 800 }")

	if [ ! -d "ci${ci}_cj${cj}" ]; then

		printf "ci = ${ci}\tcj = ${cj}\t"
		mkdir -p ci${ci}_cj${cj}
		cd ci${ci}_cj${cj}
		cp ../cell_fine_output.cu .
		
		if [ -f "submit.sh" ]; then
			rm submit.sh
		fi

		echo 	"#!/bin/bash" >> submit.sh
		echo 	"#SBATCH --job-name=ci${ci}" >> submit.sh
		echo 	"#SBATCH --partition=gpu" >> submit.sh
		echo 	"#SBATCH --gres=gpu:v100-sxm2:1" >> submit.sh
		echo 	"#SBATCH --nodes=1" >> submit.sh
		echo 	"#SBATCH --output=out.txt" >> submit.sh
		echo 	"#SBATCH --error=error.txt" >> submit.sh
		echo 	"#SBATCH --time=0:${minute[$i]}:00" >> submit.sh
		echo 	"#SBATCH --exclude=d1008" >> submit.sh
		# if [[ (1 -eq "$(echo "${x} > 0" | bc)") ]]; then
		# 	echo 	"#SBATCH --dependency=afterok:${RES##* }" >> submit.sh
		# fi
		echo 	"cd $(pwd)" >> submit.sh
		echo 	"module load cuda/11.1" >> submit.sh
		echo 	"module load gcc/6.4.0" >> submit.sh
		echo 	"nvcc cell_fine_output.cu -O3 -lm -arch sm_70  -o cell -lfftw3 -I/shared/centos7/fftw/3.3.8/include -L/shared/centos7/fftw/3.3.8/lib" >> submit.sh
		echo 	"./cell  0  ${ci}  ${cj} ${J} ${H} ${alpha} ${beta} ${custar} ${cbstar} ${stoptime[$i]} ${Cai2[$i]} " >> submit.sh
		
		sbatch submit.sh

		cd ../
	fi

done # ci



