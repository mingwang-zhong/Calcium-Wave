
reset
set term pdfcairo enhanced color size 7,5 font 'Helvetica,12' background rgb "#ffffff"

set output "EAD2_CaMediated.pdf"
set multiplot 

set border 3
set tics scale 0


path11 = "DAD/Hill12_alpha0.2_beta0.004_cstar2/wholecell.txt"
path12 = "DAD/Hill12_alpha0.2_beta0.004_cstar0.8/wholecell.txt"
path13 = "DAD/Hill12_alpha0.2_beta0.004_cstar0.8_clamp_cp_fast/wholecell.txt"

path21 = "DAD/Hill12_alpha0.2_beta0.004_cstar2/linescan.txt"
path22 = "DAD/Hill12_alpha0.2_beta0.004_cstar0.8/linescan.txt"
path23 = "DAD/Hill12_alpha0.2_beta0.004_cstar0.8_clamp_cp_fast/linescan.txt"

#####################################################################
#####################################################################
set label 1 "{/:Bold A}" at graph -0.05,0.95 center font ', 18'
set origin 0.05,0.89
set size 0.95,0.12
unset xtics 
unset ytics
unset border
set xrange [-0.1:16]
x=7

plot     path11 u ($1/1000-4.1):x every 4 w l lw 1 lc 1 t ""

#####################################################################
#####################################################################
unset label 1 
set origin 0.05,0.81
set size 0.95,0.12
unset xtics 
unset ytics
unset border
set xrange [-0.1:16]
x=7

plot     path12 u ($1/1000-4.1):x every 4 w l lw 1 lc 2 t ""


set border 2
set ytics out scale 0.5 nomirror
set format x ""
unset xlabel

originx=0.01
originy=0.01
sizex=0.48
sizey=0.22
sizey2=0.17 # image
shiftx=0.035
shifty=-0.02
shifty2=-0.04 # image
shiftimagex=0.065
shiftimagey=0.0
set size sizex, sizey
set xrange [-0.05:1.5]
set style arrow 7 nohead lw 2
set style arrow 1 head filled lw 1 size screen 0.01,10
#####################################################################
#####################################################################
set origin originx, originy+3*(sizey+shifty)
set label 1 "{/:Bold B}" at graph -0.2,1.02 center font ', 18'
set yrange [-100:60]
set ytics nomirror 200 offset 0.6
set ytics add('  -80'-80, '-40'-40, '0'0, '40'40)
set mytics 10
set ylabel "V_m (mV)" offset 2
set arrow 1 from 0.295,-50 to 0.295,-27 as 1
set arrow 2 from 0.15,-25 to 0.65,-25 nohead lw 0.5 dt 2 
set label 2 '-25 mV' at 0.67,-25
set key spacing 1.5 right at 1.5,60

x=7

plot     path11 u ($1/1000-12.1):x every 4 w l lw 1 lc 1 t "",\
        path12 u ($1/1000-10.1):x every 4 w l lw 1 lc 2 t "",\
        path13 u ($1/1000-10.1):x every 4 w l lw 1 lc 4 t ""

unset arrow 2
unset label 2
#####################################################################
#####################################################################
set origin originx, originy+2*(sizey+shifty)
set label 1 "{/:Bold C}" 
set yrange [300:1100]
set ytics nomirror 200
set mytics 2
set ylabel "[Ca^{2+}]_{JSR} (μM)"
set arrow 1 from 0.295,400 to 0.295,500 as 1

x=5

plot     path11 u ($1/1000-12.1):x every 4 w l lw 1 lc 1 t "",\
        path12 u ($1/1000-10.1):x every 4 w l lw 1 lc 2 t "",\
        path13 u ($1/1000-10.1):x every 4 w l lw 1 lc 4 t ""


