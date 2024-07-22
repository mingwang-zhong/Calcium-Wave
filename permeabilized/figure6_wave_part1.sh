reset

set term pdfcairo enhanced color size 7,4 font 'Helvetica,12' background rgb "#ffffff"

set output "wave_transition.pdf"
set multiplot 

originx=0.05
sizex1=0.17 # ci = 0.1, ci = 0.2 linescanes
sizex2=0.31 # ci = 0.3, ci = 0.4 linescanes
shiftx=0.028 # left shift of ci=0.1,0.2,0.3,0.4 linescanes
sizey=0.29
shifty=0.05 
shifty2=0.08 
shiftxwhy=0.018 # don't understand why I should add this

unset key
brick=4
set style arrow 1 nohead lw 3
set style arrow 2 nohead lw 1.5
set style arrow 3 nohead lw 5
#########################################

set origin 0.02,2*(sizey-shifty)
set size 0.32,2*sizey-0.04

set border 15 linewidth 1
set tics out nomirror scale 0.6

set label 5 "{/:Bold A}" at graph -0.43,0.95 font ",18"

set xrange [1.5:12.5]
set xtics 4 offset -0.4,0.6
set mxtics 4
set xlabel "H" offset 0,1.2

set yrange [0.0875:0.4125]
set ytics 0.1 offset 0.6
set mytics 2
set ylabel "[Ca^{2+}]_i (μM)" offset 2

# set y2range [-0.5:5.5]
# # Try to add white grid lines
# set x2tics 1 scale 0,0.001 format ''
# set y2tics 1 scale 0,0.001 format ''
# set mx2tics 2
# set my2tics 2
# set x2range [-0.5:6.5]
# set grid front mx2tics my2tics lw 0.5 lt -1 lc rgb 'white'

# set palette defined (0 '#3B37A3', 1 "#00A4C5", 2 159.0/255 217.0/255 246.0/255 , 3 "#994F00")
set palette defined (0 "#00A4C5", 1 "#994F00", 2 "#F5BD43", 3 "#E388AD")
unset colorbox

plot 	'data.txt' matrix u ($1+2):($2*0.025+0.1):3 w image pixels,\
		"<echo '5 0.20'" w p pt 5 ps 0.8 lc 9,\
		"<echo '6 0.20'" w p pt 7 ps 0.8 lc 9,\
		"<echo '5 0.20'" w p pt 5 ps 0.6 lc rgb "#ffffff",\
		"<echo '6 0.20'" w p pt 7 ps 0.6 lc rgb "#ffffff"


set palette defined (0 '#3B37A3', 0.5 '#c63361',  1 '#f5c344' ) # 0.33333 '#4286de', 
unset grid
set cbrange [*:*]
# ##################################################################################
set origin 0.51, 3*(sizey-shifty)+0.01
set size 0.507, sizey

set border 0

set label 5 "{/:Bold B}" at graph -0.08,0.9

set xrange [3:6]
unset xtics
unset xlabel
# # set format x ""

set yrange [0:105]
unset ytics
unset ylabel
# # set format y ""

set cbrange [1:2]
set colorbox noborder 
set cbtics nomirror 1 in offset -1.2
set mcbtics 2
set cblabel "F/F_0" rotate by 90 offset -0.5
set cbtics add('1'1) offset 0,0.5
set cbtics add('2'2, '3'3) offset 0,0

plot 	"Hill5_alpha0.2_beta0.004_cstar1.1/ci0.2/fluoxt.txt" every :brick u ($1/1000):2:($3/6) w image

unset label 5
##################################################################################
set origin 0.51, 2*(sizey-shifty)
set size 0.507, sizey
xstart=2.9
set xrange [xstart:xstart+3]
set arrow 1 from xstart,-4 to xstart+0.5,-4 as 1
set label 1 "0.5 s" at xstart+0.1,-11
set arrow 2 from xstart-0.05,20 to xstart-0.05,70 as 1
set label 2 "50 μm" at xstart-0.15,25 rotate by 90

