





reset
set term pdfcairo enhanced color size 7,7 font 'Helvetica,12' background rgb "#ffffff"
set output "uptake.pdf"

set multiplot

set border 3 lw 1
set tics out nomirror
originx=0.0
sizex1=0.3333
sizexN=0.37 # number of DAD and TA
sizex2=0.65 # time traces
originy=0.0
sizey1=0.3
sizey2=0.12 # time traces: Vm
sizey3=0.1 # time traces: ci
sizey4=0.2 # time traces: cj
sizey5=0.1467 # max ci for TA
sizey6=0.1767 # max ci for DAD

shiftx1=0.0
shiftxN=-0.02 # number of DAD and TA
shifty1=-0.01
shifty2=-0.02 # time traces
shifty3=-0.02 # max ci

jumpy=0.02 # for time traces

shift=0

set xrange [138:240]
set xtics 40 offset 0,0.3
set mxtics 2
set xlabel "V_{up} (μM)" offset 0,0.6
path="uptake/result_Vup_all.txt"
###############################################################
set origin originx+sizex2+shiftxN, originy+2*(sizey1+shifty1)+jumpy
set size sizexN, 0.38

set yrange [-0.02:1]
set ytics 0.2 offset 0.6
set mytics 2
set ylabel "Frequency" offset 1.2
set label 1 "{/:Bold B}" at graph -0.15,1.07 font ",18"
# set key left at 145,1.1 spacing 1.5 samplen 4
set label 2 'DAD' at 205,0.25
set label 3 'DAD-TAP' at 195,0.65
set label 4 'DAD and DAD-TAP' at 175,0.95
unset key

plot 	path u 1:($2/$28) w lp lw 2 pt 4 ps 0.7 lc 1 t "DAD",\
		path u 1:($15/$28) w lp lw 2 pt 6 ps 0.7 lc 2 t "DAD-TAP",\
		path u 1:($2/$28) w p pt 5 ps 0.4 lc rgb '#ffffff' t "",\
		path u 1:($15/$28) w p pt 7 ps 0.4 lc rgb '#ffffff' t "",\
		path u 1:(($2+$15)/$28) w lp lw 2 pt 5 ps 0.7 lc rgb '#fd7f28' t "DAD + DAD-TAP"

unset key
unset label 2
unset label 3
unset label 4

set size sizex1, sizey1

###############################################################
set origin originx, originy+sizey1+shifty1
set yrange [740:840]
set ytics 40
set ytics add(' 800'800)
set mytics 2
set ylabel "Diastolic [Ca^{2+}]_{JSR} (μM)"
set label 1 "{/:Bold C}" at graph -0.25,1.1 font ",18"
set key top left at 145,840 spacing 1.5

plot 	path u ($1+shift):($7-$8):($7+$8) w filledcurve fc rgb "#aaE0A080" t "",\
		path u ($1+shift):7 w l lw 2 lc 1 t "DAD",\
		path u ($1-shift):($20-$21):($20+$21) w filledcurve fc rgb "#aa629FA8" t "",\
		path u ($1-shift):20 w l lw 2 lc 2 t "DAD-TAP"

unset key
###############################################################
set origin originx+sizex1+shiftx1, originy+sizey1+shifty1
set yrange [0.155:0.2]
set ytics 0.02 offset 0.6
# set ytics add('0.14'0.14)
set mytics 2
set ylabel "Diastolic [Ca^{2+}]_i (μM)" offset 1.6
set label 1 "{/:Bold D}"

plot 	path u ($1+shift):($5-$6):($5+$6) w filledcurve fc rgb "#aaE0A080" t "",\
		path u ($1+shift):5 w l lw 2 lc 1 t "",\
		path u ($1-shift):($18-$19):($18+$19) w filledcurve fc rgb "#aa629FA8" t "",\
		path u ($1-shift):18 w l lw 2 lc 2 t ""

###############################################################
set origin originx+2*(sizex1+shiftx1), originy+sizey1+shifty1

set xrange [700:840]
set xtics 40
set mxtics 2
set xlabel "Diastolic [Ca^{2+}]_{JSR} (μM)"

set yrange [-0.02:1]
set ytics 0.2 offset 0.6
set ytics add('    0'0)
set mytics 2
set ylabel "Frequency of DAD and DAD-TAP" offset 1.2
set label 1 "{/:Bold E}"


plot 	path u ($7+$8):( ($1<300)?(($2+$15)/$28):1/0) w filledcurve y1 fc rgb "#FFE5CC"  t '',\
		path u ($7-$8):( ($1<300)?(($2+$15)/$28):1/0) w filledcurve y1 fc rgb 'white' t '',\
		path u 7:( ($1<300)?(($2+$15)/$28):1/0) w l lw 2 lc rgb '#fd7f28' t ''

set xrange [138:240]
set xtics 40 offset 0,0.3
set mxtics 2
set xlabel "V_{up} (μM)" offset 0,0.6
###############################################################
set origin originx+0*(sizex1+shiftx1), originy
set size sizex1, sizey1

