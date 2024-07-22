
reset
set term pdfcairo enhanced color size 7,2.5 font 'Helvetica,12' background rgb "#ffffff"
set output "uptake_high.pdf"

set multiplot

set border 3 lw 1
set tics out nomirror

originx=0.0
sizex=0.3333
shiftx=0.0

shift=0

originy=0.0
sizey=1

set size sizex,sizey

set xrange [138:500]
set xtics 100 offset 0,0.3
set mxtics 5
set xlabel "V_{up} (μM)" offset 0,0.6
path="uptake/result_Vup_all_high.txt"
###############################################################
set origin originx,originy

set yrange [-0.02:1]
set ytics 0.2 offset 0.6
set mytics 2
set ylabel "Frequency of DAD and DAD-TAP" offset 1.2
set label 1 "{/:Bold A}" at graph -0.27,1.02 font ",18"

# set label 2 'DAD' at 260,0.15
# set label 3 'DAD-TAP' at 360,0.25
# set label 4 'DAD and DAD-TAP' at 310,0.85

# set key at 530,1.02 spacing 1.5 samplen 4
unset key

plot 	path u 1:(($2+$15)/$28) w lp lw 2 pt 5 ps 0.7 lc rgb '#fd7f28' t "DAD + DAD-TAP"

# path u 1:($2/$28) w lp lw 2 pt 4 ps 0.7 lc 1 t "DAD",\
# 		path u 1:($15/$28) w lp lw 2 pt 6 ps 0.7 lc 2 t "DAD-TAP",\
# 		path u 1:($2/$28) w p pt 5 ps 0.4 lc rgb '#ffffff' t "",\
# 		path u 1:($15/$28) w p pt 7 ps 0.4 lc rgb '#ffffff' t "",\



###############################################################
set origin originx + sizex + shiftx, originy
set yrange [740:920]
set ytics 40
# set ytics add(' 800'800)
set mytics 2
set ylabel "Diastolic [Ca^{2+}]_{JSR} (μM)"
set label 1 "{/:Bold B}"
set key top left at 160,920 spacing 1.5

plot 	path u ($1+shift):($7-$8):($7+$8) w filledcurve fc rgb "#aaE0A080" t "",\
		path u ($1+shift):7 w l lw 2 lc 1 t "DAD",\
		path u ($1-shift):($20-$21):($20+$21) w filledcurve fc rgb "#aa629FA8" t "",\
		path u ($1-shift):20 w l lw 2 lc 2 t "DAD-TAP"

unset key
###############################################################
set origin originx + 2*( sizex + shiftx), originy
set yrange [0.13:0.2]
set ytics 0.02 offset 0.6
# set ytics add('0.14'0.14)
set mytics 2
set ylabel "Diastolic [Ca^{2+}]_i (μM)" offset 1.6
set label 1 "{/:Bold C}"

plot 	path u ($1+shift):($5-$6):($5+$6) w filledcurve fc rgb "#aaE0A080" t "",\
		path u ($1+shift):5 w l lw 2 lc 1 t "",\
		path u ($1-shift):($18-$19):($18+$19) w filledcurve fc rgb "#aa629FA8" t "",\
		path u ($1-shift):18 w l lw 2 lc 2 t ""


unset multiplot