set cbrange [1:3]
set cbtics add('3'3) offset 0,-0.5
set cbtics add('1'1, '2'2) offset 0,0

plot 	"Hill6_alpha0.2_beta0.004_cstar1.1/ci0.2/fluoxt.txt" every :brick u ($1/1000):2:($3/7) w image


path="Hill7_alpha0.2_beta0.004_cstar1.1/"

unset colorbox
##################################################################################
##################################################################################
##################################################################################
##################################################################################
##################################################################################
set origin originx, sizey-shifty2
set size sizex1+shiftxwhy, sizey

set label 5 "{/:Bold C}" at graph -0.4,1 font ",18"

xstart=11
set xrange [xstart:xstart+1]
set cbrange [1:3]
# set xtics nomirror 1
set arrow 1 from xstart+0.1,-5 to xstart+0.6,-5
set label 1 "0.5 s" at xstart+0.2,-15
set arrow 2 from xstart-0.05,60 to xstart-0.05,90 as 1
set label 2 "30 μm" at xstart-0.15,55 rotate by 90
set label 3 "0.1 μM" at xstart+0.1,95 front tc rgb "#ffffff"
set arrow 4 from xstart-0.05,23.85 to xstart+0.02,23.85 as 3

plot 	path."ci0.1/fluoxt.txt" every :brick u ($1/1000):2:($3/4.3) w image

unset arrow 1
unset label 1
unset arrow 2
unset label 2
unset label 5
##################################################################################
set origin (sizex1-shiftx+originx+shiftxwhy), sizey-shifty2
set size sizex1, sizey
xstart=11
set xrange [xstart:xstart+1]
set label 3 "0.15 μM" at xstart+0.1,95
set arrow 4 from xstart-0.05,23.85 to xstart+0.02,23.85 as 3

plot 	path."ci0.15/fluoxt.txt" every :brick u ($1/1000):2:($3/6) w image


##################################################################################
set origin (2*sizex1-2*shiftx+originx+shiftxwhy), sizey-shifty2
set size sizex2, sizey
xstart=11
set xrange [xstart:xstart+2]
# set cbrange [1:3]
set label 3 "0.2 μM" at xstart+0.1,95
set arrow 4 from xstart-0.05,18 to xstart+0.02,18 as 3

plot 	path."ci0.2/fluoxt.txt" every :brick u ($1/1000):2:($3/7) w image


##################################################################################
set origin (sizex2+2*sizex1-3*shiftx+originx+shiftxwhy), sizey-shifty2
set size sizex2, sizey
xstart=22
set xrange [xstart:xstart+2]
# set cbrange [1:4]
set label 3 "0.3 μM" at xstart+0.4,95
set arrow 4 from xstart-0.05,43.2 to xstart+0.02,43.2 as 3
# set cbtics 1 nomirror offset 0,0.7
# set colorbox horizontal user origin 0.4,0.275 size 0.2,0.02 noborder
# set label 4 "F/F_0" at graph -1.1,-0.15


set colorbox user origin (sizex2+2*sizex1-3*shiftx+originx+shiftxwhy)+sizex2-0.018, sizey-shifty2+0.03 size 0.018,sizey-0.06 noborder
set cbtics nomirror 1 offset -1.2,0 scale 0.3
set cbrange [1:3]
set cblabel "F/F_0" offset -1,0

plot 	path."ci0.3/fluoxt.txt" every :brick u ($1/1000):2:($3/9) w image


unset arrow 4

set yrange [*:*]
######################################################
# set origin originx, sizey
# set size sizex, sizey

# plot 	path."ci0.1/fluoxt.txt" u ($1/1000):( ($2==18)?$3:1/0 ) w p pt 5 ps 0.1


# ######################################################
# set origin sizex-shiftx+originx, sizey
# set size sizex, sizey

# plot 	path."ci0.2/fluoxt.txt" u ($1/1000):( ($2==18)?$3:1/0 ) w p pt 5 ps 0.1