set yrange [10:27]
set ytics 5
set ytics add('  10'10)
set mytics 5
set ylabel "Spark frequency (#/100 μm/s)"
set label 1 "{/:Bold F}"

plot 	path u ($1+shift):($9-$10):($9+$10) w filledcurve fc rgb "#aaE0A080" t "",\
		path u ($1+shift):9 w l lw 2 lc 1 t "",\
		path u ($1-shift):($22-$23):($22+$23) w filledcurve fc rgb "#aa629FA8" t "",\
		path u ($1-shift):22 w l lw 2 lc 2 t ""


###############################################################
set origin originx+1*(sizex1+shiftx1), originy
set size sizex1, sizey6

set yrange [0:0.26]
set ytics 0.1
set ytics add('    0'0)
set mytics 5
set ylabel "[Ca^{2+}]_i amplitude (μM)" offset 1.2,4
set label 1 "{/:Bold G}" at graph -0.25,2.5

plot 	path u ($1):($11-$12):($11+$12) w filledcurve fc rgb "#aaE0A080" t "",\
		path u 1:11 w l lw 2 lc 1 t ""



# set yrange [0:15]
# set ytics 5
# set ytics add('    0'0)
# set mytics 5
# set ylabel "V_m amplitude (mV)" offset 1.6,0
# set label 1 "{/:Bold G}" at graph -0.25,1.1

# plot 	path u ($1):($13-$14):($13+$14) w filledcurve fc rgb "#aaE0A080" t "",\
# 		path u 1:13 w l lw 2 lc 1 t ""

###############################################################
set origin originx+2*(sizex1+shiftx1), originy
set size sizex1, sizey1
set xrange [130:240]
set yrange [600:1700]
set ytics 400
# set ytics add('1400'1400, '1800'1800)
set mytics 4
set ylabel "Latency (ms)" offset 0,0
set label 1 "{/:Bold H}" at graph -0.25,1.1

plot 	path u ($1+shift):($3-$4):($3+$4) w filledcurve fc rgb "#aaE0A080" t "",\
		path u ($1+shift):3 w l lw 2 lc 1 t "",\
		path u ($1-shift):($16-$17):($16+$17) w filledcurve fc rgb "#aa629FA8" t "",\
		path u ($1-shift):16 w l lw 2 lc 2 t ""

###############################################################
set origin originx+1*(sizex1+shiftx1), originy+sizey6+shifty3
set size sizex1, sizey5
set border 2
unset xtics
unset xlabel
set format x " "
set yrange [1.3:2.5]
set ytics 0.5
set ytics add('    2'2)
set mytics 5
set ylabel " _ "
set label 1 " "
plot	path u ($1):($24-$25):($24+$25) w filledcurve fc rgb "#aa629FA8" t "",\
		path u 1:24 w l lw 2 lc 2 t ""

###############################################################

path="uptake/Vup200_4/wholecell.txt"

set origin originx, originy+2*(sizey1+shifty1)+jumpy+sizey3+sizey4+2*shifty2
set size sizex2, sizey2

set border 2
set xrange [9.9:39]
unset xtics
unset xlabel
set format x " "
set yrange [-100:60]
set ytics 60 offset 0.6
set ytics add('   0'0)
set mytics 3
set ylabel "V_m (mV)" offset 0,1.2
set label 1 "{/:Bold A}" at graph -0.1,1.25
# set label 2 "V_{up} = 200 μM" at graph 0.05,1.2

plot	path u ($1/1000):7 every 2 w l lw 1 lc -1 t "",\
		path u ($1/1000):( ($1>1539&&$1<2100)?$7:1/0 ) every 16 w l lw 1.5 lc 1 t "",\
		path u ($1/1000):( ($1>3323&&$1<4100)?$7:1/0 ) every 16 w l lw 1.5 lc 1 t "",\
		path u ($1/1000):( ($1>7339&&$1<8100)?$7:1/0 ) every 16 w l lw 1.5 lc 1 t "",\
		path u ($1/1000):( ($1>11783&&$1<12100)?$7:1/0 ) every 16 w l lw 1.5 lc 1 t "",\
		path u ($1/1000):( ($1>13883&&$1<14100)?$7:1/0 ) every 16 w l lw 1.5 lc 1 t "",\
		path u ($1/1000):( ($1>15463&&$1<15953)?$7:1/0 ) every 16 w l lw 1.5 lc 1 t "",\
		path u ($1/1000):( ($1>21366&&$1<22100)?$7:1/0 ) every 16 w l lw 1.5 lc 1 t "",\
		path u ($1/1000):( ($1>27441&&$1<28100)?$7:1/0 ) every 16 w l lw 1.5 lc 2 t "",\
		path u ($1/1000):( ($1>29235&&$1<29979)?$7:1/0 ) every 16 w l lw 1.5 lc 2 t "",\
		path u ($1/1000):( ($1>31182&&$1<31896)?$7:1/0 ) every 16 w l lw 1.5 lc 2 t "",\
		path u ($1/1000):( ($1>33098&&$1<33843)?$7:1/0 ) every 16 w l lw 1.5 lc 2 t "",\
		path u ($1/1000):( ($1>35332&&$1<35757)?$7:1/0 ) every 16 w l lw 1.5 lc 2 t "",\
		path u ($1/1000):( ($1>37246&&$1<37747)?$7:1/0 ) every 16 w l lw 1.5 lc 2 t ""


