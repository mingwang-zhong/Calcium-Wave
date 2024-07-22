###################################################################################
###################################################################################
reset
set term pdfcairo enhanced color size 7,3.8 font 'Helvetica,12' background rgb "#ffffff"
set output "clamp_EAD3.pdf"

set multiplot

originx=0.02
sizex1=0.49
sizex2=0.404
originy1=0.0
originy2=0.0
sizey1=0.35
sizey2=0.35
shiftx=0.017
shifty1=-0.02
shifty2=-0.02

path11="DAD/Hill10_alpha0.2_beta0.001_cstar1/wholecell.txt"
path12="DAD/Hill10_alpha0.2_beta0.001_cstar1_clamp_Vm/wholecell.txt"
path13="DAD/Hill10_alpha0.2_beta0.001_cstar1_clamp_cp/wholecell.txt"

path21="DAD/Hill10_alpha0.2_beta0.001_cstar1/linescan.txt"
path22="DAD/Hill10_alpha0.2_beta0.001_cstar1_clamp_Vm/linescan.txt"
path23="DAD/Hill10_alpha0.2_beta0.001_cstar1_clamp_cp/linescan.txt"

###############################################################
###############################################################
set border 0
unset xtics
unset ytics
set origin 0,0
set size 1,1
set arrow 1 from 18.0,0 to 18.0,102 nohead dt 2 lw 1
set arrow 2 from 65.3,-10 to 65.3,102 nohead dt 2 lw 1 back

set xrange [0:100]
set yrange [0:100]

plot 1000 t ""

unset arrow
###############################################################
###############################################################

set border 2 lw 1
set tics out nomirror scale 0.7
unset xtics
xstart=14050
set xrange [xstart:(xstart+600)]
set size sizex1, sizey1

set origin originx, originy1+2*(sizey1+shifty1)
set yrange [-100:60]
set ytics 60 offset 0.6 nomirror
set mytics 3
set ylabel "V_m (mV)" offset 1.2
set label 10 "{/:Bold A}" at graph -0.2,1 font ",18"

set arrow 1 from 14310,-37.6 to 14410,-37.6 lw 1 nohead
set label 1 '-38 mV' at 14420,-37.6

x=7
plot 	path11 u 1:x w l lw 2 t "",\
		path12 u 1:x w l lw 2 t "",\
		path12 u ( ($1>=14209)?$1:1/0 ):x w l lw 4 lc 2 t "",\
		path13 u 1:x w l lw 2 lc 4 t ""

unset arrow
unset label 1
###################################################

set origin originx, originy1+1*(sizey1+shifty1)
set yrange [0:4.5]
set ytics 1
set ytics add('  0'0)
set mytics 2
set ylabel "[Ca^{2+}]_i (μM)"
set label 10 "{/:Bold B}"
set key samplen 2 at xstart+600,4 spacing 1.5

x=2
plot 	path11 u 1:x w l lw 2 t "Control",\
		path13 u 1:x w l lw 2 lc 4 t "[Ca^{2+}]_p clamped",\
		path12 u 1:x w l lw 2 lc 2 t "V_m clamped",\
		path13 u 1:x w l lw 2 lc 4 t ""

###################################################

set origin originx, originy1+0*(sizey1+shifty1)
set yrange [-5:80]
set ytics 20
set ytics add('  0'0)
set mytics 2
set ylabel "[Ca^{2+}]_p (μM)"
set label 10 "{/:Bold C}"
# set arrow 1 from 14209,16 to 14209,4 filled size screen 0.015,15 lw 2
set arrow 2 from 14370,8 to 14470,30 filled size screen 0.01,20 lw 1 lc 8
set object 1 rect from 14150,-2 to 14700,8 fc rgb "#F0F0F0" fs solid 0 border rgb "gray50" lw 1 back
set arrow 1 from xstart+50,-5 to xstart+150,-5 nohead lw 4
set label 1 "0.1 s" at xstart+70,-10

x=3
plot 	path11 u 1:x w l lw 2 t "",\
		path12 u 1:x w l lw 2 t "",\
		path13 u 1:x w l lw 2 lc 4 t "",\
		path13 u ( ($1>=14209)?$1:1/0 ):x w l lw 4 lc 4 t ""

unset label
unset arrow
unset object
###############################################################
###############################################################
set border 0
unset ytics
unset ylabel
unset colorbox
set size sizex2, sizey2

set cbrange [0:4]

set yrange [0:64]
set palette defined (0 '#3B37A3', 0.2 '#52B8D3', 0.4 '#51AA1A', 0.6 '#FFF35C', 0.8 '#D12921', 1 '#D12921' ) 

set origin originx+sizex1+shiftx, originy2+2*(sizey2+shifty2)
set label 10 "{/:Bold D}" at graph -0.1,0.95 font ",18"
set label 2 "Control" right at graph 0.95,0.9 tc rgb "#ffffff" front
plot path21 u 1:2:3 every :4 w image t ""

unset label 10

set origin originx+sizex1+shiftx, originy2+1*(sizey2+shifty2)
set arrow 1 from xstart+610,15 to xstart+610,45.3 nohead lw 4
set label 1 "50 μm" at xstart+635,24 rotate by 90
set label 2 "[Ca^{2+}]_p clamped"
plot path23 u 1:2:3 every :4 w image t ""

set origin originx+sizex1+shiftx, originy2+0*(sizey2+shifty2)
set cbtics nomirror 2 offset -1.2,0 scale 0.3 out
set colorbox user origin 0.91,0.034 size 0.015,0.28 noborder
set cblabel "[Ca^{2+}]_i (μM)" rotate by 90 offset -0.5
set arrow 1 from xstart+50,-1 to xstart+150,-1 nohead lw 4
# set arrow 2 from 14209,-10 to 14209,0 filled size screen 0.02,12
# set arrow 3 from 14209,73 to 14209,63 filled size screen 0.02,12
set label 1 "0.1 s" at xstart+70,-5 rotate by 0
set label 2 "V_m clamped"
plot path22 u 1:2:3 every :4 w image t ""


unset label
unset arrow
###############################################################
###############################################################
set border 15 lw 1 lc 8
set origin 0.35,0.08
set size 0.14,0.25
set xrange [14150:14700]
set yrange [0:8]
# set arrow 1 from 14209,4.2 to 14209,2.2 lw 1 filled size screen 0.02,12
set arrow 2 from 14209,0 to 14209,8 nohead dt 2 lw 1

x=3
plot 	path11 u 1:x w l lw 2 t "",\
		path12 u 1:x w l lw 2 t "",\
		path13 u 1:x w l lw 2 lc 4 t "",\
		path13 u ( ($1>=14209)?$1:1/0 ):x w l lw 4 lc 4 t ""


unset multiplot
set term x11