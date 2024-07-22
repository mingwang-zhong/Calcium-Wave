reset
set term pdfcairo enhanced color size 5.2,3.5 font 'Helvetica,10' background rgb "#ffffff"
set output "EAD_H10.pdf"
set multiplot 

set border 3
set tics out scale 0.7 nomirror

originx=0
sizex=0.34
shiftx=-0.01

originy=-0.02
sizey=0.498
shifty=0.03

set size sizex, sizey



path="DAD/data_EAD.txt"
######################################################## take-off voltage

set xrange [-40:-10]
set xtics 10 offset 0,0.3
set mxtics 2
set xlabel 'Take-off V_m (mV)' offset 0,0.6
#################################### cj
set origin originx+2*(sizex+shiftx), originy+sizey+shifty
set size sizex, sizey # +0.05

set border 3
set yrange [930:950]
set ytics 10 offset 0.4
set mytics 5
set ylabel 'Diastolic [Ca^{2+}]_{JSR} (μM)' offset 0.8
# set y2range [655:685]
# set y2tics 10 offset -0.9
# set y2tics add('660'660, '670'670, '680'680) offset -0.6 tc lt 2
# set my2tics 2
# set y2label 'Take-off [Ca^{2+}]_{JSR} (μM)' tc lt 2 offset -1.4


set label 1 "{/:Bold B}" at graph -0.35,1.0 font ",14"

plot 	path u 2:8 w p pt 4 ps 0.5 lw 1.5 lc rgb '#FF9999' t '',\
		0.46483*x+950.85 w l lw 2 lc 1 t ''

# ,\
# 		path u 2:5 w p pt 6 ps 0.5 lw 1.5 lc rgb 'grey50' t '' axes x1y2

set border 3
unset y2label
unset y2tics
set size sizex, sizey
#################################### Ca transient
set origin originx+0*(sizex+shiftx), originy
set ylabel '[Ca^{2+}]_i peak (μM)' offset 1.2
set yrange [4.55:4.85]
set ytics 0.1
set mytics 2
set label 1 "{/:Bold C}" at graph -0.3,1.0 font ",14"

plot 	path u 2:9 w p pt 4 ps 0.5 lw 1.5 lc rgb '#FF9999' t '',\
		0.0059051*x+4.8775 w l lw 2 lc 1 t ''

#################################### take-off cp
set origin originx+1*(sizex+shiftx), originy
set ylabel 'Take-off [Ca^{2+}]_p (μM)' offset 1.7
set yrange [1.6:1.8]
set ytics 0.1
set mytics 2
set label 1 "{/:Bold D}"

plot 	path u 2:4 w p pt 4 ps 0.5 lw 1.5 lc rgb '#FF9999' t '',\
		0.0052468*x+1.836 w l lw 2 lc 1 t ''

#################################### Integral of I_CaL and I_NCX
set origin originx+2*(sizex+shiftx), originy

set ylabel '(×10^{-15} μmol)'
set yrange [-20:-10]
set ytics 5
set ytics add(' -10'-10)
set mytics 5

set label 1 "{/:Bold E}"
set key right at -10,-16 spacing 2 samplen 1
set label 2 '{/Italic ∫}' at -21.9,-16.6 font ',15'
set label 3 '{/Italic ∫}' at -21.9,-18.1 font ',15'

plot 	path u 2:10 w p pt 4 ps 0.5 lw 1.5 lc 1 t '{/Helvetica-Italic I}_{Ca,L}dt',\
		path u 2:11 w p pt 6 ps 0.5 lw 1.5 lc 2 t '{/Helvetica-Italic I}_{NCX}dt'

# plot 	path u 2:8 w p pt 4 ps 0.5 lc 1 t 'I_{Ca,L}dt',\
# 		path u 2:9 w p pt 6 ps 0.5 lc 2 t 'I_{NCX}dt',\









unset label
######################################################## time traces
unset xtics
unset xlabel
xstart=20000-100
set xrange [xstart:(xstart+24000)]

set origin originx, originy+sizey+shifty+0.02
set size 2*sizex-0.01,0.2

set border 2
set ylabel '[Ca^{2+}]_{JSR} (μM)' offset 1.2,2
set yrange [300:1000]
set ytics 0,400,1200 out scale 0.7 nomirror offset 0.6
set mytics 4

plot "DAD/Hill10_alpha0.2_beta0.001_cstar1.2/wholecell.txt" every 4 u 1:5 w l lc 1 t ''



set origin originx, originy+sizey+shifty+0.18
set size 2*sizex-0.01,0.1

set ylabel ' _ ^ '
set yrange [930:952]
set ytics 930,20,950
set mytics 2

plot "DAD/Hill10_alpha0.2_beta0.001_cstar1.2/wholecell.txt" every 4 u 1:5 w l lc 1 t ''




set origin originx, originy+sizey+shifty+0.26
set size 2*sizex-0.01,0.22

set ylabel 'V_m (mV)' offset 1.2,0
set yrange [-90:50]
set ytics 40
set ytics add('    '0)
set mytics 2

set arrow 1 from xstart,-30 to xstart+23000,-30 nohead lw 0.5 dt 2
set label 1 "{/:Bold A}" at graph -0.13,1 font ",14"
# set label 2 '-30 mV' right at xstart+24000,-30
# set arrow 3 from xstart+100, -95 to xstart+2100, -95 nohead lw 2
# set label 3 '2 s' at xstart+570,-110

plot "DAD/Hill10_alpha0.2_beta0.001_cstar1.2/wholecell.txt" every 4 u 1:7 w l lc 1 t ''


unset multiplot