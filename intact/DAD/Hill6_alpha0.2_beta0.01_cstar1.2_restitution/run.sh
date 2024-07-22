#!/bin/bash

#####################################################################################
for ((h=6;h<=6;h=h+1)) do # Hill
	for ((a=3;a<=3;a=a+1)) do # alpha
		for ((b=1;b<=1;b=b+1)) do # beta
			for ((cs=2;cs<=2;cs=cs+1)) do # custar

				J=$(awk "BEGIN {printf 10 }")
				H=$(awk "BEGIN {printf $h }")
				alpha=$(awk "BEGIN {printf 0.2 }")
				beta=$(awk "BEGIN {printf 0.01 }")
				custar=$(awk "BEGIN {printf ${cs}*0.2+0.8 }")
				cbstar=$(awk "BEGIN {printf ${custar} }")
				ci=$(awk "BEGIN {printf 0.14 }")
				cj=$(awk "BEGIN {printf 600 }")
			
				if [ -f "submit.sh" ]; then
					rm submit.sh
				fi
				echo 	"#!/bin/bash" >> submit.sh
				echo 	"#SBATCH --job-name=9c${cs}H${H}" >> submit.sh
				echo 	"#SBATCH --partition=multigpu" >> submit.sh
				echo 	"#SBATCH --gres=gpu:v100-sxm2:1" >> submit.sh
				echo 	"#SBATCH --nodes=1" >> submit.sh
				echo 	"#SBATCH --output=out.txt" >> submit.sh
				echo 	"#SBATCH --error=error.txt" >> submit.sh
				echo 	"#SBATCH --time=0:30:00" >> submit.sh
				echo 	"cd $(pwd)" >> submit.sh
				echo 	"module load cuda/11.1" >> submit.sh
				echo 	"module load gcc/6.4.0" >> submit.sh
				echo 	"nvcc cell.cu -O3 -lm -arch sm_70  -o cell -lfftw3 -I/shared/centos7/fftw/3.3.8/include -L/shared/centos7/fftw/3.3.8/lib" >> submit.sh
				echo 	"stdbuf -oL ./cell  0  ${ci}  ${cj} ${J} ${H} ${alpha} ${beta} ${custar} ${cbstar} &> out.txt" >> submit.sh
				
				sbatch submit.sh

			done # custar
		done # beta
	done # alpha
done # hill