set size sizex-shiftimagex, sizey2
unset ylabel
unset arrow 1
set format y ""
#####################################################################
#####################################################################
set origin originx+shiftimagex, originy+2*(sizey2+shifty2)
unset xtics
unset ytics
set border 0

set label 1 "{/:Bold D}" at graph -0.17,1.02
set label 2 "c* = 2 μM" at graph 0.95,0.9 right tc rgb "#ffffff" front
set yrange [1:62]
set cbrange [0:2]
unset colorbox
set palette defined (0 '#3B37A3', 0.5 '#c63361',  1 '#f5c344' )

x=2

plot     path21 u ($1/1000-12.1):2:3 every :4 w image t ""

#####################################################################
#####################################################################
set origin originx+shiftimagex, originy+1*(sizey2+shifty2)
set label 1 "{/:Bold E}" 
set label 2 "c* = 0.8 μM"
set yrange [1:62]

set cbtics nomirror 2 offset -5.5 scale 0.5
set mcbtics 2
set colorbox user origin 0.07,0.035 size 0.02,0.162 noborder
unset colorbox
set cbrange [0:2]
set cblabel "c_i (μM)" rotate by 90 offset -7

x=2

plot     path22 u ($1/1000-10.1):2:3 every :4 w image t ""


#####################################################################
#####################################################################
set origin originx+shiftimagex, originy+0*(sizey2+shifty2)
set label 1 "{/:Bold F}" 
set label 2 "c* = 0.8 μM"
set label 22 "[Ca^{2+}]_p clamped" at graph 0.95,0.65 right tc rgb "#ffffff" front
set yrange [1:62]
set arrow 3 from -0.07,10 to -0.07,40.3 as 7 
set label 3 "50 μm" at -0.12,12 rotate by 90
set arrow 4 from 0,-2 to 0.2,-2 as 7
set label 4 "0.2 s" at 0.03,-8 rotate by 0

set cbtics nomirror 2 offset -5.5 scale 0.5
set mcbtics 2
set colorbox user origin 0.07,0.035 size 0.02,0.162 noborder
unset colorbox
set cbrange [0:2]
set cblabel "c_i (μM)" rotate by 90 offset -7
set arrow 1 from 0.295,-12 to 0.295,0 as 1

x=2

plot     path23 u ($1/1000-10.1):2:3 every :4 w image t ""



unset arrow
unset label
set border 2
set ytics out nomirror scale 0.5
set size sizex, sizey
set format y "%g"
#####################################################################
#####################################################################
set origin originx+sizex+shiftx, originy+3*(sizey+shifty)
set label 1 "{/:Bold G}" at graph -0.2,1.02 center font ",18"
set yrange [0:6]
set ytics nomirror 2 offset 0.6
set ytics add('  0'0)
set mytics 2
set ylabel "[Ca^{2+}]_i (μM)" offset 1.2
set key spacing 1.5 right at 1.5,6
set arrow 1 from 0.295,1.7 to 0.295,0.9 as 1

x=2

plot     path11 u ($1/1000-12.1):x every 4 w l lw 1 lc 1 t "c* = 2 μM",\
        path12 u ($1/1000-10.1):x every 4 w l lw 1 lc 2 t "c* = 0.8 μM",\
        path13 u ($1/1000-10.1):x every 4 w l lw 1 lc 4 t "[Ca^{2+}]_p clamped, c* = 0.8 μM"


#####################################################################
#####################################################################
set origin originx+sizex+shiftx, originy+2*(sizey+shifty)
set label 1 "{/:Bold H}" at graph -0.2,1.02 center font ",18"
set yrange [0:80]
set ytics nomirror 40 offset 0.6
set ytics add('  0'0)
set mytics 4
set ylabel "[Ca^{2+}]_p (μM)" offset 1.2
set key spacing 1.5
set arrow 1 from 0.295,16 to 0.295,4.5 as 1
set object 2 rect from 0.1,0 to 0.7,5 fc rgb "#F0F0F0" fs solid 0 border rgb "grey50" back lw 0.5
set arrow 2 from 0.7,5 to 0.89,14 filled size screen 0.01,15 lc 9 lw 0.5

