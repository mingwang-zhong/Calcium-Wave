#!/bin/bash

cjsr=(690 730 770 750 750 750 750 750 750 750 750 750 750 750 750 750 )
((x=0))
#####################################################################################

J=$(awk "BEGIN {printf 10 }")
H=$(awk "BEGIN {printf 7 }")
alpha=$(awk "BEGIN {printf 0.2 }")
beta=$(awk "BEGIN {printf 0.004 }")
custar=$(awk "BEGIN {printf 1.1 }")
cbstar=$(awk "BEGIN {printf ${custar} }")
	
for ((i=8;i<=12;i=i+19)) do # ci

	ci=$(awk "BEGIN {printf $i*0.025+0.1 }") # 0, 2, 3, 8
	cj=$(awk "BEGIN {printf ${cjsr[${i}]} }")
	# if [[ (1 -eq "$(echo "${H} < 4.5" | bc)") ]]; then
	# 	cj=$(awk "BEGIN {printf 400+50*${H} }")
	# fi

	if [ ! -d "ci${ci}" ]; then

		printf "Hill = ${H}\tci = ${ci}\t"
		mkdir -p ci${ci}
		cd ci${ci}
		cp ../cell.cu .
		
		if [ -f "submit.sh" ]; then
			rm submit.sh
		fi

		echo 	"#!/bin/bash" >> submit.sh
		echo 	"#SBATCH --job-name=ci${ci}_tausl" >> submit.sh
		echo 	"#SBATCH --partition=gpu" >> submit.sh
		echo 	"#SBATCH --gres=gpu:v100-sxm2:1" >> submit.sh
		echo 	"#SBATCH --nodes=1" >> submit.sh
		echo 	"#SBATCH --output=out.txt" >> submit.sh
		echo 	"#SBATCH --error=error.txt" >> submit.sh
		echo 	"#SBATCH --time=0:40:00" >> submit.sh
		echo 	"#SBATCH --exclude=d1008" >> submit.sh
		# if [[ (1 -eq "$(echo "${x} > 0" | bc)") ]]; then
		# 	echo 	"#SBATCH --dependency=afterok:${RES##* }" >> submit.sh
		# fi
		echo 	"cd $(pwd)" >> submit.sh
		echo 	"module load cuda/11.1" >> submit.sh
		echo 	"module load gcc/6.4.0" >> submit.sh
		echo 	"nvcc cell.cu -O3 -lm -arch sm_70  -o cell -lfftw3 -I/shared/centos7/fftw/3.3.8/include -L/shared/centos7/fftw/3.3.8/lib" >> submit.sh
		echo 	"./cell  0  ${ci}  ${cj} ${J} ${H} ${alpha} ${beta} ${custar} ${cbstar}" >> submit.sh
		
		sbatch submit.sh
		# RES=$( sbatch submit.sh )
		# printf "${RES}\n"
		# ((x=1))

		cd ../
	fi

done # ci
