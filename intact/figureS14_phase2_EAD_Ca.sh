###################################################################################
###################################################################################
reset
set term pdfcairo enhanced color size 7,3.8 font 'Helvetica,12' background rgb "#ffffff"
set output "clamp_EAD2.pdf"

set multiplot

originx1=-0.01 # lines
sizex1=0.32
shiftx1=0.03

originy1=0.01
sizey1=0.35
shifty1=0.03

originx2=0.037 # images
sizex2=0.28-0.007
shiftx2=0.077

originy2=0.3
sizey2=0.25
shifty2=0.03

path11="DAD/Hill12_alpha0.2_beta0.001_cstar1/wholecell.txt"
path12="DAD/Hill12_alpha0.2_beta0.001_cstar1_clamp_Vm/wholecell.txt"
path13="DAD/Hill12_alpha0.2_beta0.001_cstar1_clamp_cp/wholecell.txt"

path21="DAD/Hill12_alpha0.2_beta0.001_cstar1/linescan.txt"
path22="DAD/Hill12_alpha0.2_beta0.001_cstar1_clamp_Vm/linescan.txt"
path23="DAD/Hill12_alpha0.2_beta0.001_cstar1_clamp_cp/linescan.txt"

###############################################################
###############################################################
# set border 0
# unset xtics
# unset ytics
# set origin 0,0
# set size 1,1
# set arrow 1 from 10.2,0 to 10.2,102 nohead dt 2 lw 1
# set arrow 2 from 50.3,-10 to 50.3,102 nohead dt 2 lw 1 back
# set arrow 3 from 85.3,-10 to 85.3,102 nohead dt 2 lw 1 back

# set xrange [0:100]
# set yrange [0:100]

# plot 1000 t ""

# unset arrow
###############################################################
###############################################################

set border 2 lw 1
set tics out nomirror scale 0.7
unset xtics
xstart=24050
t0=24196
set xrange [xstart:(xstart+600)]
set size sizex1, sizey1

set origin originx1, originy1+1*(sizey1+shifty1)
set yrange [-100:60]
set ytics 60 offset 0.6 nomirror
set mytics 3
set ylabel "V_m (mV)" offset 1.2
set label 10 "{/:Bold B}" at graph -0.25,1 font ",18"

set arrow 1 from 24296,-21.8 to 24370,-21.8 lw 1 nohead
set label 1 '-22 mV' at 24320,-30

set arrow 2 from t0,43 to t0,25 filled size screen 0.01,20 lw 1 lc 8

x=7
plot 	path11 u 1:x w l lw 1 lc 1 t "",\
		path12 u ( ($1<=t0)?$1:1/0 ):x w l lw 1 lc 2  t "",\
		path12 u ( ($1>=t0)?$1:1/0 ):x w l lw 2 lc 2  t "",\
		path13 u 1:x w l lw 1 lc 4 t ""

unset arrow
unset label 1
###################################################

set origin originx1, originy1+0*(sizey1+shifty1)
set yrange [0:4.5]
set ytics 2
set ytics add('  0'0)
set mytics 4
set ylabel "[Ca^{2+}]_i (μM)"
set label 10 "{/:Bold C}"
set key samplen 2 at xstart+620,6 spacing 1.5
set arrow 1 from xstart+50,-0.2 to xstart+150,-0.2 nohead lw 3
set label 1 "0.1 s" at xstart+55,-0.5

set arrow 2 from t0,1.2 to t0,0.7 filled size screen 0.01,20 lw 1 lc 8

x=2
plot 	path11 u 1:x w l lw 1 lc 1 t "Control",\
		path13 u 1:x w l lw 1 lc 4 t "[Ca^{2+}]_p clamped",\
		path12 u 1:x w l lw 1 lc 2  t "V_m clamped",\
		path13 u 1:x w l lw 1 lc 4 t ""

unset arrow 1
unset label 1
###################################################
set origin originx1+1*(sizex1+shiftx1), originy1+1*(sizey1+shifty1)
set yrange [0:80]
set ytics 40
set ytics add('  0'0)
set mytics 4
set ylabel "[Ca^{2+}]_p (μM)"
set label 10 "{/:Bold D}"
set arrow 2 from t0,12 to t0,2 filled size screen 0.01,20 lw 1 lc 8
# set object 1 rect from 14150,-2 to 14700,8 fc rgb "#F0F0F0" fs solid 0 border rgb "gray50" lw 1 back
# set arrow 1 from xstart+50,-8.78 to xstart+150,-8.78 nohead lw 3
# set label 1 "0.1 s" at xstart+55,-14.444

x=3
plot 	path11 u 1:x w l lw 1 lc 1 t "",\
		path12 u 1:x w l lw 1 lc 2  t "",\
		path13 u ( ($1<=t0)?$1:1/0 ):x w l lw 1 lc 4 t "",\
		path13 u ( ($1>=t0)?$1:1/0 ):x w l lw 2 lc 4 t ""


