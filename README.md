# Role of RyR cooperativity in Ca<sup>2+</sup>-wave-mediated triggered activity in cardiomyocytes

This mathematical model was developed to produce the propagating Ca<sup>2+</sup> waves in ventricular myocytes by incorporating ryanodine receptor (RyR) cooperativity, which can be phenomenologically represented by a large Hill coefficient in the RyR gating function. In contrast to existing models, this one does not use an extraordinarily large release current ($I_\text{rel}$) from sarcoplasmic reticulum (SR) and an unrealistic architecture of the cell that diffusively couples the Ca<sup>2+</sup> release units (CRUs) in the longitudinal direciton. 

Moreover, this model successfully replicates other experimentally observed manifestations of Ca2+-wave-mediated triggered activity, including phase 2 and phase 3 early afterdepolarizations, and high-frequency voltage-Ca2+ oscillations. The model also sheds light on the roles of luminal gating of RyRs and the mobile buffer ATP in the genesis of these arrhythmogenic phenomena.

This repository is able to reproduce all results represented in our paper:

- Mingwang Zhong and Alain Karma, "Role of RyR cooperativity in Ca<sup>2+</sup>-wave-mediated triggered activity in cardiomyocytes", _The Journal of Physiology_

This code is based on an earlier implementation of a similar detailed model described in:

- Zhong, Mingwang, Colin M. Rees, Dmitry Terentyev, Bum-Rak Choi, Gideon Koren, and Alain Karma. "NCX-mediated subcellular Ca2+ dynamics underlying early afterdepolarizations in LQT2 cardiomyocytes." *Biophysical journal* 115, no. 6 (2018): 1019-1032.
- Restrepo, J. G., Weiss, J. N., & Karma, A. (2008). Calsequestrin-mediated mechanism for cellular calcium transient alternans. *Biophysical journal*, 95(8), 3767-3789.

This software is free software, distributed under the 2-clause BSD license. A copy of the license is included in the LICENSE file. We cordially ask that any published work derived from this code, or utilizing it references the above-mentioned published works.

If you have any questions, please contact mingwang(dot)zhong(at)gmail(dot)com, or m(dot)zhong(at)northeastern(dot)edu

# Reproducing all figures

Before running simulaitons, the path in `submit.sh` needs to be changed to the current directory. If `run.sh` is provided for some simulations, just go to the directory, and run `./run.sh`. 

We also generated two videos, corresponding to the following two directories

```bash
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/ci0.3/
intact/Hill7_cstar1.1_ISO/
```

