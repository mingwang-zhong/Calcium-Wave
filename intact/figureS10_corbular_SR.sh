reset
set term pdfcairo enhanced color size 5,5 font 'Helvetica,11.5' background rgb "#ffffff"
set output "cSR.pdf"

set multiplot layout 2,2

set border 3 lw 1
set tics out nomirror


set xrange [-0.005:0.05]
set xtics 0.1
set mxtics 10
set xtics add('0'0, '0.02'0.02, '0.05'0.05)
set xlabel "Corbular SR fraction"
set yrange [0:600]
set ytics 200
set ylabel "Number of events"
set key left at 0,610
set label 1 "{/:Bold A}" at graph -0.25,1.02 font ",18"

path="corbularSR/result_cSR_all.txt" 

plot 	path u 1:2 w lp lc rgb '#737373' pt 4 ps 0.5 lw 1.5 t "DAD",\
		path u 1:15 w lp lc rgb '#737373' pt 6 ps 0.5 lw 1.5 t "DAD-TAP",\
		path u 1:2 w p lc rgb 'white' pt 5 ps 0.25 lw 1.5 t "",\
		path u 1:15 w p lc rgb 'white' pt 7 ps 0.25 lw 1.5 t "",\
		path u 1:($2+$15) w lp pt 5 ps 0.5 lc 1 lw 1.5 t "DAD + DAD-TAP"

set xrange [-0.7:2.7]
set xtics 1
set mxtics 1
set xtics add('0'0, '0.02'1, '0.05'2)
set xlabel "Corbular SR fraction"
set yrange [40:90]
set ytics 100
set mytics 10
set ytics add('  50'50, '70'70, '90'90)
set ylabel 'Wave velocity (μm/s)'
set style histogram errorbars gap 1 linewidth 1
set style data histograms
set style fill solid 1  noborder
set boxwidth 0.5 relative

set label 1 "{/:Bold B}"

plot 	'corbularSR/result_wave_velocity.txt' u 0:($2-0.2):3 w yerrorbars ls 1 lc 1 lw 1.5 title "",\
		'corbularSR/result_wave_velocity.txt' u 0:2:xtic(1) w boxes ls 1 lc 1 title ""




#################################### 
unset xtics
unset mxtics
unset xlabel
unset ytics
unset mytics
unset ylabel

set origin 0.08,0.05
set size 0.42,0.45

set border 15
set xrange [0:100]
set yrange [0:100]

set style arrow 1 head filled size screen 0.007,15 lw 1 lc -1
set style arrow 2 nohead lw 0.8 lc -1 dt 2
set arrow 1 from -3,-3 to 10,-3 as 1
set arrow 2 from -3,-3 to -3,10 as 1
set label 1 "{/Times-Italic x}" at 15,-2 font ",12"
set label 2 "{/Times-Italic z}" at -5,16 font ",12"
set label 4 "{/Times-Italic i}{/Times -1}" left at 27,95
set label 5 "{/Times-Italic i}" left at 52,95
set label 6 "{/Times-Italic i}{/Times +1}" left at 77,95
set label 7 "CSR" center at 62.5, 55
set arrow 3 from 25,0 to 25,100 as 2
set arrow 4 from 50,0 to 50,100 as 2
set arrow 5 from 75,0 to 75,100 as 2

set label 11 "{/:Bold C}" at graph -0.25,1.02 font ",18"

pSize=0.5
plot 	1000 w l,\
		"<echo '25 10'" w p pt 7 ps pSize lc 9,\
		"<echo '25 20'" w p pt 7 ps pSize lc 9,\
		"<echo '25 30'" w p pt 7 ps pSize lc 9,\
		"<echo '25 40'" w p pt 7 ps pSize lc 9,\
		"<echo '25 50'" w p pt 7 ps pSize lc 9,\
		"<echo '25 60'" w p pt 7 ps pSize lc 9,\
		"<echo '25 70'" w p pt 7 ps pSize lc 9,\
		"<echo '25 80'" w p pt 7 ps pSize lc 9,\
		"<echo '25 90'" w p pt 7 ps pSize lc 9,\
		"<echo '50 10'" w p pt 7 ps pSize lc 9,\
		"<echo '50 20'" w p pt 7 ps pSize lc 9,\
		"<echo '50 30'" w p pt 7 ps pSize lc 9,\
		"<echo '50 40'" w p pt 7 ps pSize lc 9,\
		"<echo '50 50'" w p pt 7 ps pSize lc 9,\
		"<echo '50 60'" w p pt 7 ps pSize lc 9,\
		"<echo '50 70'" w p pt 7 ps pSize lc 9,\
		"<echo '50 80'" w p pt 7 ps pSize lc 9,\
		"<echo '50 90'" w p pt 7 ps pSize lc 9,\
		"<echo '75 50'" w p pt 5 ps pSize lc 1,\
		"<echo '62.5 50'" w p pt 2 ps pSize lc 9


unset arrow
unset label

set border 3
set xrange [-10:60]
set xtics 20 nomirror out
set mxtics 2
set xlabel 'Time (ms)'
set yrange [0.15:0.4]
set ytics 0.1 nomirror out
set mytics 2
set ylabel "[Ca^{2+}]_p (μM)"
set key right at 60,0.4

set label 1 "{/:Bold D}" at graph -0.25,1.02 font ",18"

plot "../permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/superadditivity/299_ci0.16/wholecell.txt" u ($1-10):38 w l lw 1.5 t "Without corbular SR",\
	"../permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/superadditivity/299_ci0.16_cSR/wholecell.txt" u ($1-10):38 w l lw 1.5 t "With corbular SR"

unset multiplot