unset label
###############################################################
set origin originx, originy+2*(sizey1+shifty1)+jumpy+sizey4+shifty2
set size sizex2, sizey3

set border 2
set xrange [9.9:39]
unset xtics
unset xlabel
set format x " "
set yrange [0.1:0.4]
set ytics 0.2
set ytics add('   0'0)
set mytics 2
set ylabel "[Ca^{2+}]_i (μM)     "

plot	path u ($1/1000):2 every 16 w l lw 1 lc -1 t "",\
		0.17 w l lw 1.5 dt 2 lc 9 t "",\
		path u ($1/1000):( ($1>1539&&$1<2100)?$2:1/0 ) every 16 w l lw 1.5 lc 1 t "",\
		path u ($1/1000):( ($1>3323&&$1<4100)?$2:1/0 ) every 16 w l lw 1.5 lc 1 t "",\
		path u ($1/1000):( ($1>7339&&$1<8100)?$2:1/0 ) every 16 w l lw 1.5 lc 1 t "",\
		path u ($1/1000):( ($1>11783&&$1<12100)?$2:1/0 ) every 16 w l lw 1.5 lc 1 t "",\
		path u ($1/1000):( ($1>13883&&$1<14100)?$2:1/0 ) every 16 w l lw 1.5 lc 1 t "",\
		path u ($1/1000):( ($1>15463&&$1<15953)?$2:1/0 ) every 16 w l lw 1.5 lc 1 t "",\
		path u ($1/1000):( ($1>21366&&$1<22100)?$2:1/0 ) every 16 w l lw 1.5 lc 1 t "",\
		path u ($1/1000):( ($1>27441&&$1<28100)?$2:1/0 ) every 16 w l lw 1.5 lc 2 t "",\
		path u ($1/1000):( ($1>29235&&$1<29979)?$2:1/0 ) every 16 w l lw 1.5 lc 2 t "",\
		path u ($1/1000):( ($1>31182&&$1<31896)?$2:1/0 ) every 16 w l lw 1.5 lc 2 t "",\
		path u ($1/1000):( ($1>33098&&$1<33843)?$2:1/0 ) every 16 w l lw 1.5 lc 2 t "",\
		path u ($1/1000):( ($1>35332&&$1<35757)?$2:1/0 ) every 16 w l lw 1.5 lc 2 t "",\
		path u ($1/1000):( ($1>37246&&$1<37747)?$2:1/0 ) every 16 w l lw 1.5 lc 2 t ""
###############################################################
set origin originx, originy+2*(sizey1+shifty1)+jumpy
set size sizex2, sizey4

set border 2
set xrange [9.9:39]
unset xtics
unset xlabel
set format x " "
set yrange [350:820]
set ytics 200
set ytics add('800'800)
set mytics 2
set ylabel "[Ca^{2+}]_{JSR} (μM)"

plot	path u ($1/1000):5 every 16 w l lw 1 lc -1 t "",\
		808 w l lw 1.5 dt 2 lc 9 t "",\
		path u ($1/1000):( ($1>1539&&$1<2100)?$5:1/0 ) every 16 w l lw 1.5 lc 1 t "",\
		path u ($1/1000):( ($1>3323&&$1<4100)?$5:1/0 ) every 16 w l lw 1.5 lc 1 t "",\
		path u ($1/1000):( ($1>7339&&$1<8100)?$5:1/0 ) every 16 w l lw 1.5 lc 1 t "",\
		path u ($1/1000):( ($1>11783&&$1<12100)?$5:1/0 ) every 16 w l lw 1.5 lc 1 t "",\
		path u ($1/1000):( ($1>13883&&$1<14100)?$5:1/0 ) every 16 w l lw 1.5 lc 1 t "",\
		path u ($1/1000):( ($1>15463&&$1<15953)?$5:1/0 ) every 16 w l lw 1.5 lc 1 t "",\
		path u ($1/1000):( ($1>21366&&$1<22100)?$5:1/0 ) every 16 w l lw 1.5 lc 1 t "",\
		path u ($1/1000):( ($1>27441&&$1<28100)?$5:1/0 ) every 16 w l lw 1.5 lc 2 t "",\
		path u ($1/1000):( ($1>29235&&$1<29979)?$5:1/0 ) every 16 w l lw 1.5 lc 2 t "",\
		path u ($1/1000):( ($1>31182&&$1<31896)?$5:1/0 ) every 16 w l lw 1.5 lc 2 t "",\
		path u ($1/1000):( ($1>33098&&$1<33843)?$5:1/0 ) every 16 w l lw 1.5 lc 2 t "",\
		path u ($1/1000):( ($1>35332&&$1<35757)?$5:1/0 ) every 16 w l lw 1.5 lc 2 t "",\
		path u ($1/1000):( ($1>37246&&$1<37747)?$5:1/0 ) every 16 w l lw 1.5 lc 2 t ""


unset multiplot











