

reset

set term pdfcairo enhanced color size 8.1,2.25 font 'Helvetica,12' background rgb "#ffffff"

set output "ATP_effect.pdf"
set multiplot layout 1,3

set border 3
set tics nomirror out
set mxtics 2
set mytics 2
set xlabel "Time (ms)" offset 0,1.2
set key spacing 1.3

path1="Hill7_alpha0.2_beta0.004_cstar1.1/spark_ci0.1.txt"
pathNoATP="Hill7_alpha0.2_beta0.004_cstar1.1_NoATP/spark_ci0.1.txt"

############################################### Irel
set xrange [-3:40]
set xtics 20 offset 0,0.6
set yrange [-0.1:1.6]
set ytics 0.4 offset 0.6
set ytics add('   0'0)
set ylabel "{/Helvetica-Italic I}_{rel} (pA/pF)" offset 1.2
set label 1 "{/:Bold A}" at graph -0.25,1 font ",18"

plot 	path1 u ( ($1>7)?($1-10):1/0 ):2 w l lc 1 lw 1.5 t "0.1 μM, 5 mM ATP",\
		pathNoATP u ( ($1>7)?($1-10):1/0 ):2 w l lc 2 lw 1.5 t "0.1 μM, 0 mM ATP"

############################################### ci
set xrange [-3:40]
set xtics 20 offset 0,0.6
set yrange [0:2.4]
set ytics 0.4 offset 0.6
set ytics add('   0'0)
set ylabel "[Ca^{2+}]_i (μM)" offset 1.2
set label 1 "{/:Bold B}" at graph -0.25,1 font ",18"

plot 	path1 u ( ($1>7)?($1-10):1/0 ):10 w l lc 1 lw 1.5 t "",\
		pathNoATP u ( ($1>7)?($1-10):1/0 ):10 w l lc 2 lw 1.5 t ""

############################################### CaDye, CaATP
set xrange [-3:40]
set xtics 20 
set yrange [-0:12]
set ytics 4
set mytics 2
set ytics add('   0'0)
set ylabel "(μM)"
set label 1 "{/:Bold C}"
set key at 40,12.5

plot 	path1 u ( ($1>7)?($1-10):1/0 ):15 w l lc 1 lw 1.5 t "5 mM ATP, [CaDye]_i",\
		pathNoATP u ( ($1>7)?($1-10):1/0 ):15 w l lc 2 lw 1.5 t "0 mM ATP, [CaDye]_i",\
		path1 u ( ($1>7)?($1-10):1/0 ):16 w l lc 4 lw 1.5 t "[CaATP]_i"
		

unset multiplot
set term qt


reset
