reset
set term pdfcairo enhanced color size 6.5,4.2 font 'Helvetica,11.5' background rgb "#ffffff"
set output "DAD_ATP.pdf"

set multiplot layout 2,3

set border 3 lw 1
set tics out nomirror
set xtics offset 0,0.4
set xlabel offset 0,0.8
set ytics offset 0.4
set ylabel offset 1

pathATP='NoATP/result_Vup_all_ATP.txt'
pathNoATP='NoATP/result_Vup_all_NoATP.txt'
set style histogram errorbars gap 1 linewidth 1
set style data histograms
set style fill solid 1  noborder
set boxwidth 0.4 relative

originx=0.02
sizex1=0.3
sizex2=0.3
sizex3=0.38
shiftx1=0.0
shiftx2=0.0

originy=0.02
sizey1=0.48
sizey2=0.48
shifty1=0.01


set xrange [-0.7:1.7]
set xtics 1
set xtics add('5'0, '0'1)
set xlabel "Total ATP (mM)"
############################################################### Number of events
# set origin originx, originy+sizey1+shifty1
# set size sizex1,sizey2

set yrange [0:600]
set ytics 200
set ytics add('    0'0)
set mytics 2
set ylabel 'Number of DAD and DAD-TAPs' offset 1,-1

set key right at 1.8,600 spacing 1.3
set label 1 "{/:Bold A}" at graph -0.37,1 font ',18'

plot 	pathATP u 0:($2+$15) w boxes ls 1 lc 1 lw 2 title "5 mM ATP",\
		pathNoATP u 0:($2+$15) w boxes ls 1 lc 2 lw 2 title "0 mM ATP"
		
set ylabel offset 1,0
############################################################### diastolic ci
# set origin originx+sizex1+shiftx1, originy+sizey1+shifty1
# set size sizex1,sizey1

set yrange [0.1:0.18]
set ytics 0.02
set mytics 1
set ylabel 'Diastolic [Ca^{2+}]_i (μM)'
set label 1 "{/:Bold B}"

plot 	pathATP u 0:5:6 w yerrorbars ls 1 pt 0 lc 1 lw 2 title "",\
		pathATP u 0:5 w boxes ls 1 lc 1 title "",\
		pathNoATP u 0:5:6 w yerrorbars ls 1 pt 0 lc 2 lw 2 title "",\
		pathNoATP u 0:5 w boxes ls 1 lc 2 lw 2 title ""
		

############################################################### diastolic cj
# set origin originx+2*(sizex1+shiftx1), originy+sizey1+shifty1
# set size sizex2,sizey2

set yrange [400:850]
set ytics 100
set ytics add('  700'700)
set mytics 2
set ylabel 'Diastolic [Ca^{2+}]_{JSR} (μM)'
set label 1 "{/:Bold C}"

plot 	pathATP u 0:7:8 w yerrorbars ls 1 pt 0 lc 1 lw 2 title "",\
		pathATP u 0:7 w boxes ls 1 lc 1 title "",\
		pathNoATP u 0:7:8 w yerrorbars ls 1 pt 0 lc 2 lw 2 title "",\
		pathNoATP u 0:7 w boxes ls 1 lc 2 lw 2 title "",\
		

############################################################### superadditivity
# set origin originx+sizex1+shiftx1, originy
# set size sizex2,sizey1

set xrange [-10:100]
set xtics 50
set mxtics 5
set xlabel 'Time (ms)'
set yrange [0.16:0.28]
set ytics 0.04
set mytics 2
set ylabel "[Ca^{2+}]_p (μM)"

set key at 100,0.2
set label 1 "{/:Bold D}"

plot 	"../permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/superadditivity/299_ci0.16/wholecell.txt" u ($1-10):38 w l lw 2 t "5 mM ATP",\
		"../permeabilized/Hill7_alpha0.2_beta0.004_cstar1.1/superadditivity/299_ci0.16_NoATP/wholecell.txt" u ($1-10):38 w l lw 2 t "0 mM ATP"

unset key
############################################################### cp trace
# set origin originx+sizex1+shiftx1+sizex2+shiftx2, originy+sizey1+shifty1
# set size sizex3,sizey2

set xrange [-0.1:1]
set xtics 0.5
set mxtics 5
set xlabel 'Time (s)'

set yrange [300:800]
set ytics 200
set ytics add('  400'400)
set mytics 2
set ylabel '[Ca^{2+}]_{JSR} (μM)'
set label 1 "{/:Bold E}"

plot 	'../Hill7_cstar1.1_ISO_2/wholecell.txt' u ($1/1000-0.1):5 w l lw 2 t '',\
		'../Hill7_cstar1.1_ISO_NoATP/wholecell.txt' u ($1/1000-0.1):5 w l lw 2 t ''

############################################################### cj trace
# set origin originx+sizex1+shiftx1+sizex2+shiftx2, originy
# set size sizex3,sizey1

set yrange [-2:90]
set ytics 20
set ytics add('    0'0)
set mytics 2
set ylabel '[Ca^{2+}]_p (μM)'

set label 1 "{/:Bold F}"
set object 2 rect back from -0.02,-1 to 0.07,100 fs empty border lc rgb '#000000' dt 2
set arrow 1 from 0.1,40 to 0.38,40 head filled size screen 0.015,12  #lc rgb '#737373'

plot 	'../Hill7_cstar1.1_ISO_2/wholecell.txt' u ($1/1000-0.1):3 w l lw 2 t '5 mM ATP',\
		'../Hill7_cstar1.1_ISO_NoATP/wholecell.txt' u ($1/1000-0.1):3 w l lw 2 t '0 mM ATP'


unset label 1
unset object
############################################################### cp trace
set origin 0.83,0.1
set size 0.15,0.3

set border 15 # lc rgb '#737373'
set xrange [80:170]
unset xtics
unset xlabel

set yrange [-2:90]
set ytics 20
set mytics 2
unset ylabel

plot 	'../Hill7_cstar1.1_ISO_2/wholecell.txt' u 1:3 w l lw 2 t '',\
		'../Hill7_cstar1.1_ISO_NoATP/wholecell.txt' u 1:3 w l lw 2 t ''

unset multiplot