x=3

plot     path11 u ($1/1000-12.1):x every 4 w l lw 1 lc 1 t "",\
        path12 u ($1/1000-10.1):x every 4 w l lw 1 lc 2 t "",\
        path13 u ($1/1000-10.1):x every 4 w l lw 1 lc 4 t ""

unset arrow
unset object
#####################################################################
#####################################################################
set origin originx+sizex+shiftx, originy+1*(sizey+shifty)
set label 1 "{/:Bold I}" 
set yrange [-9:0]
set ytics nomirror 4
set mytics 4
set ylabel "{/Helvetica-Italic I}_{Ca,L} (pA/pF)"
set ytics add('  0'0)
set arrow 1 from 0.295,-3.5 to 0.295,-2.2 as 1

x=9

plot     path11 u ($1/1000-12.1):x every 4 w l lw 1 lc 1 t "",\
        path12 u ($1/1000-10.1):x every 4 w l lw 1 lc 2 t "",\
        path13 u ($1/1000-10.1):x every 4 w l lw 1 lc 4 t ""



#####################################################################
#####################################################################
set origin originx+sizex+shiftx, originy+0*(sizey+shifty)
set label 1 "{/:Bold J}" 
set yrange [-3:1.5]
set ytics nomirror 1
set ytics add(' -2'-2)
set mytics 2
set ylabel "{/Helvetica-Italic I}_{NCX} (pA/pF)"
set arrow 4 from 0,-3.1 to 0.2,-3.1 as 7
set label 4 "0.2 s" at 0.03,-3.5 rotate by 0
set arrow 1 from 0.295,-2.3 to 0.295,-1.7 as 1

x=8

plot     path11 u ($1/1000-12.1):x every 4 w l lw 1 lc 1 t "",\
        path12 u ($1/1000-10.1):x every 4 w l lw 1 lc 2 t "",\
        path13 u ($1/1000-10.1):x every 4 w l lw 1 lc 4 t ""



unset label
unset arrow 4
set border 15 lw 0.5
#####################################################################
##################################################################### Inset {/Helvetica-Italic I}_NCX vs Vm
set origin 0.77,0.15
set size 0.23,0.24
set tics nomirror out scale 0.6
set format x "%g"
set xrange [-90:60]
set xtics 40 offset 0,0.6 nomirror
set mxtics 2
set xlabel "V_m (mV)" offset 0,1.2

set yrange [-3:1.5]
set ytics 2
set mytics 4
set ylabel "{/Helvetica-Italic I}_{NCX} (pA/pF)"

set arrow 1 from -8,-1.5 to -18,-2 as 1 lc 9
# set arrow 2 from -25,-1.5 to -12,-0.9 as 1 lc 9

plot     path11 u 7:( ($1>12102&&$1<13000)?$8:1/0 ) every 4 w l lw 1 lc 1 t "",\
        path12 u 7:( ($1>10102&&$1<11000)?$8:1/0 ) every 4 w l lw 1 lc 2 t "",\
        path13 u 7:( ($1>10102&&$1<11000)?$8:1/0 ) every 4 w l lw 1 lc 4 t ""


#####################################################################
##################################################################### Inset cp
set origin 0.805,0.44
set size 0.195,0.2
unset xtics
unset xlabel
unset ytics
unset ylabel
set xrange [0.1:0.7]
set yrange [0:5]

set arrow 1 from 0.295,4.3 to 0.295,3.6 as 1

plot    path11 u ($1/1000-12.1):3 w l lw 1 lc 1 t "",\
        path12 u ($1/1000-10.1):3 w l lw 1 lc 2 t "",\
        path13 u ($1/1000-10.1):3 w l lw 1 lc 4 t ""


unset multiplot
set term qt