The visualization application [ParaView](http://paraview.org) can open the `.vtk` files and produce videos.



## Figure 3

Run the following bash script

```bash
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1_fixNSR_taujn/run.sh
```

These simulations output data files containing the time to the first spark, as well as $c_p$ and $c_j$ before the initiation of sparks. Then use the following python code to analyze the data

```bash
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1_fixNSR_taujn/plot.py
```

Finally, plot the figure using [gnuplot](http://www.gnuplot.info) on Terminal

```bash
cd permeabilized
gnuplot figure3_RyR.sh
```



## Figure 4

Execute the following scripts to run CUDA codes

```bash
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/ci0.1/submit.sh
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/ci0.125/submit.sh
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/ci0.15/submit.sh

permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1_NoATP/run.sh

# panel G, high-resolution model
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/ci0.1_fine_taupi0.025_tausi0.01_Vratio_0.8/submit.sh
```

Run the following Matlab codes

```bash
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/SparkAnalysis_ci01_dyeATP.m
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/SparkAnalysis_ci0125.m
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/SparkAnalysis_ci015.m

permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1_NoATP/SparkAnalysis_ci01_dyeATP.m
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1_NoATP/SparkAnalysis_ci0125.m
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1_NoATP/SparkAnalysis_ci015.m

# panel F
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/spark_ci01_avg.m
```

Plot the figure on Terminal

```bash
cd permeabilized
gnuplot figure4_sparks.sh
```



## Figure 5

Execute the following scripts to run CUDA codes. Here we only give the representative codes. For other simulations, simply modify the parameters in the CUDA codes and run again.

```bash
# the reference simulation
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/ci0.1_fine_taupi0.025_tausi0.01_Vratio_0.8/submit.sh

# v_i effect
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/ci0.1_fine_taupi0.025_tausi0.01_Vratio_1/submit.sh
# D_Ca effect
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/ci0.1_fine_taupi0.025_tausi0.01_Vratio_0.8_DCa0.6/submit.sh
# D_dye effect
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/ci0.1_fine_taupi0.025_tausi0.01_Vratio_0.8_Ddye0.02/submit.sh
# lambda_x effect
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/ci0.1_fine_taupi0.025_tausi0.01_Vratio_0.8_lamx1/submit.sh
# v_i = 1, D_dye = 0.02 μm^2/ms, D_Ca = 0.6 μm^2/ms
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/ci0.1_fine_taupi0.025_tausi0.01_Vratio_1_Ddye0.02_DCa0.6/submit.sh
```

Use the following Matlab code to calculate F/F<sub>0</sub>, FWHM, and FDHM for each simulation

```bash
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/ci0.1_fine_taupi0.025_tausi0.01_Vratio_0.8/analysis.m
```

Plot the figure on Terminal

```bash
cd permeabilized
gnuplot figure5_parameter_sensitivity.sh
```





## Figure 6

For the diagram of c<sub>i</sub> vs H in panel A, execute the following script to run all simulations

```bash
# the code is permeabilized/cell.cu
cd permeabilized
./run.sh
```

Data are summarized in ```permeabilized/data.txt```

For panel D, run the following matlab code to analyze the fluorescence data
```bash
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/fluoxt.m
```

For panel G, run the following scripts. These simulations output all lines-can data in the longitudinal direction.

```bash
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/ci0.1_2/submit.sh
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/ci0.15_2/submit.sh
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/ci0.2_2/submit.sh
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/ci0.3_2/submit.sh
```

Then run the matlab codes to output the 3D plots of local [Ca]i

```bash
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/ci0.1_2/analysis.m
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/ci0.15_2/analysis.m
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/ci0.2_2/analysis.m
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/ci0.3_2/analysis.m
```

Plot the figure

```bash
cd permeabilized
gnuplot figure6_wave_part1.sh
gnuplot figure6_wave_part2.sh
```



## Figure 7

For panel A, run the following script. Notice that the code ```cell.cu``` has been modified to output the necessary data. This simulation also produce data that generate the video.

```bash
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/ci0.3/submit.sh
```

For panel C, run the scripts

```bash
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/superadditivity/299/run.sh
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/superadditivity/299_add1/run.sh
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/superadditivity/299_add1_add1z/run.sh
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/superadditivity/299_add5/run.sh
```

Plot the figure

```bash
cd permeabilized/
gnuplot figure7_superadditivity.sh
```



## Figure 8

Run the matlab codes to analyze data

```bash
permeabilized/Hill2_alpha0.2_beta0.004_cstar1.1/SparkAnalysis_ci0175_before_spark.m
permeabilized/Hill2_alpha0.2_beta0.004_cstar1.1/SparkAnalysis_ci03_before_spark.m

permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/SparkAnalysis_ci0175_before_spark.m
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/SparkAnalysis_ci03_before_spark.m
```

The codes for H = 2 are slightly different from H = 7 because sparks can last for a long time at H = 2. For H = 2, just use the matlab codes for H = 7.

These codes output the number of sparks and non-spark events. These data are summarized in ```permeabilized/sparks_nonspark.txt```

Plot the figure

```bash
cd permeabilized
gnuplot figure8_Hill.sh
```





## Figure 9

Run the following script

```bash
cd closedCell
./run.sh
```

Then run the python code to analyze the results

```bash
cd closedCell
python3 analysis.py
```

Finally plot the figure

```bash
cd closedCell
gnuplot figure9_closed_cell.sh
```



## Figure 10

Run the following scripts

```bash
intact/Hill2_cstar1.1/run.sh
intact/Hill2_cstar1.1_ISO/run.sh
intact/Hill2_cstar3.5/run.sh
intact/Hill7_cstar1.1/run.sh
intact/Hill7_cstar1.1_ISO/run.sh
intact/Hill7_cstar3.5/run.sh
intact/Hill12_cstar1.1/run.sh
intact/Hill12_cstar1.1_ISO/run.sh
intact/Hill12_cstar3.5/run.sh
```

Then plot the figure

```bash
cd intact
gnuplot figure10_DAD.sh
```



## Figure 11

Run the following scripts

```bash
intact/Hill7_cstar1.1_ISO_tauu350ms/run.sh
intact/Hill7_cstar1.1_ISO_tauu4350ms/run.sh

intact/Hill7_cstar1.1_ISO_restitution/run.sh
intact/Hill7_cstar1.1_ISO_tauu350ms_restitution/run.sh
intact/Hill7_cstar1.1_ISO_tauu4350ms_restitution/run.sh
```

Then run the matlab codes to obatain the spark restitution

```bash
intact/Hill7_cstar1.1_ISO_restitution/analysis.m
intact/Hill7_cstar1.1_ISO_tauu350ms_restitution/analysis.m
intact/Hill7_cstar1.1_ISO_tauu4350ms_restitution/analysis.m
```

Finally plot the figure

```bash
cd intact
gnuplot figure11_tauu.sh
```



## Figure 12

Run the following script

```bash 
intact/uptake/run.sh
```

There is a `gnuplot` script to plot the time traces of membrane potential for all simulations

```bash
cd intact/uptake/
gnuplot plot.sh
```

Then analyze the data using the matlab code

```bash
intact/uptake/analysis.m
```

Finally, plot the figure

```bash
cd intact/
gnuplot figureS9_uptake.sh
```



## Figure 13

Run the following scripts

```bash
# panels A-C
intact/NoATP/run.sh
intact/NoATP/analysis.m

# panel D
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/superadditivity/299_ci0.16/run.sh
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/superadditivity/299_ci0.16_NoATP/run.sh

# panels E-F
intact/Hill7_cstar1.1_ISO_2/run.sh
intact/Hill7_cstar1.1_ISO_NoATP/run.sh
```

Plot the figure

```bash
cd intact
gnuplot figure13_ATP.sh
```



## Figure 14

run the following script

```bash
intact/DAD/run.sh
```

Then for the simulations of interest, turn on the following command in, for instance, ```Hill9_alpha0.2_beta0.004_cstar2/cell.cu```, and run again. 
```c++
#define output_fluoxt
```

The summarized morphology data are within ```intact/DAD/data_beta0.004.txt```

Plot the figure

```bash
cd intact
gnuplot figure14_cstar_H.sh
```



## Figure 15

For the following script, change `beta` to 0.001, and run again

```bash
intact/DAD/run.sh
```

Similar to the previous figure, turn on the following command in corresponding CUDA codes

```c
#define output_fluoxt
```

The summarized morphology data are within ```intact/DAD/data_beta0.001.txt```

Additionally, for panel D at 2 Hz, run the following script

```bash
intact/DAD_2Hz/Hill5_alpha0.2_beta0.001_cstar1.6/submit.sh
```

Plot the figure

```bash
cd intact
gnuplot figure15_cstar_H_beta0.001.sh
```



## Figure 16

Run the following simulations

```bash
intact/DAD/Hill10_alpha0.2_beta0.001_cstar1_clamp_Vm/submit.sh
intact/DAD/Hill10_alpha0.2_beta0.001_cstar1_clamp_cp/submit.sh
```

Turn on ```#define output_linescan ``` in the following code and run again.

```bash
intact/DAD/Hill10_alpha0.2_beta0.001_cstar1/submit.sh
```

Plot the figure

```bash
cd intact
gnuplot figure16_phase3_EAD.sh
```



## Figure 17

Turn on ```#define output_fluoxt ``` in the following code and run again.

```bash
intact/DAD/Hill4_alpha0.2_beta0.001_cstar1.4/submit.sh
intact/DAD/Hill5_alpha0.2_beta0.001_cstar1.4/submit.sh
intact/DAD/Hill6_alpha0.2_beta0.001_cstar1.4/submit.sh
```

Run the matlab code 

```bash
intact/DAD/analysis.m
```

The data for panels E - G are summarized in 

```bash
intact/DAD/citakeoff_cstar1.4.txt
intact/DAD/cjtakeoff_cstar1.4.txt
intact/DAD/frequency_cstar1.4.txt
intact/DAD/latency_cstar1.4.txt
```

Plot the figure

```bash
cd intact/
gnuplot figure17_DAD_morphology.sh
```



## Figure 18

run the following scripts

```bash
intact/Hill_effect_EAD/run.sh

intact/Hill_effect_EAD/analysis.m
```

The results for panels A-B are summarized in ```intact/Hill_effect_EAD/result_H_all.txt```

Plot the figure

```bash
cd intact
gnuplot figure18_EAD.sh
```



## Figure 19

Run the matlab code to produce data for panels B-E

```bash
intact/DAD/analysis_EAD.m
```

Plot the figure

```bash
cd intact
gnuplot figure19_EAD_SRload.sh
```











## Figure S1

Plot the figure

```bash
cd permeabilized
gnuplot figureS1_sparks.sh
```

## Figure S2

Plot the figure

```bash
cd permeabilized
gnuplot figureS2_noATP.sh
```



## Figure S3

Run the simulations

```bash
permeabilized/Hill4_alpha0.2_beta0.004_cstar1.1_NryrRandom/run.sh
permeabilized/Hill4_alpha0.2_beta0.004_cstar1.1_tausl/run.sh
permeabilized/Hill4_alpha0.2_beta0.004_cstar1.1_tausl_partial/run.sh
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1_NryrRandom/run.sh
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1_tausl/run.sh
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1_tausl_partial/run.sh
```

Plot the figure

```bash
cd permeabilized
gnuplot figureS3_complex.sh
```

Notice that for some simulations, the simulation time should be significantly increased, i.e., the value of macro definition `#define stoptime (15001.0)` should be increased. The specific value of total time could be found in `figureS3_complex.sh`.



## Figure S4

Plot the figure

```bash
cd permeabilized
gnuplot figureS4_Hill.sh
```



## Figure S5

Plot the figure

```bash
cd permeabilized
gnuplot figureS5_conservation.sh
```



## Figure S6

Run the simulations

```bash
intact/gain_control_0mV/run.sh
intact/localControl_Hill7_cstar1.1_ISO/run.sh
intact/localControl_Hill7_cstar3.5/run.sh
```

Plot the figure

```bash
cd permeabilized
gnuplot figureS6_local_control.sh
```



## Figure S7

Run the simulations

```bash
intact/APD_restitution/Hill7_cstar1.1_ISO_APD_restitution/run.sh
intact/APD_restitution/Hill7_cstar1.1_ISO_APD_restitution_0.5s/run.sh
intact/APD_restitution/Hill7_cstar1.1_ISO_APD_restitution_1s/run.sh
intact/APD_restitution/Hill12_cstar3.5_APD_restitution/run.sh
intact/APD_restitution/Hill12_cstar3.5_APD_restitution_0.5s/run.sh
intact/APD_restitution/Hill12_cstar3.5_APD_restitution_1s/run.sh
```

Run the python code to analyze the results

```bash
intact/APD_restitution/Hill7_cstar1.1_ISO_APD_restitution/analysis.py
```

Plot the figure

```bash
cd intact
gnuplot figureS7_APD_restitution.sh
```





## Figure S8

Plot the figure

```bash
cd intact
gnuplot figureS8_tauu.sh
```



## Figure S9

Slightly modify the bash script `intact/uptake/run.sh` so that $V_{up}$ can reach up to 500 μM, then run this script.

Then uncomment `% Vup_array = [120:20:240 400 500];` in `intact/uptake/analysis.m` , and run this code.

Plot the figure

```bash
cd intact
gnuplot figureS9_uptake.sh
```



## Figure S10

Run the codes

```bash
# panel A
intact/corbularSR/run.sh
intact/corbularSR/analysis.m

# panel D
permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/superadditivity/299_ci0.16_cSR/run.sh
```

For the corbular SR fraction at 0.05, revise the codes so that `intact/uptake/Vup200_1` to `intact/uptake/Vup200_15` produce `fluoxt.txt`.

Measurements of the wave velocity is 

Plot the figure

```bash
cd intact/
gnuplot figureS10_corbular_SR.sh
```

<span style="color:red"> Wave measurement </span>

## Figure S11

Run the simulations

```bash
intact/DAD/Hill6_alpha0.2_beta0.01_cstar1.2_restitution/run.sh
intact/DAD/Hill6_alpha0.2_beta0.001_cstar1.2_restitution/run.sh
intact/DAD/Hill6_alpha0.2_beta0.002_cstar1.2_restitution/run.sh
intact/DAD/Hill6_alpha0.2_beta0.004_cstar1.2_restitution/run.sh

intact/DAD/Hill6_alpha0.2_beta0.01_cstar1.2_restitution/analysis.m
intact/DAD/Hill6_alpha0.2_beta0.001_cstar1.2_restitution/analysis.m
intact/DAD/Hill6_alpha0.2_beta0.002_cstar1.2_restitution/analysis.m
intact/DAD/Hill6_alpha0.2_beta0.004_cstar1.2_restitution/analysis.m
```

Then store the refractory period and absolute refractory period in `intact/DAD/Hill6_alpha0.2_beta0.01_cstar1.2_restitution/refractory.txt`

Plot the figure

```bash
cd intact
gnuplot figureS11_beta.sh
```



## Figure S12

run the simulation

```bash
intact/DAD/Hill12_alpha0.2_beta0.004_cstar0.8_clamp_cp_fast/submit.sh
```

Revise the codes in the following directories, and run the codes again to output `linescan.txt` 

```bash
intact/DAD/Hill12_alpha0.2_beta0.004_cstar0.2/
intact/DAD/Hill12_alpha0.2_beta0.004_cstar0.8/
```

Plot the figure

```bash
cd intact
gnuplot figureS12_phase2_EAD.sh
```





## Figure S13

run the simulation

```bash
intact/DAD/Hill6_alpha0.2_beta0.004_cstar0.8_clamp_cp_fast/submit.sh
```

Revise the codes in the following directories, and run the codes again to output `linescan.txt` 

```bash
intact/DAD/Hill6_alpha0.2_beta0.004_cstar0.2/
intact/DAD/Hill6_alpha0.2_beta0.004_cstar0.8/
```

Plot the figure

```bash
cd intact
gnuplot figureS13_phase3_EAD.sh
```



## Figure S14

run the simulaitons

```bash
intact/DAD/Hill12_alpha0.2_beta0.001_cstar1_clamp_cp/submit.sh
intact/DAD/Hill12_alpha0.2_beta0.001_cstar1_clamp_Vm/submit.sh
```

Revise the codes in the following directories, and run the codes again to output `linescan.txt` 

```bash
intact/DAD/Hill12_alpha0.2_beta0.001_cstar1
```

Plot the figure

```bash
cd intact
gnuplot figureS14_phase2_EAD_Ca.sh
```





## Figure S15

Revise the codes in the following directories, and run the codes again to output `linescan.txt` 

```bash
intact/DAD/Hill10_alpha0.2_beta0.001_cstar1
```

Plot the figure

```bash
cd intact
gnuplot figureS15_phase3_EAD_Ca.sh
```



## Figure S16

Plot the figure

```bash
cd intact
gnuplot figureS16_random_ci_cj.sh
```



