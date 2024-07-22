reset

set term pdfcairo enhanced color size 7,3 font 'Helvetica,12' background rgb "#ffffff"
set output "beta.pdf"
set multiplot layout 1,2

set tics out nomirror
set border 3



#############################################
set border 3
set xrange [0:800]
set xtics 200 nomirror out
set mxtics 2
set xlabel "Time (ms)^ "
set yrange [0:1.2]
set ytics 0.5
set mytics 5
set ylabel "Ratio to the first spark"
set key at graph 1,0.5 right spacing 1.4
set label 11 "{/:Bold A}" at graph -0.2,1 font ",18"
set label 1 "{/Symbol-Italic b}" left at 600,0.65
# set label 2 "1-exp[-(t-T_1)/T_2]" center at 400,0.15
path001="DAD/Hill6_alpha0.2_beta0.001_cstar1.2_restitution/ratio_vs_t_avg.txt"
path002="DAD/Hill6_alpha0.2_beta0.002_cstar1.2_restitution/ratio_vs_t_avg.txt"
path004="DAD/Hill6_alpha0.2_beta0.004_cstar1.2_restitution/ratio_vs_t_avg.txt"
path01="DAD/Hill6_alpha0.2_beta0.01_cstar1.2_restitution/ratio_vs_t_avg.txt"


plot 	path001 u 1:( ($0>1&&$1<800)?($2/0.98):1/0 ) w lp pt 5 ps 0.5 lw 1 lc 1 t "0.001 ms^{-1}",\
		path002 u 1:( ($0>1&&$1<800)?($2/0.96):1/0 ) w lp pt 7 ps 0.5 lw 1 lc 2 t "0.002 ms^{-1}",\
		path004 u 1:( ($0>1&&$1<800)?($2/0.92):1/0 ) w lp pt 9 ps 0.5 lw 1 lc 4 t "0.004 ms^{-1}",\
		path01 u 1:( ($0>1&&$1<800)?($2/0.7):1/0 ) w lp pt 11 ps 0.5 lw 1 lc 5 t "0.01 ms^{-1}"



#############################################

set xrange [0.00:0.01]
set xtics 0.002
set mxtics 2
set xlabel "{/Symbol-Italic b} (ms^{-1})"
# set logscale x
set yrange [50:225]
set ytics 50
set mytics 2
set ylabel "Refractory period (ms)"
set label 11 "{/:Bold B}" at graph -0.25,1 font ",18"
set key top right at 0.01,225

plot 	"DAD/Hill6_alpha0.2_beta0.01_cstar1.2_restitution/refractory.txt" i 1 u 1:2 w lp pt 5 ps 0.5 t 'T_1',\
		"DAD/Hill6_alpha0.2_beta0.01_cstar1.2_restitution/refractory.txt" i 0 u 1:2 w lp pt 7 ps 0.5 dt (10,4) t 'T_1 + T_2'


unset multiplot