###################################################
set origin originx1+1*(sizex1+shiftx1), originy1+0*(sizey1+shifty1)
set yrange [0:8]
set ytics 4
set ytics add('  0'0)
set mytics 2
set ylabel "[Ca^{2+}]_p (μM)"
set label 10 ""
set arrow 2 from t0,3 to t0,2 filled size screen 0.01,20 lw 1 lc 8
# set object 1 rect from 14150,-2 to 14700,8 fc rgb "#F0F0F0" fs solid 0 border rgb "gray50" lw 1 back
set arrow 1 from xstart+50,-0.4 to xstart+150,-0.4 nohead lw 3
set label 1 "0.1 s" at xstart+55,-0.9

x=3
plot 	path11 u 1:x w l lw 1 lc 1 t "",\
		path12 u 1:x w l lw 1 lc 2  t "",\
		path13 u ( ($1<=t0)?$1:1/0 ):x w l lw 1 lc 4 t "",\
		path13 u ( ($1>=t0)?$1:1/0 ):x w l lw 2 lc 4 t ""

unset arrow
unset object
unset label 1
###################################################
set origin originx1+2*(sizex1+shiftx1), originy1+1*(sizey1+shifty1)
set yrange [-3:1.5]
set ytics 1
set ytics add('  0'0)
set mytics 2
set ylabel "{/Helvetica-Italic I}_{NCX} (pA/pF)"
set label 10 "{/:Bold E}"

set arrow 2 from t0,1.3 to t0,0.8 filled size screen 0.01,20 lw 1 lc 8

x=8
plot 	path11 u 1:x w l lw 1 lc 1 t "",\
		path12 u 1:x w l lw 1 lc 2  t "",\
		path13 u 1:x w l lw 1 lc 4 t ""

###################################################
set origin originx1+2*(sizex1+shiftx1), originy1+0*(sizey1+shifty1)
set yrange [-8:0]
set ytics 4
set ytics add('  0'0)
set mytics 2
set ylabel "{/Helvetica-Italic I}_{Ca,L} (pA/pF)"
set label 10 "{/:Bold F}"
set arrow 1 from xstart+50,-8.3 to xstart+150,-8.3 nohead lw 3
set label 1 "0.1 s" at xstart+55,-8.8

set arrow 2 from t0,-1.5 to t0,-2.5 filled size screen 0.01,20 lw 1 lc 8

x=9
plot 	path11 u 1:x w l lw 1 lc 1 t "",\
		path12 u 1:x w l lw 1 lc 2  t "",\
		path13 u 1:x w l lw 1 lc 4 t ""

unset label
###############################################################
###############################################################
set border 0
unset ytics
unset ylabel
unset colorbox
set size sizex2, sizey2

set cbrange [0:4]

set yrange [0:64]
set palette defined (0 '#3B37A3', 0.5 '#c63361',  1 '#f5c344' )

set origin originx2+0*(sizex2+shiftx2), originy1+2*(sizey1+shifty1)
set label 10 "{/:Bold A}" at graph -0.25,0.95 font ",18"
set arrow 1 from xstart-10,15 to xstart-10,45.3 nohead lw 3
set label 1 "50 μm" at xstart-40,17 rotate by 90
set label 2 "Control" right at graph 0.95,0.87 tc rgb "#ffffff" front
set arrow 2 from t0,-10 to t0,0 filled size screen 0.01,20 lw 1 lc 8
plot path21 u 1:2:3 every :1 w image t ""

unset label 10
unset label 1
unset arrow 1

set origin originx2+1*(sizex2+shiftx2), originy1+2*(sizey1+shifty1)
set cbtics nomirror 2 offset 0,0.5 scale 0.3 out
set colorbox horizontal user origin 0.52,0.77 size 0.1,0.02 noborder
set cblabel "[Ca^{2+}]_i (μM)" offset 0,1
set label 2 "[Ca^{2+}]_p clamped"
set arrow 2 from t0,-10 to t0,0 filled size screen 0.01,20 lw 1 lc 8
plot path23 u 1:2:3 every :1 w image t ""

set origin originx2+2*(sizex2+shiftx2), originy1+2*(sizey1+shifty1)
# set arrow 1 from xstart+50,-1 to xstart+150,-1 nohead lw 3
# set arrow 2 from t0,-10 to t0,0 filled size screen 0.02,12
# set arrow 3 from t0,73 to t0,63 filled size screen 0.02,12
# set label 1 "0.1 s" at xstart+55,-5 rotate by 0
set label 2 "V_m clamped"
set arrow 2 from t0,-10 to t0,0 filled size screen 0.01,20 lw 1 lc 8
plot path22 u 1:2:3 every :1 w image t ""


unset label
unset arrow

unset multiplot