# ######################################################
# set origin 2*sizex-2*shiftx+originx, sizey
# set size sizex, sizey

# plot 	path."ci0.3/fluoxt.txt" u ($1/1000):( ($2==18)?$3:1/0 ) w p pt 5 ps 0.1


# ######################################################
# set origin 3*sizex-3*shiftx+originx, sizey
# set size sizex, sizey

# plot 	path."ci0.4/fluoxt.txt" u ($1/1000):( ($2==18)?$3:1/0 ) w p pt 5 ps 0.1


set yrange [0.8:5]
##################################################################################

set origin originx-0.016, 0
set size sizex1+shiftxwhy+0.016, sizey-0.02

# set border 2
set label 5 "{/:Bold D}" at graph -0.4,0.7 font ",18"
xstart=11
set xrange [xstart:xstart+1]
set yrange [0.8:5.2]
# set ytics out scale 0.5 nomirror 2 offset 1
# set ytics add('1'1)
# set mytics 2
set ylabel "F/F_0" offset -1,-0.7

plot 	path."ci0.1/fluoxt2.txt" u ($1/1000):($30/4.3) w l lw 2 lc 9

set border 0
unset ytics 
unset ylabel
unset label 5

##################################################################################
set origin (sizex1-shiftx+originx+shiftxwhy), 0
set size sizex1, sizey-0.02
xstart=11
set xrange [xstart:xstart+1]

plot 	path."ci0.15/fluoxt2.txt" u ($1/1000):($31/6) w l lw 2 lc 9

##################################################################################
set origin 2*sizex1-2*shiftx+originx+shiftxwhy, 0
set size sizex2, sizey-0.02
xstart=11
set xrange [xstart:xstart+2]

plot 	path."ci0.2/fluoxt2.txt" u ($1/1000):($22/7.5) w l lw 2 lc 9


##################################################################################
set origin sizex2+2*sizex1-3*shiftx+originx+shiftxwhy, 0
set size sizex2, sizey-0.02
xstart=22
set xrange [xstart:xstart+2]

plot 	path."ci0.3/fluoxt2.txt" u ($1/1000):($50/9) w l lw 2 lc 9



##################################################################################
set origin 0,0
set size 1,1
set border 0
unset y2tics
unset y2label
set xrange [0:100]
set yrange [0:100]

startx=33
starty=65
set label 1 "Wave" at startx+2,starty+24
set label 2 "Broken wave" at startx+2,starty+16
set label 3 "Mini-wave" at startx+2,starty+8 tc lt 9
set label 4 "Spark" at startx+2,starty
# set style rect noborder
set object 1 rect from startx-1.3,starty-4 to startx+12,starty+28 fc rgb "#E0E0E0" fs solid 1 border rgb "#E0E0E0" back


plot	200,\
		"<echo '52 90'" w p pt 5 ps 0.8 lc 9,\
		"<echo '52 70'" w p pt 7 ps 0.8 lc 9,\
		"<echo '52 90'" w p pt 5 ps 0.6 lc rgb "#ffffff",\
		"<echo '52 70'" w p pt 7 ps 0.6 lc rgb "#ffffff",\
		"<echo '33 65'" w p pt 5 ps 1.2 lc rgb "#00A4C5",\
		"<echo '33 73'" w p pt 5 ps 1.2 lc rgb "#994F00",\
		"<echo '33 81'" w p pt 5 ps 1.2 lc rgb "#F5BD43",\
		"<echo '33 89'" w p pt 5 ps 1.2 lc rgb "#E388AD"

################################################################################## ytics to panel D
set origin originx-0.023, 0
set size sizex1+0.016+shiftxwhy, sizey-0.02

set border 2
set ytics out scale 0.5
set yrange [0.9:5.2]
set ytics nomirror 2 offset 0.5
set mytics 2
set xrange [0:10]
set arrow from -0.01,4.01 to -0.01,5.2 nohead lw 5 lc rgb "#ffffff" front

plot 100



unset multiplot
set term qt


reset