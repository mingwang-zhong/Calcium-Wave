
reset
set term pdfcairo enhanced color size 3.5,2.7 font 'Helvetica,12' background rgb "#ffffff"
set output "APD_DI_stable.pdf"

set border 3
set tics out nomirror

set xlabel 'DI (ms)'
set xrange [0:400]
set xtics 100
set mxtics 2

set ylabel 'APD (ms)'
set ytics 20
set mytics 2

path='APD_restitution/Hill7_cstar1.1_ISO_APD_restitution/APD_DI_stableRyR.txt'
set key right at graph 1,0.3 spacing 1.2
set yrange [130:190]

set label 1 'Maximum slope: 0.6' left at 50,140

plot  	path u 1:4 w lp pt 5 ps 0.6 t 'PCL = 0.5 s',\
		path u 2:5 w lp pt 7 ps 0.6 t 'PCL = 1 s',\
		path u 3:6 w lp pt 9 ps 0.6 lc 4 t 'PCL = 2 s'
