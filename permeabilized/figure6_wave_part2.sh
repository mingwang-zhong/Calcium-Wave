reset

set term pdfcairo enhanced color size 7,2 font 'Helvetica,12' background rgb "#ffffff"

set output "wave_transition_ci.pdf"
set multiplot 


unset key
unset colorbox
brick=1
set style arrow 1 nohead lw 3
set style arrow 2 nohead lw 1.5
set style arrow 3 nohead lw 5
path="Hill7_alpha0.2_beta0.004_cstar1.1/"
set palette defined (0 '#3B37A3', 0.5 '#c63361',  1 '#f5c344' )


# originx=0.05
# sizex1=0.173 # ci = 0.1, ci = 0.2 linescanes
# sizex2=0.295 # ci = 0.3, ci = 0.4 linescanes
# shiftx=-0.015 # left shift of ci=0.1,0.2,0.3,0.4 linescanes

originx=0.05
sizex1=0.17 # ci = 0.1, ci = 0.2 linescanes
sizex2=0.31 # ci = 0.3, ci = 0.4 linescanes
shiftx=0.028 # left shift of ci=0.1,0.2,0.3,0.4 linescanes
shiftxwhy=0.018 # don't understand why I should add this

originy=0
sizey=0.6
shifty=0.03
sizey2=0.4


set origin originx, originy+sizey2+shifty
set size sizex1+shiftxwhy, sizey-0.02
set border 0
unset xtics
unset ytics
set yrange [1:62]
set cbrange [0:5] 

set label 5 "{/:Bold E}" at graph -0.5,0.98 font ",18"

xstart=11
set xrange [xstart:xstart+1]
# set xtics nomirror 1
set arrow 1 from xstart+0.1,-3 to xstart+0.6,-3 nohead lw 3
set label 1 "0.5 s" at xstart+0.2,-8
set arrow 2 from xstart-0.05,30 to xstart-0.05,48.18 as 1
set label 2 "30 μm" at xstart-0.15,28 rotate by 90
set label 3 "0.1 μM" at xstart+0.1,55 front tc rgb "#ffffff"
set arrow 4 from xstart-0.05,14 to xstart+0.02,14 as 3

plot 	path."ci0.1/linescan.txt" every :brick u ($1/1000):2:3 w image

unset arrow 1
unset label 1
unset arrow 2
unset label 2
unset label 5
##################################################################################
set origin (sizex1-shiftx+originx+shiftxwhy), originy+sizey2+shifty
set size sizex1, sizey-0.02
xstart=11
set xrange [xstart:xstart+1]
set label 3 "0.15 μM" at xstart+0.1,55
set arrow 4 from xstart-0.05,14 to xstart+0.02,14 as 3

plot 	path."ci0.15/linescan.txt" every :brick u ($1/1000):2:3 w image


##################################################################################
set origin 2*sizex1-2*shiftx+originx+shiftxwhy, originy+sizey2+shifty
set size sizex2, sizey-0.02
xstart=11
set xrange [xstart:xstart+2]
set label 3 "0.2 μM" at xstart+0.1,55
set arrow 4 from xstart-0.05,10 to xstart+0.02,10 as 3

plot 	path."ci0.2/linescan.txt" every :brick u ($1/1000):2:3 w image


##################################################################################

set origin sizex2+2*sizex1-3*shiftx+originx+shiftxwhy, originy+sizey2+shifty
set size sizex2, sizey-0.02

xstart=22
set xrange [xstart:xstart+2]
set label 3 "0.3 μM" at xstart+0.4,55
set arrow 4 from xstart-0.05,26 to xstart+0.02,26 as 3

set colorbox user origin 2*sizex2+2*sizex1-3*shiftx+originx+shiftxwhy-0.02, originy+sizey2+shifty+0.06 size 0.02,sizey-0.13 noborder
set cbtics nomirror 2 in offset -0.9
set mcbtics 2
set cblabel "[Ca^{2+}]_i (μM)" rotate by 90 offset -0.6


plot 	path."ci0.3/linescan.txt" every :brick u ($1/1000):2:3 w image


unset arrow 4




set yrange [0:0.5]
##################################################################################

set origin originx-0.055, originy
set size sizex1+shiftxwhy+0.055, sizey2

set border 2
set label 5 "{/:Bold F}" at graph -0.5,1.15 font ",18"
xstart=11
set xrange [xstart:xstart+1]
# set ytics out scale 0.5 nomirror 2 offset 1
# set ytics add('1'1)
# set mytics 2
set ylabel "[Ca^{2+}]_i (μM)" offset 0.5,0
set ytics 0.2 out nomirror
set mytics 2

plot 	path."ci0.1/wholecell.txt" u ($1/1000):2 w l lc -1 lw 2

set border 0
unset ytics 
unset ylabel
unset label 5

##################################################################################
set origin (sizex1-shiftx+originx+shiftxwhy), originy
set size sizex1, sizey2
xstart=11
set xrange [xstart:xstart+1]

plot 	path."ci0.15/wholecell.txt" u ($1/1000):2 w l lw 2 lc -1

##################################################################################
set origin 2*sizex1-2*shiftx+originx+shiftxwhy, originy
set size sizex2, sizey2
xstart=11
set xrange [xstart:xstart+2]

plot 	path."ci0.2/wholecell.txt" u ($1/1000):2 w l lw 2 lc -1

##################################################################################
set origin sizex2+2*sizex1-3*shiftx+originx+shiftxwhy, originy
set size sizex2, sizey2
xstart=22
set xrange [xstart:xstart+2]

plot 	path."ci0.3/wholecell.txt" u ($1/1000):2 w l lw 2 lc -1


